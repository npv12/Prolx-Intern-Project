import 'package:Prolx/functionalities/firestoreServices.dart';
import 'package:Prolx/functionalities/localData.dart';
import 'package:flutter/material.dart';
import '../Widget/ProductItem.dart';

//product class
class ProductDetail {
  ProductDetail({
    this.productName,
    this.productID,
    this.isExpanded = false,
  });

  String productName;
  String productID;
  bool isExpanded;
}

//bid class
class BidDetail {
  BidDetail({
    this.bidRank,
    this.bidPrice,
    this.bidStatus,
  });
  int bidRank;
  String bidStatus;
  double bidPrice;
}

class ExpandedPanel extends StatefulWidget {
  ExpandedPanel({Key key}) : super(key: key);

  @override
  _ExpandedPanel createState() => _ExpandedPanel();
}

class _ExpandedPanel extends State<ExpandedPanel> {
  List<ProductDetail> _productData = [];
  List<String> entries = ['a', 'b'];
  List<BidDetail> _bidData = [];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: _buildPanel(),
      ),
    );
  }

  Widget _buildPanel() {
    return FutureBuilder(
      future: LocalData().getUid(),
      builder: (BuildContext context, AsyncSnapshot uid) {
        return StreamBuilder(
          stream: FirestoreService().getMyProducts(uid.data),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData) return Text("Fetching");
            _productData.clear();
            snapshot.data.documents.forEach((product) {
              _productData.add(ProductDetail(
                  productName: product.data['Product Name'],
                  productID: product.data['Product_id']));
            });
            return ExpansionPanelList.radio(
              initialOpenPanelValue: 2,
              children:
                  _productData.map<ExpansionPanelRadio>((ProductDetail item) {
                return ExpansionPanelRadio(
                  value: item.productID,
                  headerBuilder: (BuildContext context, bool isExpanded) {
                    return StreamBuilder(
                        stream: FirestoreService()
                            .getBidsFromProducts(item.productID),
                        builder: (BuildContext context, AsyncSnapshot bidDets) {
                          if (!bidDets.hasData) return Text("FETCHING");
                          BidDetail _bidData = BidDetail(
                              bidPrice:
                                  bidDets.data.documents[0].data['Bid Price'],
                              bidRank:
                                  bidDets.data.documents[0].data['Bid Rank'],
                              bidStatus:
                                  bidDets.data.documents[0].data['Bid Status']);
                          return ProductItem(
                            productName: item.productName,
                            bidPrice: _bidData.bidPrice,
                            bidRank: _bidData.bidRank,
                            bidStatus: _bidData.bidStatus,
                          );
                        });
                  },
                  body: BuildExpandedPanel(
                    bidExpiry: '25/5/2015',
                  ),
                );
              }).toList(),
            );
          },
        );
      },
    );
  }
}

class BuildExpandedPanel extends StatelessWidget {
  final String bidExpiry;

  const BuildExpandedPanel({
    Key key,
    this.bidExpiry,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                TextField(text: "Person 1"),
                TextField(text: "Person 2"),
                TextField(text: "Person 3"),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: TextField(text: "Date Expires on $bidExpiry"),
                ),
              ],
            ),
            Column(
              children: [
                TextField(text: "100"),
                TextField(text: "100"),
                TextField(text: "100"),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child: FloatingActionButton(
                    onPressed: null,
                    child: Icon(Icons.edit),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class TextField extends StatelessWidget {
  final String text;
  const TextField({
    Key key,
    @required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        text,
        style: TextStyle(fontSize: 18),
      ),
    );
  }
}

/*
ProductItem(
                      productName: item.productName,
                    );
StreamBuilder(
                    stream: FirestoreService().getFeaturedProducts(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {});
ExpansionPanelRadio(
                  value: item.productID,
                  headerBuilder: (BuildContext context, bool isExpanded) {
                    return ProductItem(
                      productName: item.productName,
                    );
                  },
                  body: BuildExpandedPanel(
                    bidExpiry: '25/5/2015',
                  ),
                );
*/
