import 'package:Prolx/functionalities/firestoreServices.dart';
import 'package:Prolx/functionalities/localData.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'BidItem.dart';
import 'ExpandedPanel.dart';

//product class
class ProductDetail {
  ProductDetail(
      {this.productName,
      this.productID,
      this.isExpanded = false,
      this.productExpiry,
      this.bidStatus = 'green'});

  String productName;
  String productID;
  bool isExpanded;
  Timestamp productExpiry;
  String bidStatus;
}

//bid class
class BidDetail {
  BidDetail({
    this.bidRank,
    this.bidPrice,
    this.bidStatus,
    this.bidLength,
  });
  int bidRank;
  String bidStatus;
  double bidPrice;
  int bidLength;
}

//ProductItem
class MyProductItem extends StatefulWidget {
  @override
  _MyProductItemState createState() => _MyProductItemState();
}

class _MyProductItemState extends State<MyProductItem> {
  List<ProductDetail> _productData = [];

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
        if (!uid.hasData) return (Text("FETCHING"));
        return StreamBuilder(
          stream: FirestoreService().getMyProducts(uid.data),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData) return Text("Fetching");
            _productData.clear();
            snapshot.data.documents.forEach((product) {
              _productData.add(ProductDetail(
                  productName: product.data['Product Name'],
                  productExpiry: product.data['Product Expiry'],
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
                                  bidDets.data.documents[0].data['Bid Status'],
                              bidLength:
                                  bidDets.data.documents[0].data['uid'].length);
                          return BidItem(
                            productName: item.productName,
                            bidPrice: _bidData.bidPrice,
                            totalBid: _bidData.bidLength,
                            bidStatus: item.bidStatus,
                          );
                        });
                  },
                  body: BuildExpandedPanel(
                      (item.productExpiry.toDate().year),
                      (item.productExpiry.toDate().month),
                      (item.productExpiry.toDate().day),
                      item.productID),
                );
              }).toList(),
            );
          },
        );
      },
    );
  }
}
