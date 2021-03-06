import 'package:flutter/material.dart';
import 'package:shopscan/services/firebase/firestore_services.dart';
import 'package:shopscan/services/misc/format_date.dart';

class RecentVisits extends StatefulWidget {
  static const routeName = '/recent-visits';
  @override
  _RecentVisitsState createState() => _RecentVisitsState();
}

class _RecentVisitsState extends State<RecentVisits> {
  @override
  void initState() {
    super.initState();
    createTable();
  }

  List<TableRow> rows = [
    TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
              children: [Text('Shop', style: TextStyle(fontSize: 20.0))]),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
              children: [Text('Date', style: TextStyle(fontSize: 20.0))]),
        ),
      ],
    )
  ];

  void createTable() async {
    List data = await FirestoreServices.getYourVisits();
    for (int i = 0; i < data.length; i++) {
      Map? userData = await FirestoreServices.getUserData(data[i]['uid']);
      rows.add(
        TableRow(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(children: [
                Text('${userData!['name']}\nPh no: ${userData['phone']}',
                    style: TextStyle(fontSize: 20.0))
              ]),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(children: [
                Text(FormatDate.type1(data[i]['time']),
                    style: TextStyle(fontSize: 20.0))
              ]),
            ),
          ],
        ),
      );
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Visits'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
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
                  children: rows,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
