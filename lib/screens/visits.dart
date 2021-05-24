import 'package:flutter/material.dart';
import 'package:shopscan/services/firebase/firestore_services.dart';

class MyVisits extends StatelessWidget {
  static const routeName= '/myVisits';
  var results= FirestoreServices.getMyVisits();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Text('HI')
    );
  }
}