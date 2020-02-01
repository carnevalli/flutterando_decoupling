import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutterando_decoupling/app/share/repositories/localstorage/local_storage_hive.dart';
import 'package:flutterando_decoupling/app/share/repositories/localstorage/local_storage_interface.dart';
import 'package:mobx/mobx.dart';

part 'home_controller.g.dart';

class HomeController = _HomeBase with _$HomeController;

abstract class _HomeBase with Store {
  final ILocalStorage _storage = Modular.get();
  
  @observable
  String text = '';

  @computed
  bool get canSubmit => text.length > 2;

  @action
  void setText(String value) => this.text = value;

  @observable
  ObservableList<String> list = <String>[].asObservable();

  _HomeBase() {
    print('_HomeBase()');
    this.init();
  }

  @action
  init() async {
    print('init() start');
    List<String> listLocal = await _storage.get('list');
    print('init() listLocal');
    if(listLocal == null) {
      list = <String>[].asObservable();
      print('list not found');
    }else{
      list = listLocal.asObservable();
      print("found a list with ${list.length} elements.");
    }
  }

  @action
  void save() {
    print('save()');
    list.add(text);
    _storage.put('list', list);
  }

  @action
  void remove(int index) {
    list.removeAt(index);
    _storage.put('list', list);
  }
}
