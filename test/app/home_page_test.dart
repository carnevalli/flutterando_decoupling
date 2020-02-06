import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_modular/flutter_modular_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutterando_decoupling/app/app_module.dart';
import 'package:flutterando_decoupling/app/app_widget.dart';
import 'package:flutterando_decoupling/app/modules/home/home_controller.dart';
import 'package:flutterando_decoupling/app/modules/home/home_module.dart';
import 'package:flutterando_decoupling/app/modules/home/home_page.dart';
import 'package:flutterando_decoupling/app/share/repositories/localstorage/local_storage_interface.dart';

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
  initModule(AppModule());
  initModule(HomeModule());

  
  testWidgets('changes in TextField should reflect on @observable text at controller', (WidgetTester tester) async {

    HomeController controller = Modular.get();
    String text = 'test 123 123';

    await tester.pumpWidget(buildTestableWidget(HomePage(title: 'teste')));
    Finder textField = find.descendant(of: find.byType(AppBar), matching: find.byType(TextField));

    await tester.enterText(textField, text);
    await tester.pump();

    expect(controller.text, equals(text));
    
  });

  testWidgets('changes in @observable at controller should reflect on TextField', (WidgetTester tester) async {
    HomeController controller = Modular.get();
    String text = 'test 123 123';

    await tester.pumpWidget(buildTestableWidget(HomePage(title: 'teste')));
    controller.setText(text);

    TextField textField = find.byType(TextField).first.evaluate().single.widget as TextField;

    expect(textField.controller.text, equals(text));
  });
}