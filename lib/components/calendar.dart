import 'package:flutter/material.dart';
import 'package:shopscan/screens/day_visitors.dart';
import 'package:table_calendar/table_calendar.dart';

class Calendar extends StatefulWidget {
  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  DateTime _focusedDay = DateTime.now();
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime? _selectedDay;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: TableCalendar(
        firstDay: DateTime.utc(2021, 1, 1),
        lastDay: DateTime.now(),
        focusedDay: _focusedDay,
        calendarFormat: _calendarFormat,
        selectedDayPredicate: (day) {
          return isSameDay(_selectedDay, day);
        },
        onDaySelected: (selectedDay, focusedDay) {
          if (!isSameDay(_selectedDay, selectedDay)) {
            setState(() {
              _selectedDay = selectedDay;
              _focusedDay = focusedDay;
            });
            Future.delayed(Duration(milliseconds: 500), () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => DayVisitors(
                    day: selectedDay,
                  ),
                ),
              );
            });
          }
        },
        onPageChanged: (focusedDay) {
          // No need to call `setState()` here
          _focusedDay = focusedDay;
        },
        onFormatChanged: (calendarFormat) {
          setState(() {
            _calendarFormat = calendarFormat;
          });
        },
      ),
    );
  }
}
