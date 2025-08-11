import '../models/character.dart';
import '../services/api_service.dart';

class CharacterRepository {
  final ApiService _apiService = ApiService();

  Future<List<Character>> fetchCharacters({int page = 1, String? name}) {
    return _apiService.fetchCharacters(page: page, name: name);
  }
}