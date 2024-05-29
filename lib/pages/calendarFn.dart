import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:srasav/pages/invoice_design.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:intl/intl.dart';

class CalendarPageFn extends StatefulWidget {
  @override
  _CalendarPageFnState createState() => _CalendarPageFnState();
}

class _CalendarPageFnState extends State<CalendarPageFn> {
  List<Appointment> _appointments = [];

  @override
  void initState() {
    super.initState();
    _fetchAppointments();
  }

  Future<void> _fetchAppointments() async {
    final response = await http.get(Uri.parse('http://10.0.2.2:6000/api/itv'));
    if (response.statusCode == 200) {
      final List<dynamic> responseData = json.decode(response.body);
      setState(() {
        _appointments = responseData.map((data) => _parseAppointment(data)).toList();
      });
    } else {
      throw Exception('Failed to load appointments');
    }
  }

  Appointment _parseAppointment(dynamic data) {
    return Appointment(
      startTime: DateTime.parse(data['startTime']),
      endTime: DateTime.parse(data['endTime']),
      subject: data['subject'],
      location: data['location'],
      color: Colors.red,
      isAllDay: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Calendrier'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: SafeArea(
          child: SfCalendar(
            view: CalendarView.month,
            allowedViews: const <CalendarView>[
              CalendarView.month,
              CalendarView.schedule,
            ],
            dataSource: _appointments.isNotEmpty ? _getDataSource() : null,
            monthViewSettings: const MonthViewSettings(showAgenda: true, agendaItemHeight: 120),
            appointmentTimeTextFormat: 'hh:mm:ss a',
            todayHighlightColor: Colors.blue,
            appointmentBuilder: (BuildContext context, CalendarAppointmentDetails calendarAppointmentDetails) {
              final Appointment appointment = calendarAppointmentDetails.appointments.first;
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => InvoiceDesignPage()),
                  );
                },
                child: Card(
                  elevation: 24,
                  color: appointment.color,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.event, color: Colors.white),
                            SizedBox(width: 8),
                            Text(
                              appointment.subject,
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8),
                        Row(
                          children: [
                            Icon(Icons.access_time, color: Colors.white),
                            SizedBox(width: 8),
                            Text(
                              'Start Time: ${DateFormat('yyyy-MM-dd HH:mm').format(appointment.startTime)}',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8),
                        Row(
                          children: [
                            Icon(Icons.access_time, color: Colors.white),
                            SizedBox(width: 8),
                            Text(
                              'End Time: ${DateFormat('yyyy-MM-dd HH:mm').format(appointment.endTime)}',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  _DataSource _getDataSource() {
    return _DataSource(_appointments);
  }
}

class _DataSource extends CalendarDataSource {
  _DataSource(List<Appointment> source) {
    appointments = source;
  }
}
