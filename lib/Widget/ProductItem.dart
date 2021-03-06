import 'package:flutter/material.dart';
import 'TextField.dart';

class ProductItem extends StatelessWidget {
  final String bidStatus, productName;
  final double bidPrice, fontSize = 14;
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
                  TextFieldForAll(
                    text: "Name : $productName",
                    fsize: fontSize,
                  ),
                  TextFieldForAll(
                    text: "Price:  $bidPrice",
                    fsize: fontSize,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  TextFieldForAll(
                    text: "Status $bidStatus",
                    fsize: fontSize,
                  ),
                  TextFieldForAll(
                    text: "Bid Rank:  $bidRank",
                    fsize: fontSize,
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
