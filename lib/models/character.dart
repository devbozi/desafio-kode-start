class Character {
  final int id;
  final String name;
  final String image;
  final String species;
  final String gender;
  final String status;
  final String origin;
  final String location;
  final String firstAppearance;

  Character({
    required this.id,
    required this.name,
    required this.image,
    required this.species,
    required this.gender,
    required this.status,
    required this.origin,
    required this.location,
    required this.firstAppearance,
  });

  factory Character.fromJson(Map<String, dynamic> json) {
    return Character(
      id: json['id'] ?? 0,
      name: (json['name'] ?? '').toString().toUpperCase(),
      image: json['image'] ?? '',
      species: json['species'] ?? 'Unknown',
      gender: json['gender'] ?? 'Unknown',
      status: json['status'] ?? 'Unknown',
      origin: json['origin']?['name'] ?? 'Unknown',
      location: json['location']?['name'] ?? 'Unknown',
      firstAppearance: '',
    );
  }

  Character copyWithFirstAppearance(String appearance) {
    return Character(
      id: id,
      name: name,
      image: image,
      species: species,
      gender: gender,
      status: status,
      origin: origin,
      location: location,
      firstAppearance: appearance,
    );
  }

  @override
  String toString() => 'Character(id: $id, name: $name)';
}