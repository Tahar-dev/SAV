import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({Key? key}) : super(key: key);
  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDate;
  Map<String, List> mySelectedEvents = {};
  Map<DateTime, List> _events = {};

  @override
  void initState() {
    super.initState();
    _selectedDate = _focusedDay;
    _fetchAppointments();
  }

  Future<void> _fetchAppointments() async {
    final response = await http.get(Uri.parse('http://10.0.2.2:6000/api/itv'));
    if (response.statusCode == 200) {
      final List<dynamic> responseData = json.decode(response.body);
      setState(() {
        mySelectedEvents = Map.fromIterable(responseData,
            key: (event) => DateFormat('yyyy-MM-dd')
                .format(DateTime.parse(event['startTime'])),
            value: (event) => [
                  {
                    "eventTitle": event['subject'],
                    "eventDescp": "${event['startTime']}, \n ${event['endTime']}"
                  }
                ]);
        // Build events map for TableCalendar
        mySelectedEvents.forEach((key, value) {
          _events[DateTime.parse(key)] = value;
        });
      });
    } else {
      throw Exception('Failed to load appointments');
    }
  }

  List _listOfDayEvents(DateTime dateTime) {
    if (mySelectedEvents[DateFormat('yyyy-MM-dd').format(dateTime)] != null) {
      return mySelectedEvents[DateFormat('yyyy-MM-dd').format(dateTime)]!;
    } else {
      return [];
    }
  }

  // Check if the given date has events
  bool _hasEvents(DateTime date) {
    final dateString = DateFormat('yyyy-MM-dd').format(date);
    return mySelectedEvents.containsKey(dateString);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Calendrier'),
      ),
      body: Column(
        children: [
          TableCalendar(
            firstDay: DateTime(2024),
            lastDay: DateTime(2025),
            focusedDay: _focusedDay,
            calendarFormat: _calendarFormat,
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDate, day);
            },
            calendarStyle: CalendarStyle(
              todayDecoration: BoxDecoration(
                color: Colors.green,
                shape: BoxShape.circle,
              ),
              selectedDecoration: BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.circle,
              ),
            ),
            onDaySelected: (selectedDay, focusedDay) {
              if (!isSameDay(_selectedDate, selectedDay)) {
                setState(() {
                  _selectedDate = selectedDay;
                  _focusedDay = focusedDay;
                });
              }
            },
            onFormatChanged: (format) {
              if (_calendarFormat != format) {
                setState(() {
                  _calendarFormat = format;
                });
              }
            },
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
            },
            eventLoader: _listOfDayEvents,
          ),
          ..._listOfDayEvents(_selectedDate!).map(
            (myEvents) => ListTile(
              leading: const Icon(
                Icons.done,
                color: Colors.teal,
              ),
              title: Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Text('Intervention:    ${myEvents['eventTitle']}'),
              ),
              subtitle: Text('Description:  \n ${myEvents['eventDescp']}'),
            ),
          ),
        ],
      ),
    );
  }
}
