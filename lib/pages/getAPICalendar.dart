import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:http/http.dart' as http;

class CalendarPage extends StatefulWidget {
  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  List<Appointment> _appointments = [];

  @override
  void initState() {
    super.initState();
    _fetchAppointments();
  }

  Future<void> _fetchAppointments() async {
    try {
      final response = await http.get(Uri.parse('http://localhost/api/getappoinmentDate'));
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        setState(() {
          _appointments = data.map((appointmentData) {
            return Appointment(
              startTime: DateTime.parse(appointmentData['startTime']),
              endTime: DateTime.parse(appointmentData['endTime']),
              subject: appointmentData['subject'],
              color: appointmentData['color'] != null ? Color(int.parse(appointmentData['color'])) : Colors.blue,
              isAllDay: appointmentData['isAllDay'] ?? false,
            );
          }).toList();
        });
      } else {
        throw Exception('Failed to load appointments');
      }
    } catch (error) {
      print('Error fetching appointments: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Calendrier'),
        ),
        body: SafeArea(
          child: SfCalendar(
            view: CalendarView.month,
            allowedViews: const <CalendarView>[
              CalendarView.month,
              CalendarView.schedule
            ],
            dataSource: _DataSource(_appointments),
            monthViewSettings: const MonthViewSettings(showAgenda: true),
            appointmentTimeTextFormat: 'hh:mm:ss a',
          ),
        ),
      ),
    );
  }
}

class _DataSource extends CalendarDataSource {
  _DataSource(List<Appointment> source) {
    appointments = source;
  }
}
