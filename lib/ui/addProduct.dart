import 'dart:io';

import 'package:Prolx/functionalities/firestoreServices.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

class AddProduct extends StatefulWidget {
  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool vis = true;
  List<String> categories = [];
  String dropDownValue = '';
  String prodName;
  String description;
  String price;
  List<File> images = [];
  List<String> sizes = [];
  final picker = ImagePicker();

  Future<void> _error(context, message) async {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            content: Text(
              message,
              style: TextStyle(
                  color: Colors.blueGrey[900],
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w600,
                  fontSize: 15.0),
              textAlign: TextAlign.center,
            ),
            actions: <Widget>[
              FlatButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Icon(
                    Icons.cancel,
                    size: 40.0,
                    color: Colors.redAccent,
                  ))
            ],
          );
        });
  }

  Future getImage() async {
    final tempImage =
        await picker.getImage(source: ImageSource.gallery, imageQuality: 30);
    setState(() {
      images.add(File(tempImage.path));
    });
  }

  Future getImageCam() async {
    final tempImage =
        await picker.getImage(source: ImageSource.camera, imageQuality: 30);
    setState(() {
      images.add(File(tempImage.path));
    });
  }

  void cat() {
    FirestoreService().fgetCategories().then((c) {
      setState(() {
        categories = c;
        dropDownValue = categories[0];
      });
    });
  }

  @override
  void initState() {
    cat();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Form(
        key: _formKey,
        child: Container(
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Icon(Icons.control_point),
                    SizedBox(width: 10),
                    Text('Select Category'),
                  ],
                ),
              ),
              !categories.isNotEmpty
                  ? Text(
                      'loading....',
                      textAlign: TextAlign.center,
                    )
                  : Container(
                      padding: EdgeInsets.only(left: 0, right: 50),
                      child: Center(
                        child: DropdownButton(
                          value: dropDownValue,
                          icon: Icon(Icons.arrow_drop_down),
                          iconSize: 24,
                          elevation: 16,
                          hint: Text('Select category'),
                          style: TextStyle(color: Colors.redAccent),
                          underline: Container(
                            height: 2,
                            color: Colors.redAccent,
                          ),
                          onChanged: (String newValue) {
                            setState(() {
                              dropDownValue = newValue;
                            });
                          },
                          items: categories.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
              // Container(
              //   child: FutureBuilder(
              //     future: FirestoreService().getSubCategories(),
              //     builder: (context, snapshot) {
              //       if (!snapshot.hasData) return Text('loading....');
              //       categories = snapshot.data;
              //       return Container(
              //         padding: EdgeInsets.only(left: 0, right: 50),
              //         child: Center(
              //           child: DropdownButton(
              //             value: dropDownValue,
              //             icon: Icon(Icons.arrow_drop_down),
              //             iconSize: 24,
              //             elevation: 16,
              //             hint: Text('Select category'),
              //             style: TextStyle(color: Colors.indigo[900]),
              //             underline: Container(
              //               height: 2,
              //               color: Colors.indigo[900],
              //             ),
              //             onChanged: (String newValue) {
              //               setState(() {
              //                 dropDownValue = newValue;
              //               });
              //             },
              //             items: categories.map((String value) {
              //               return DropdownMenuItem<String>(
              //                 value: value,
              //                 child: Text(value),
              //               );
              //             }).toList(),
              //           ),
              //         ),
              //       );
              //     },
              //   ),
              // ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Icon(Icons.control_point),
                    SizedBox(width: 10),
                    Text('Enter Product Name'),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(30)),
                  child: TextFormField(
                    //initialValue: prodName,
                    onChanged: (value) {
                      prodName = value;
                    },
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please Enter Product Name';
                      }
                    },
                    decoration: InputDecoration(
                      hintText: 'Product Name',
                      contentPadding: EdgeInsets.symmetric(horizontal: 10),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: BorderSide(color: Colors.transparent),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Icon(Icons.control_point),
                    SizedBox(width: 10),
                    Text('Enter Product Description'),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(30)),
                  child: TextFormField(
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please Enter Product Description';
                      }
                    },
                    //initialValue: description,
                    maxLines: null,
                    onChanged: (value) {
                      description = value;
                    },
                    decoration: InputDecoration(
                      hintText: 'Product Description',
                      contentPadding: EdgeInsets.symmetric(horizontal: 10),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: BorderSide(color: Colors.transparent),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Icon(Icons.control_point),
                    SizedBox(width: 10),
                    Text('Add Product Images'),
                  ],
                ),
              ),
              Column(
                children: [
                  Center(
                    child: Wrap(
                      runSpacing: 7,
                      spacing: 5,
                      children: List.generate(
                        images.length,
                        (index) {
                          return Stack(
                            overflow: Overflow.visible,
                            children: <Widget>[
                              Container(
                                width: MediaQuery.of(context).size.width / 4,
                                height: MediaQuery.of(context).size.width / 4,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: FileImage(
                                        images[index],
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                    borderRadius: BorderRadius.circular(10)),
                              ),
                              Positioned(
                                  top: -10,
                                  right: -10,
                                  child: Container(
                                    child: IconButton(
                                      //iconSize: MediaQuery.of(context).size.width/16,
                                      icon: Icon(Icons.remove_circle),
                                      color: Colors.red,
                                      onPressed: () {
                                        setState(() {
                                          images.removeAt(index);
                                        });
                                      },
                                    ),
                                  ))
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ActionChip(
                      elevation: 10,
                      backgroundColor: Colors.white,
                      label: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(Icons.add_a_photo),
                      ),
                      onPressed: getImageCam,
                    ),
                    SizedBox(width: 30),
                    ActionChip(
                      elevation: 10,
                      backgroundColor: Colors.white,
                      label: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(Icons.add_photo_alternate),
                      ),
                      onPressed: getImage,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Icon(Icons.control_point),
                    SizedBox(width: 10),
                    Text('Enter Ask Price'),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(30)),
                  child: TextFormField(
                    //initialValue: price,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please Enter Product price';
                      }
                    },
                    onChanged: (value) {
                      price = value;
                    },
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: '\u{20B9}',
                      contentPadding: EdgeInsets.symmetric(horizontal: 10),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: BorderSide(color: Colors.transparent),
                      ),
                    ),
                  ),
                ),
              ),
              Visibility(
                visible: vis,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ActionChip(
                      elevation: 10,
                      backgroundColor: Colors.redAccent,
                      label: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Done',
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ),
                      onPressed: () {
                        if (images.isEmpty) {
                          _error(context, 'Please add image');
                        } else {
                          setState(() {
                            vis = !vis;
                          });
                          FirestoreService()
                              .newProduct(
                            images,
                            prodName,
                            description,
                            price,
                            dropDownValue,
                          )
                              .then((value) {
                            if (value == 1) {
                              print('uploaded');
                              _scaffoldKey.currentState.showSnackBar(SnackBar(
                                  content: Text('Uploaded successfully.')));
                              // Toast.show("uploaded", context,
                              //     duration: Toast.LENGTH_SHORT,
                              //     gravity: Toast.BOTTOM);

                              setState(() {
                                prodName = '';
                                description = '';
                                price = '';
                                images.clear();
                              });
                              _formKey.currentState.reset();
                            } else if (value == 0) {
                              _scaffoldKey.currentState.showSnackBar(SnackBar(
                                  content: Text('Something went wrong')));
                              // Toast.show("something went wrong", context,
                              //     duration: Toast.LENGTH_SHORT,
                              //     gravity: Toast.BOTTOM);
                            }
                          });
                          setState(() {
                            vis = !vis;
                          });
                        }
                      }),
                ),
              ),
              Visibility(
                  visible: !vis,
                  child: Center(
                      child: SpinKitChasingDots(color: Colors.redAccent)))
            ],
          ),
        ),
      ),
    );
  }
}
