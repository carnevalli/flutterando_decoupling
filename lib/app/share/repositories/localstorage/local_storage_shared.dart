import 'dart:async';
import 'package:flutterando_decoupling/app/share/repositories/localstorage/local_storage_interface.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageShared implements ILocalStorage{

  Completer<SharedPreferences> _instance = Completer<SharedPreferences>();

  _init() async {
    _instance.complete(await SharedPreferences.getInstance());
  }

  LocalStorageShared() {
    this._init();
  }


  @override
  Future delete(String key) async {
    var shared = await _instance.future;
    return shared.remove(key);
  }

  @override
  Future<List<String>> get(String key) async {
    var shared = await _instance.future;
    return shared.getStringList(key);
  }

  @override
  Future put(String key, List<String> value) async {
    var shared = await _instance.future;
    shared.setStringList(key, value);
  }

}