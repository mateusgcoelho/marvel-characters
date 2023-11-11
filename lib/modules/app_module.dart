import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:heroes/modules/home/home_module.dart';
import 'package:heroes/shared/constants/keys.dart';

class AppModule extends Module {
  @override
  void binds(Injector i) {
    i.addInstance(
      Dio(
        BaseOptions(
          baseUrl: "https://gateway.marvel.com/v1/public/",
          queryParameters: {
            "apikey": Keys.publicKey,
          },
        ),
      ),
    );
  }

  @override
  void routes(RouteManager r) {
    r.module(
      Modular.initialRoute,
      module: HomeModule(),
    );
  }
}
