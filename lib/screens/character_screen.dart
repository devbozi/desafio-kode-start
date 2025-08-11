import 'package:desafio_code/services/api_service.dart';
import 'package:desafio_code/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/character.dart';

class CharacterScreen extends StatefulWidget {
  final Character character;

  const CharacterScreen({required this.character, super.key});

  @override
  State<CharacterScreen> createState() => _CharacterScreenState();
}

class _CharacterScreenState extends State<CharacterScreen> {
  late Future<Character> _detailedCharacter;

  @override
  void initState() {
    super.initState();
    _detailedCharacter = ApiService().fetchCharacterDetails(widget.character);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: CustomAppBar(
        leftIcon: InkWell(
          onTap: () => Navigator.pop(context),
          child: Icon(Icons.arrow_back, color: Colors.white, size: 20.97),
        ),
      ),
      body: FutureBuilder<Character>(
        future: _detailedCharacter,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError || !snapshot.hasData) {
            return Center(
              child: Text(
                'Error loading character',
                style: TextStyle(color: Colors.white),
              ),
            );
          }

          final character = snapshot.data!;

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 17),
              child: Card(
                color: Color(0xFF87A1FA),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    Hero(
                      tag: character.image,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(
                          character.image,
                          height: 160,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder:
                              (context, error, stackTrace) => Container(
                                height: 160,
                                color: Colors.grey[800],
                                alignment: Alignment.center,
                                child: Icon(
                                  Icons.broken_image,
                                  color: Colors.white70,
                                ),
                              ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 12),
                    
                    Padding(
                      padding: const EdgeInsets.only(left: 16, right: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            character.name,
                            style: GoogleFonts.lato(
                              textStyle: TextStyle(
                                fontSize: 14.5,
                                fontWeight: FontWeight.w900,
                                color: Colors.white,
                              ),
                            ),
                          ),

                          const SizedBox(height: 38),

                          Row(
                            children: [
                              Column(
                                children: [
                                  Container(
                                    width: 8,
                                    height: 8,
                                    decoration: BoxDecoration(
                                      color: Colors.red,
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: Colors.white,
                                        width: 1,
                                      ),
                                    ),
                                    margin: const EdgeInsets.only(right: 8),
                                  ),
                                ],
                              ),
                              Text(
                                character.status,
                                style: GoogleFonts.lato(
                                  textStyle: _infoStyle(),
                                ),
                              ),
                              Text(
                                ' - ',
                                style: GoogleFonts.lato(
                                  textStyle: _infoStyle(),
                                ),
                              ),
                              Text(
                                character.species,
                                style: GoogleFonts.lato(
                                  textStyle: _infoStyle(),
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: 15),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _infoRow(
                                      "Last known location",
                                      character.firstAppearance,
                                    ),
                                    _infoRow(
                                      "First seen in",
                                      character.location,
                                    ),
                                  ],
                                ),
                              ),

                              SizedBox(width: 10),

                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  _infoRow(
                                    "Gender",
                                    character.gender,
                                    alignment: CrossAxisAlignment.end,
                                  ),
                                  _infoRow(
                                    "Origin",
                                    character.origin,
                                    alignment: CrossAxisAlignment.end,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 43),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  TextStyle _infoStyle() => const TextStyle(
    fontSize: 12.5,
    fontWeight: FontWeight.w500,
    color: Colors.white,
  );

  Widget _infoRow(
    String label,
    String value, {
    CrossAxisAlignment alignment = CrossAxisAlignment.start,
  }) {
    return Column(
      crossAxisAlignment: alignment,
      children: [
        Text(
          "$label: ",
          style: GoogleFonts.lato(
            textStyle: const TextStyle(
              fontSize: 12.5,
              fontWeight: FontWeight.w300,
              color: Colors.white,
            ),
          ),
        ),
        SizedBox(height: 4),
        Text(
          value,
          style: GoogleFonts.lato(
            textStyle: const TextStyle(
              fontSize: 12.5,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
          softWrap: true,
          overflow: TextOverflow.visible,
        ),
        SizedBox(height: 15),
      ],
    );
  }
}
