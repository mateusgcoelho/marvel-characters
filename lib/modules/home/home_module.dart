import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:heroes/domain/repositories/character_repository.dart';
import 'package:heroes/infra/data/character_repository_impl.dart';
import 'package:heroes/modules/home/home_page.dart';
import 'package:heroes/modules/home/home_presenter.dart';
import 'package:heroes/modules/home/home_store.dart';

class HomeModule extends Module {
  @override
  void binds(Injector i) {
    i.addLazySingleton<CharacterRepository>(
      () => CharacterRepositoryImpl(
        i.get<Dio>(),
      ),
    );
    i.addLazySingleton(
      () => HomeStore(),
    );
    i.addLazySingleton(
      () => HomePresenter(
        i.get<CharacterRepository>(),
        i.get<HomeStore>(),
      ),
    );
  }

  @override
  void routes(RouteManager r) {
    r.child(Modular.initialRoute, child: (context) {
      return const HomePage();
    });
  }
}
