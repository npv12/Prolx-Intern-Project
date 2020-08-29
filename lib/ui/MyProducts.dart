import 'package:Prolx/ui/productPage.dart';
import 'package:flutter/material.dart';
import '../Widget/MyProductitem.dart';

class MyProducts extends StatelessWidget {
  final List<String> entries = <String>['A', 'B', 'C', 'D'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: AddButton(),
      body: MyProductItem(),
    );
  }
}

class AddButton extends StatefulWidget {
  AddButton({Key key}) : super(key: key);

  @override
  _AddButtonState createState() => _AddButtonState();
}

class _AddButtonState extends State<AddButton> {
  bool _show = true;
  @override
  Widget build(BuildContext context) {
    return _show
        ? FloatingActionButton(
            splashColor: Colors.pink[200],
            child: Icon(Icons.add_circle_outline),
            onPressed: () {
              var sheetController = showBottomSheet(
                  elevation: 15,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  context: context,
                  builder: (context) => ProductPage());

              _showButton(false);

              sheetController.closed.then((value) {
                _showButton(true);
              });
            },
          )
        : SizedBox(width: 138);
  }

  void _showButton(bool value) {
    setState(() {
      _show = value;
    });
  }
}
