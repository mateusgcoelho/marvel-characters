import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:heroes/modules/home/home_presenter.dart';
import 'package:heroes/modules/home/home_state.dart';
import 'package:heroes/modules/home/home_store.dart';
import 'package:heroes/shared/widgets/card_character.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomePresenter presenter = Modular.get<HomePresenter>();
  HomeStore store = Modular.get<HomeStore>();

  @override
  void initState() {
    super.initState();
    presenter.loadCharacters();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      bool isLoading = store.pageState is LoadingHomeState;

      Widget? body;

      if (store.pageState is LoadingHomeState) {
        body = const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: CircularProgressIndicator(
                color: Colors.red,
              ),
            ),
          ],
        );
      } else if (store.pageState is LoadedHomeState) {
        body = GridView.count(
          crossAxisCount: 3,
          padding: const EdgeInsets.all(16),
          children: store.pageState.characters
              .map(
                (character) => CardCharacter(
                  data: character,
                ),
              )
              .toList(),
        );
      } else {
        body = const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Text("Ocorreu um erro ao buscar personagens."),
            ),
          ],
        );
      }

      return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Personagens Marvel",
            style: TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            IconButton(
              onPressed: isLoading || store.pageState.page == 1
                  ? null
                  : () => presenter.previousPage(),
              icon: const Icon(Icons.chevron_left),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
              ),
              child: Text(
                store.pageState.page.toString(),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
            IconButton(
              onPressed: isLoading ? null : () => presenter.nextPage(),
              icon: const Icon(Icons.chevron_right),
            ),
          ],
        ),
        body: body,
      );
    });
  }
}
