import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutterando_decoupling/app/share/components/observable_text_editing_controller.dart';
import 'package:flutterando_decoupling/app/share/repositories/localstorage/local_storage_interface.dart';
import 'package:mobx/mobx.dart';

part 'home_controller.g.dart';

class HomeController = _HomeBase with _$HomeController;

abstract class _HomeBase with Store {
  final ILocalStorage _storage = Modular.get();
  
  TextEditingController textController = TextEditingController();

  @observable
  String text = '';
  @action
  void setText(String value) {
    this.text = value;
    this.textController.text = value;
  }

  @computed
  bool get canSubmit => text.length > 2;

  @observable
  ObservableList<String> list = <String>[].asObservable();

  _HomeBase() {
    this.init();
  }

  @action
  init() async {
    textController.addListener(() {
      this.text = textController.text;
    });

    List<String> listLocal = await _storage.get('list');
    if(listLocal == null) {
      list = <String>[].asObservable();
    }else{
      list = listLocal.asObservable();
    }
  }

  @action
  void save() {
    list.add(text);
    _storage.put('list', list);
    this.setText("");
  }

  @action
  void remove(int index) {
    list.removeAt(index);
    _storage.put('list', list);
  }
}
