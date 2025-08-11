class ApiEndpoints {
  static const String baseUrl = 'https://rickandmortyapi.com/api';
  static const String characters = '$baseUrl/character';
  static String characterById(int id) => '$characters/$id';
}