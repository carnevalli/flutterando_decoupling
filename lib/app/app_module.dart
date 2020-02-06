import 'package:flutterando_decoupling/app/app_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';
import 'package:flutterando_decoupling/app/app_widget.dart';
import 'package:flutterando_decoupling/app/modules/home/home_module.dart';
import 'package:flutterando_decoupling/app/share/repositories/localstorage/local_storage_hive.dart';
import 'package:flutterando_decoupling/app/share/repositories/localstorage/local_storage_interface.dart';
import 'package:flutterando_decoupling/app/share/repositories/localstorage/local_storage_shared.dart';

class AppModule extends MainModule {
  @override
  List<Bind> get binds => [
        Bind((i) => AppController()),
        // Bind<ILocalStorage>((i) => LocalStorageHive()),
        Bind<ILocalStorage>((i) => LocalStorageShared()),
      ];

  @override
  List<Router> get routers => [
        Router('/', module: HomeModule()),
      ];

  @override
  Widget get bootstrap => AppWidget();

  static Inject get to => Inject<AppModule>.of();
}
