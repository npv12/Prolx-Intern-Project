import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProductPage extends StatefulWidget {
  ProductPage({Key key}) : super(key: key);

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  Widget _nameTextField() {
    return Material(
      elevation: 10.0,
      shadowColor: Colors.black,
      child: TextField(
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(35))),
      ),
    );
  }

  Widget _descriptionTextField() {
    return Material(
      elevation: 10.0,
      shadowColor: Colors.black,
      child: TextField(
        keyboardType: TextInputType.text,
        maxLines: 20,
        decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(35))),
      ),
    );
  }

  File _image;
  Future getImage() async {
    final image = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      _image = null;
    });
  }

  Widget _addphotoTextField() {
    return Material(
      elevation: 10.0,
      shadowColor: Colors.black,
      child: TextField(
        decoration: InputDecoration(
            prefixIcon:
                IconButton(icon: Icon(Icons.add_a_photo), onPressed: null),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(35))),
      ),
    );
  }

  Widget _askpriceTextField() {
    return Material(
      elevation: 10.0,
      shadowColor: Colors.black,
      child: TextField(
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(35))),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: null),
        title: Text("Add Product"),
      ),
      body: ListView(
        padding: EdgeInsets.all(8),
        children: <Widget>[
          ListTile(
            title: Text("Name"),
          ),
          _nameTextField(),
          ListTile(
            title: Text("Description"),
          ),
          _descriptionTextField(),
          ListTile(
            title: Text("Add photos"),
          ),
          _addphotoTextField(),
          ListTile(
            title: Text("Ask Price"),
          ),
          _askpriceTextField(),
          SizedBox(
            height: 100,
          ),
          RaisedButton(
              child: Text(
                "Auction it",
                style: TextStyle(color: Colors.redAccent),
              ),
              onPressed: null,
              shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(35.0),
              ))
        ],
      ),
    );
  }
}
