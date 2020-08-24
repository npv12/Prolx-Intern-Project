import 'package:flutter/material.dart';
import '../Widget/ProductItem.dart';

class ExpandedPanel extends StatefulWidget {
  ExpandedPanel({Key key}) : super(key: key);

  @override
  _ExpandedPanel createState() => _ExpandedPanel();
}

class _ExpandedPanel extends State<ExpandedPanel> {
  final List<String> entries = <String>['A', 'B', 'C', 'D'];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: _buildPanel(),
      ),
    );
  }

  Widget _buildPanel() {
    return ExpansionPanelList.radio(
      initialOpenPanelValue: 2,
      children: entries.map<ExpansionPanelRadio>((String item) {
        return ExpansionPanelRadio(
          value: item,
          headerBuilder: (BuildContext context, bool isExpanded) {
            return ProductItem();
          },
          body: BuildExpandedPanel(),
        );
      }).toList(),
    );
  }
}

class BuildExpandedPanel extends StatelessWidget {
  final List<String> entries = <String>['A', 'B', 'C', 'D'];
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
                  child: TextField(text: "Date Expires on "),
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
