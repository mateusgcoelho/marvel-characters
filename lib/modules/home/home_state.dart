import 'package:heroes/domain/entities/character_entity.dart';

abstract class HomeState {
  final List<CharacterEntity> characters;
  final int page;

  HomeState({
    required this.characters,
    required this.page,
  });
}

class ErrorHomeState extends HomeState {
  ErrorHomeState({
    super.page = 1,
  }) : super(
          characters: [],
        );
}

class LoadingHomeState extends HomeState {
  LoadingHomeState({
    super.page = 1,
  }) : super(
          characters: [],
        );
}

class LoadedHomeState extends HomeState {
  LoadedHomeState({
    required super.characters,
    super.page = 1,
  });

  LoadedHomeState copyWith({
    int? page,
  }) {
    return LoadedHomeState(
      characters: characters,
      page: page ?? this.page,
    );
  }
}
