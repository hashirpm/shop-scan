import 'package:flutter/material.dart';
import 'package:shopscan/services/firebase/firestore_services.dart';

class YourShop extends StatefulWidget {
  static const routeName = '/your-shop';
  @override
  _YourShopState createState() => _YourShopState();
}

class _YourShopState extends State<YourShop> {
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
    List data = await FirestoreServices.getVisitedYou();
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
                Text(data[i]['time'], style: TextStyle(fontSize: 20.0))
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
        title: Text('Your Shop'),
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
