import 'package:flutter_test/flutter_test.dart';
import 'package:heroes/domain/entities/character_entity.dart';

void main() {
  group('CharacterEntity | ', () {
    test(
        'Dado uma entidade de personagem, Quando ela for criada, Então ela deve ter as propriedades corretas',
        () {
      final personagem = CharacterEntity(
        id: 1,
        name: 'Alice',
        description: 'Personagem principal',
        thumbnail: 'imagem.jpg',
      );

      expect(personagem.id, 1);
      expect(personagem.name, 'Alice');
      expect(personagem.description, 'Personagem principal');
      expect(personagem.thumbnail, 'imagem.jpg');
    });
  });
}
