import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

abstract class FormatDate {
  static type1(Timestamp timestamp) {
    return DateFormat('yMMMMd').format(
      DateTime.parse(
        timestamp.toDate().toString(),
      ),
    );
  }

  static type2(DateTime time) {
    return DateFormat('yMMMMd').format(time);
  }

  static type3(Timestamp timestamp) {
    return DateFormat('jm').format(
      DateTime.parse(
        timestamp.toDate().toString(),
      ),
    );
  }
}
