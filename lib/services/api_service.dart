import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/character.dart';

class ApiService {
  final String baseUrl = 'https://rickandmortyapi.com/api';

  Future<Map<String, dynamic>> get(String url) async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode != 200) {
      throw Exception('Error loading data from API');
    }

    return jsonDecode(response.body);
  }

  /// Busca lista de personagens com paginação e filtro por nome
  Future<List<Character>> fetchCharacters({int page = 1, String? name}) async {
  final queryParams = [
    'page=$page',
    if (name != null && name.isNotEmpty) 'name=$name',
  ].join('&');

  final url = '$baseUrl/character?$queryParams';

  final data = await get(url);
  final List results = data['results'];

  return results.map((json) => Character.fromJson(json)).toList();
}

  /// Busca detalhes do personagem e nome do primeiro episódio
  Future<Character> fetchCharacterDetails(Character character) async {
    final characterData = await get('$baseUrl/character/${character.id}');

    final episodes = characterData['episode'];
    if (episodes == null || episodes.isEmpty) {
      return character.copyWithFirstAppearance('Unknown');
    }

    final firstEpisodeUrl = episodes[0];
    final episodeData = await get(firstEpisodeUrl);

    final firstAppearance =
        '${episodeData['name']} (${episodeData['air_date']})';

    return character.copyWithFirstAppearance(firstAppearance);
  }
}
