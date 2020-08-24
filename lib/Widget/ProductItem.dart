import 'package:flutter/material.dart';

class ProductItem extends StatelessWidget {
  final String bidStatus, productName;
  final double bidPrice;
  final int bidRank;
  const ProductItem(
      {Key key, this.bidStatus, this.productName, this.bidPrice, this.bidRank})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      elevation: 10,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  TextField(
                    text: "Product Name : $productName",
                  ),
                  TextField(
                    text: "Bid Price:  $bidPrice",
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  TextField(
                    text: "Status $bidStatus",
                  ),
                  TextField(
                    text: "Bid Rank:  $bidRank",
                  ),
                ],
              ),
            ),
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
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
        child: Text(
          text,
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
