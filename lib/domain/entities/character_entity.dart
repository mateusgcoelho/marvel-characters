class CharacterEntity {
  int id;
  String name;
  String description;
  String thumbnail;

  CharacterEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.thumbnail,
  });

  factory CharacterEntity.fromJson(Map<String, dynamic> json) {
    return CharacterEntity(
      id: json["id"],
      name: json["name"],
      description: json["description"],
      thumbnail:
          json["thumbnail"]["path"] + "." + json["thumbnail"]["extension"],
    );
  }
}
