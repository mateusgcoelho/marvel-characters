import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:heroes/domain/entities/character_entity.dart';
import 'package:heroes/infra/data/character_repository_impl.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'character_repository_impl_test.mocks.dart';

@GenerateMocks([Dio])
void main() {
  late CharacterRepositoryImpl repository;
  late MockDio mockDio;

  setUp(() {
    mockDio = MockDio();

    final responseData = {
      "data": {
        "results": [
          {
            "id": 1,
            "name": "Alice",
            "description": "Personagem principal",
            "thumbnail": {
              "path": "imagem",
              "extension": "jpg",
            },
          },
        ]
      }
    };

    when(
      mockDio.get(
        'characters',
        queryParameters: anyNamed('queryParameters'),
      ),
    ).thenAnswer(
      (_) async => Response(
        data: responseData,
        statusCode: 200,
        requestOptions: RequestOptions(),
      ),
    );

    repository = CharacterRepositoryImpl(mockDio);
  });

  group('CharacterRepositoryImpl | ', () {
    test(
        'Dado uma solicitação de personagens bem-sucedida, Quando getCharacters é chamado, Então deve retornar uma lista de CharacterEntity',
        () async {
      final characters = await repository.getCharacters(page: 1);

      expect(characters, isA<List<CharacterEntity>>());
      expect(characters.length, 1);
      expect(characters[0].id, 1);
      expect(characters[0].name, "Alice");
    });

    test(
        'Dado uma solicitação de personagens com erro, Quando getCharacters é chamado, Então deve lançar uma exceção',
        () async {
      when(
        mockDio.get(
          'characters',
          queryParameters: anyNamed('queryParameters'),
        ),
      ).thenThrow(Exception());

      expect(() => repository.getCharacters(page: 1), throwsException);
    });
  });
}
