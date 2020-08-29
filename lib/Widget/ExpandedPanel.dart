import 'package:Prolx/functionalities/firestoreServices.dart';
import 'package:flutter/material.dart';
import 'TextField.dart';

class BidDetail {
  BidDetail({
    this.userName,
    this.price = 80,
  });
  List<dynamic> userName;
  double price;
}

class BuildExpandedPanel extends StatefulWidget {
  final int year;
  final int month;
  final int day;
  final String productID;

  const BuildExpandedPanel(this.year, this.month, this.day, this.productID);

  @override
  _BuildExpandedPanelState createState() =>
      _BuildExpandedPanelState(year, month, day, productID);
}

class _BuildExpandedPanelState extends State<BuildExpandedPanel> {
  final int year;
  final int month;
  final int day;
  final String productID;

  _BuildExpandedPanelState(this.year, this.month, this.day, this.productID);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirestoreService().getBidsFromProducts(productID),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) return Text("FETCHING");
          BidDetail _bidData =
              BidDetail(userName: snapshot.data.documents[0].data['uid']);
          return Column(
            children: [
              ListView.builder(
                padding: EdgeInsets.all(8),
                shrinkWrap: true,
                itemCount: _bidData.userName.length,
                itemBuilder: (context, index) {
                  return FutureBuilder(
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (!snapshot.hasData) return (Text("FETCHING"));
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child: TextFieldForAll(text: snapshot.data),
                            ),
                            Container(
                              child: TextFieldForAll(
                                text: '5',
                              ),
                            ),
                          ],
                        );
                      },
                      future: FirestoreService()
                          .getUserName(_bidData.userName[index]));
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFieldForAll(
                      text: "Expiry Date : $day/$month/$year",
                      fsize: 24,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FloatingActionButton(
                      onPressed: null,
                      child: Icon(Icons.edit),
                    ),
                  ),
                ],
              )
            ],
          );
        });
  }
}
