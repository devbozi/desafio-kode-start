import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:developer';

import '../models/character.dart';
import '../repositories/character_repository.dart';
import '../screens/character_screen.dart';
import '../widgets/search_bar_widget.dart';

class CharacterListScreen extends StatefulWidget {
  const CharacterListScreen({super.key});

  @override
  State<CharacterListScreen> createState() => _CharacterListScreenState();
}

class _CharacterListScreenState extends State<CharacterListScreen> {
  final CharacterRepository _repository = CharacterRepository();
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();

  final List<Character> _characters = [];

  int _currentPage = 1;
  bool _isLoading = false;
  bool _hasMore = true;
  String _searchQuery = '';
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    _loadCharacters();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent - 200 &&
          !_isLoading &&
          _hasMore) {
        _loadCharacters();
      }
    });
  }

  Future<void> _loadCharacters({bool isSearch = false}) async {
    if (!_hasMore || _isLoading) return;

    if (isSearch) {
      setState(() {
        _characters.clear();
        _currentPage = 1;
        _hasMore = true;
        _isSearching = true;
        _searchQuery = _searchController.text.trim();
      });
    } else {
      setState(() => _isLoading = true);
    }

    try {
      final newCharacters = await _repository.fetchCharacters(
        page: _currentPage,
        name: _searchQuery,
      );

      if (!mounted) return;

      setState(() {
        _characters.addAll(newCharacters);
        _currentPage++;
        _hasMore = newCharacters.isNotEmpty;
        _isLoading = false;
        _isSearching = false;
      });
    } catch (e, stackTrace) {
      if (!mounted) return;

      setState(() {
        _isLoading = false;
        _isSearching = false;
      });

      log('Erro ao buscar personagens: $e', name: 'CharacterList', stackTrace: stackTrace);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error when searching for characters')),
      );
    }
  }

  void _searchCharacters() => _loadCharacters(isSearch: true);

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SearchBarWidget(
          controller: _searchController,
          onSearch: _searchCharacters,
          isLoading: _isSearching,
        ),
        Expanded(
          child: _characters.isEmpty && !_isLoading
              ? Center(
                  child: Text(
                    'No characters found',
                    style: GoogleFonts.lato(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white70,
                    ),
                  ),
                )
              : ListView.builder(
                  controller: _scrollController,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemCount: _characters.length + (_isLoading ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index == _characters.length) {
                      return const Center(
                        child: Padding(
                          padding: EdgeInsets.all(16),
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }

                    final character = _characters[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 15),
                      child: InkWell(
                        splashColor: Colors.white24,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  CharacterScreen(character: character),
                            ),
                          );
                        },
                        child: Card(
                          color: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ClipRRect(
                                borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(10),
                                ),
                                child: Image.network(
                                  character.image,
                                  height: 120,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) =>
                                      Container(
                                    height: 120,
                                    color: Colors.grey[800],
                                    alignment: Alignment.center,
                                    child: const Icon(
                                      Icons.broken_image,
                                      color: Colors.white70,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                height: 40,
                                width: double.infinity,
                                decoration: const BoxDecoration(
                                  color: Color(0xFF87A1FA),
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(10),
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    top: 12,
                                    bottom: 11,
                                    left: 16,
                                  ),
                                  child: Text(
                                    character.name,
                                    textAlign: TextAlign.start,
                                    style: GoogleFonts.lato(
                                      textStyle: const TextStyle(
                                        fontSize: 14.5,
                                        fontWeight: FontWeight.w900,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }
}