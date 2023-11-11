import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:heroes/domain/entities/character_entity.dart';
import 'package:heroes/domain/repositories/character_repository.dart';
import 'package:heroes/shared/constants/keys.dart';

class CharacterRepositoryImpl implements CharacterRepository {
  final Dio _dio;

  CharacterRepositoryImpl(this._dio);

  @override
  Future<List<CharacterEntity>> getCharacters({
    required int page,
  }) async {
    var ts = DateTime.now().timeZoneOffset.inMilliseconds;
    var hash = md5
        .convert(utf8.encode("$ts${Keys.privateKey}${Keys.publicKey}"))
        .toString();

    final response = await _dio.get(
      'characters',
      queryParameters: {
        "ts": ts,
        "hash": hash,
        "limit": 10,
        "offset": (page - 1) * 10,
      },
    );

    List<CharacterEntity> characters = [];

    for (var json in response.data["data"]["results"]) {
      characters.add(CharacterEntity.fromJson(json));
    }

    return characters;
  }
}
