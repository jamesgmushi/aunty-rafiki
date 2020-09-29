import 'package:aunty_rafiki/constants/routes/routes.dart';
import 'package:aunty_rafiki/providers/appointment_provider.dart';
import 'package:aunty_rafiki/views/components/cards/calendar_card.dart';
import 'package:aunty_rafiki/views/components/tiles/appointment_tile.dart';
import 'package:aunty_rafiki/views/components/tiles/no_items.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppointmentPage extends StatefulWidget {
  @override
  _AppointmentPageState createState() => _AppointmentPageState();
}

class _AppointmentPageState extends State<AppointmentPage> {
  bool _calendarView = true;
  @override
  Widget build(BuildContext context) {
    final _appointmentProvider = Provider.of<AppointmentProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Appointments'),
        actions: [
          FlatButton(
              textColor: Colors.white,
              onPressed: () {
                setState(() {
                  _calendarView = !_calendarView;
                });
              },
              child: Text(_calendarView ? 'List View' : 'Calendar View'))
        ],
      ),
      body: _calendarView
          ? SingleChildScrollView(
              child: Column(
              children: [
                CalendarCard(),
                SizedBox(height: 100),
                _appointmentProvider.availableAppointments.isEmpty
                    ? NoItemTile(
                        icon: 'assets/icons/calendar.png',
                        title: 'No appointments to display',
                        subtitle: '',
                      )
                    : AppointmentTile(
                        appointment:
                            _appointmentProvider.availableAppointments.last)
              ],
            ))
          : _appointmentProvider.availableAppointments.isEmpty
              ? Center(
                  child: NoItemTile(
                    icon: 'assets/icons/calendar.png',
                    title: 'No appointments to display',
                    subtitle: '',
                  ),
                )
              : ListView.builder(
                  itemCount: _appointmentProvider.availableAppointments.length,
                  itemBuilder: (_, index) {
                    return AppointmentTile(
                      appointment:
                          _appointmentProvider.availableAppointments[index],
                    );
                  }),
      bottomNavigationBar: BottomAppBar(
          child: Container(
        height: 80,
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Expanded(
                    child: RaisedButton(
                      textColor: Colors.white,
                      color: Theme.of(context).primaryColor,
                      onPressed: () {
                        Navigator.pushNamed(context, addAppointmentPage);
                      },
                      child: Text('ADD'),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      )),
    );
  }
}
