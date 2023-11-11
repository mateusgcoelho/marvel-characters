import 'package:heroes/domain/entities/character_entity.dart';
import 'package:heroes/domain/repositories/character_repository.dart';
import 'package:heroes/modules/home/home_state.dart';
import 'package:heroes/modules/home/home_store.dart';

class HomePresenter {
  final CharacterRepository repository;
  final HomeStore store;

  HomePresenter(
    this.repository,
    this.store,
  );

  void loadCharacters() async {
    try {
      store.setPageState(LoadingHomeState());

      List<CharacterEntity> characters = await repository.getCharacters(
        page: 1,
      );

      store.setPageState(
        LoadedHomeState(characters: characters),
      );
    } catch (_) {
      store.setPageState(ErrorHomeState());
    }
  }

  void nextPage() async {
    int newPage = store.pageState.page + 1;

    store.setPageState(LoadingHomeState(
      page: newPage,
    ));

    List<CharacterEntity> characters = await repository.getCharacters(
      page: newPage,
    );

    store.setPageState(
      LoadedHomeState(
        characters: characters,
        page: newPage,
      ),
    );
  }

  void previousPage() async {
    int newPage = store.pageState.page - 1;

    store.setPageState(LoadingHomeState(
      page: newPage,
    ));

    List<CharacterEntity> characters = await repository.getCharacters(
      page: newPage,
    );

    store.setPageState(
      LoadedHomeState(
        characters: characters,
        page: newPage,
      ),
    );
  }
}
