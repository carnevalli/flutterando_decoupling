import 'dart:async';
import 'package:flutterando_decoupling/app/share/repositories/localstorage/local_storage_interface.dart';
import 'package:hive/hive.dart';
import "package:hive_flutter/hive_flutter.dart";
// import "package:path_provider/path_provider.dart";

class LocalStorageHive implements ILocalStorage{

  Completer<Box> _instance = Completer<Box>();

  _init() async {
    // if(! kIsWeb) {
    //   var dir = await getApplicationDocumentsDirectory();
    //   Hive.init(dir.path);
    // }
    var box = await Hive.openBox('db');
    _instance.complete(box);
  }

  LocalStorageHive() {
    this._init();
  }


  @override
  Future delete(String key) async {
    var box = await _instance.future;
    box.delete(key);
  }

  @override
  Future<List<String>> get(String key) async {
    var box = await _instance.future;
    Future<List<String>> result = box.get(key);
    return result;
  }

  @override
  Future put(String key, List<String> value) async {
    var box = await _instance.future;
    var result = box.put(key, value);
    return result;
  }

}