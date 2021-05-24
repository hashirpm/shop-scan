import 'package:flutter/material.dart';

class YourShop extends StatefulWidget {
  static const routeName = '/your-shop';
  @override
  _YourShopState createState() => _YourShopState();
}

class _YourShopState extends State<YourShop> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Shop'),
      ),
      body: Center(
          child: Column(children: <Widget>[
        Container(
          margin: EdgeInsets.all(20),
          child: Table(
            defaultColumnWidth: FixedColumnWidth(150.0),
            columnWidths: const <int, TableColumnWidth>{
              0: FlexColumnWidth(),
              1: FixedColumnWidth(120),
            },
            border: TableBorder.all(
              color: Colors.black,
              style: BorderStyle.solid,
            ),
            children: [
              TableRow(children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(children: [
                    Text('Visits', style: TextStyle(fontSize: 20.0))
                  ]),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(children: [
                    Text('Date', style: TextStyle(fontSize: 20.0))
                  ]),
                ),
              ]),
            ],
          ),
        ),
      ])),
    );
  }
}
