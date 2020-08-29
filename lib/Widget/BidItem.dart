import 'package:flutter/material.dart';
import 'TextField.dart';

class BidItem extends StatelessWidget {
  final String bidStatus, productName;
  final double bidPrice;
  final int totalBid;
  const BidItem(
      {Key key, this.bidStatus, this.productName, this.bidPrice, this.totalBid})
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
                  ),
                  TextFieldForAll(
                    text: "Highest Bid:  $bidPrice",
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
                  ),
                  TextFieldForAll(
                    text: "Total Bid:  $totalBid",
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
