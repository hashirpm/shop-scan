import 'package:flutter/material.dart';
import 'package:shopscan/services/firebase/firestore_services.dart';
import 'package:shopscan/services/misc/format_date.dart';

class DayVisitors extends StatefulWidget {
  DayVisitors({Key? key, required this.day}) : super(key: key);
  static const routeName = '/day-visitors';

  final DateTime day;

  @override
  _DayVisitorsState createState() => _DayVisitorsState();
}

class _DayVisitorsState extends State<DayVisitors> {
  @override
  void initState() {
    super.initState();
    createTable(widget.day);
  }

  List<TableRow> rows = [
    TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
              children: [Text('Person', style: TextStyle(fontSize: 20.0))]),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
              children: [Text('Time', style: TextStyle(fontSize: 20.0))]),
        ),
      ],
    )
  ];

  void createTable(DateTime day) async {
    List? data = await FirestoreServices.getVisitedYouOn(day);
    if (data != null) {
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
                  Text(FormatDate.type3(data[i]['time']),
                      style: TextStyle(fontSize: 20.0))
                ]),
              ),
            ],
          ),
        );
        setState(() {});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Visitors on ${FormatDate.type2(widget.day)}'),
      ),
      body: SingleChildScrollView(
        child: Center(
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
                children: rows,
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
