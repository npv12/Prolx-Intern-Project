import 'package:flutter/material.dart';
import '../Widget/ProductItem.dart';
import '../functionalities/localData.dart';
import '../functionalities/firestoreServices.dart';

class MyBids extends StatefulWidget {
  @override
  _MyBidsState createState() => _MyBidsState();
}

class _MyBidsState extends State<MyBids> {
  List<String> productUid = [], productName = [];
  List<String> bidStatus = [];
  List<double> bidPrice = [];
  List<int> bidRank = [];
  int length;
  String uid;

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
            snapshot.data.documents.forEach((product) {
              productUid.add(product.data['Product_id']);
              bidStatus.add(product.data['Bid Status']);
              bidRank.add(product.data['Bid Rank']);
              bidPrice.add(product.data['Bid Price']);
            });

            return ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: length,
              itemBuilder: (BuildContext context, int index) {
                return StreamBuilder(
                  stream:
                      FirestoreService().getProductDetails(productUid[index]),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (!snapshot.hasData) return Text("FETCHING");
                    snapshot.data.documents.forEach((product) {
                      productName.add(product.data['Product Name']);
                    });
                    return Container(
                      height: 120,
                      padding: EdgeInsets.only(bottom: 20),
                      child: ProductItem(
                        bidPrice: bidPrice[index],
                        bidRank: bidRank[index],
                        bidStatus: bidStatus[index],
                        productName: productName[index],
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

/*
Container(
                  height: 120,
                  padding: EdgeInsets.only(bottom: 20),
                  child: ProductItem(
                    bidPrice: bidPrice[index],
                    bidRank: bidRank[index],
                    bidStatus: bidStatus[index],
                    productName: productName[index],
                  ),
                );
*/
