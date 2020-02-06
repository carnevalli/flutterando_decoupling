import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_modular/flutter_modular_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutterando_decoupling/app/app_module.dart';

import 'package:flutterando_decoupling/app/modules/home/home_controller.dart';
import 'package:flutterando_decoupling/app/modules/home/home_module.dart';
import 'package:flutterando_decoupling/app/share/repositories/localstorage/local_storage_interface.dart';
import 'package:mockito/mockito.dart';

class LocalStorageMock implements ILocalStorage {
  List<String> storage;
  @override
  Future delete(String key) {
    return null;
  }

  @override
  Future<List<String>> get(String key) {
    return Future.value(storage);
  }

  @override
  Future put(String key, List<String> value) {
    storage = value;
  }

}

void main() {
 initModule(AppModule(), changeBinds: [
    Bind<ILocalStorage>((i) => LocalStorageMock()),
  ]);
  initModule(HomeModule());

  test('click save', () async {

    final HomeController controller = Modular.get();
    String text = 'test';
    controller.setText(text);
    controller.save();
    expect(controller.list.length, 1);
    expect(controller.list[0], text);

    List<String> listStorage = await Modular.get<ILocalStorage>().get('key');
    expect(listStorage[0], 'test');
  });

  test('click remove', () async {
    //arrange
    final HomeController controller = Modular.get();
    String text = 'test';
    controller.setText(text);
    controller.save();

    //act
    controller.remove(0);

    //assert
    expect(controller.list.length, 0);

    List<String> listStorage = await Modular.get<ILocalStorage>().get('key');
    expect(listStorage.isEmpty, true);
  });
}
