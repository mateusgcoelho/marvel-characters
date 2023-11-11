import 'package:heroes/domain/entities/character_entity.dart';

abstract class CharacterRepository {
  Future<List<CharacterEntity>> getCharacters({
    required int page,
  });
}
