import 'package:heroes/modules/home/home_state.dart';
import 'package:mobx/mobx.dart';

part 'home_store.g.dart';

class HomeStore = HomeStoreBase with _$HomeStore;

abstract class HomeStoreBase with Store {
  @observable
  HomeState pageState = LoadingHomeState();

  void setPageState(HomeState pageState) {
    this.pageState = pageState;
  }
}
