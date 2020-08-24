import 'package:flutter/material.dart';
import '../Widget/ProductItem.dart';
import '../functionalities/localData.dart';
import '../functionalities/firestoreServices.dart';

class MyBids extends StatefulWidget {
  @override
  _MyBidsState createState() => _MyBidsState();
}

// ignore: camel_case_types
class bidDetail {
  bidDetail({
    this.productName,
    this.productID,
    this.bidPrice,
    this.bidRank,
    this.bidStatus,
  });

  String productName;
  String productID;
  String bidStatus;
  double bidPrice;
  int bidRank;
}

class _MyBidsState extends State<MyBids> {
  List<bidDetail> _bids = [];
  int length;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: LocalData().getUid(),
      builder: (BuildContext context, AsyncSnapshot uid) {
        return StreamBuilder(
          stream: FirestoreService().getMyBids(uid.data),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState != ConnectionState.active)
              return Text("FETCHING");
            length = snapshot.data.documents.length;
            _bids.clear();
            snapshot.data.documents.forEach((product) {
              _bids.add(
                bidDetail(
                    productID: product.data['Product_id'],
                    bidPrice: product.data['Bid Price'],
                    bidRank: product.data['Bid Rank'],
                    bidStatus: product.data['Bid Status']),
              );
            });
            return ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: length,
              itemBuilder: (BuildContext context, int index) {
                return StreamBuilder(
                  stream: FirestoreService()
                      .getProductDetails(_bids[index].productID),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (!snapshot.hasData) return Text("FETCHING");
                    snapshot.data.documents.forEach((product) {
                      _bids[index].productName = product.data['Product Name'];
                    });
                    return Container(
                      height: 120,
                      padding: EdgeInsets.only(bottom: 20),
                      child: ProductItem(
                        bidPrice: _bids[index].bidPrice,
                        bidRank: _bids[index].bidRank,
                        bidStatus: _bids[index].bidStatus,
                        productName: _bids[index].productName,
                      ),
                    );
                  },
                );
              },
            );
          },
        );
      },
    );
  }
}
