import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutterando_decoupling/app/modules/home/home_controller.dart';

class ItemWidget extends StatelessWidget {
  final HomeController controller = Modular.get();
  final int index;

  ItemWidget({Key key, this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String element = controller.list[index];
    return ListTile(
      title: Text(element),
      trailing: IconButton(
        icon: Icon(Icons.cancel, color: Colors.red),
        onPressed: (){
          controller.remove(index);
        },
      ),
    );
  }
}
