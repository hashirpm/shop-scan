import 'package:flutter/material.dart';

class RecentVisits extends StatefulWidget {
  static const routeName = '/recent-visits';
  @override
  _RecentVisitsState createState() => _RecentVisitsState();
}

class _RecentVisitsState extends State<RecentVisits> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Visits'),
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
                    Text('Shop', style: TextStyle(fontSize: 20.0))
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
