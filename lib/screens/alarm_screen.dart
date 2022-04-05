// ignore_for_file: prefer_const_constructors, must_be_immutable

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:samsung_clock_app_clone/constants/text_styles.dart';
import 'package:samsung_clock_app_clone/db/alarms_database.dart';
import 'package:samsung_clock_app_clone/models/alarm.dart';

class AlarmScreen extends StatelessWidget {
  const AlarmScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 150.0),
              child: Text(
                'Alarm', 
                style: GoogleFonts.nanumGothic(
                  textStyle: header_1,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 10.0),
                  child: IconButton(onPressed: () {
                    Navigator.pushNamed(context, '/add_alarm');
                    // Alarm sampleAlarm = Alarm(isEnabled: false, alarmTime: DateTime.now());
                    // AlarmsDatabase.instance.create(sampleAlarm);
                  }, icon: Icon(Icons.add, size: 30),)
                ),
                Padding(
                  padding: EdgeInsets.only(right: 15.0),
                  child: Icon(Icons.more_vert, size: 30),
                )
              ],
            ),
            AlarmWidget()
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        color: Colors.transparent,
        child: SizedBox(
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Spacer(),
              BottomNavBarItem(itemText: 'Alarm', isSelected: true,),
              Spacer(),
              BottomNavBarItem(itemText: 'World clock'),
              Spacer(),
              BottomNavBarItem(itemText: 'Stopwatch'),
              Spacer(),
              BottomNavBarItem(itemText: 'Timer'),
              Spacer(),
            ],
          ),
        ),
      )
    );
  }
}

class AlarmWidget extends StatelessWidget {
  const AlarmWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: AlarmsDatabase.instance.readAllAlarms(),
      builder: (context, AsyncSnapshot<List<Alarm?>> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final List<Alarm> alarmsList = snapshot.data! as List<Alarm>;
          if (alarmsList.isNotEmpty) {
            return Column(
              children: alarmsList.map((alarm) {

                final DateFormat timeFormatter = DateFormat('h:mm ');
                final DateFormat meridianFormatter = DateFormat('a');
                final DateFormat dayFormatter = DateFormat('E,MMM d');

                final String formattedAlarmTime = timeFormatter.format(alarm.alarmTime);
                final String formattedAlarmMeridian = meridianFormatter.format(alarm.alarmTime);
                final String formattedAlarmDay = dayFormatter.format(alarm.alarmTime);

                return Container(
                  margin: EdgeInsets.symmetric(vertical: 10.0),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(25), color: Colors.white),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 30.0),
                    child: Row(
                      children: [
                        Text(formattedAlarmTime, style: GoogleFonts.nanumGothic(
                          textStyle: alarmTimeDisabled
                        ),),
                        Container(
                          margin: EdgeInsets.only(top: 15.0),
                          child: Text(formattedAlarmMeridian, style: GoogleFonts.nanumGothic(
                            textStyle: alarmMeridianDisabled
                          ),),
                        ),
                        Spacer(),
                        Text(formattedAlarmDay, style: GoogleFonts.nanumGothic(
                          textStyle: alarmDateDisabled
                        ),),
                        AlarmSwitch(isOn: alarm.isEnabled, alarm: alarm,),
                      ],
                    ),
                  ),
                );
              }).toList()
            );
          } else {
            return NoAlarms();
          }
        } else {
          return NoAlarms();
        }
      }
    );
  }
}

class AlarmSwitch extends StatefulWidget {
  AlarmSwitch({
    Key? key,
    this.isOn = false,
    required this.alarm,
  }) : super(key: key);
  bool? isOn;
  final Alarm alarm;

  @override
  State<AlarmSwitch> createState() => _AlarmSwitchState();
}

class _AlarmSwitchState extends State<AlarmSwitch> {
  @override
  Widget build(BuildContext context) {
    return Switch(value: widget.isOn!, onChanged: (value) {
      setState(() {
        widget.isOn = !widget.isOn!;
      });

      Alarm updatedAlarm = Alarm(
        id: widget.alarm.id,
        isEnabled: widget.isOn!, 
        alarmTime: widget.alarm.alarmTime
      );

      AlarmsDatabase.instance.update(updatedAlarm);
    },);
  }
}

class NoAlarms extends StatelessWidget {
  const NoAlarms({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 200),
      child: Text(
        'No alarms', 
        style: GoogleFonts.nanumGothic(
          textStyle: subHeader_1,
        ),
      ),
    );
  }
}

class BottomNavBarItem extends StatelessWidget {
  final String itemText;
  final bool isSelected;
  const BottomNavBarItem({
    Key? key,
    required this.itemText,
    this.isSelected = false
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 5),
      margin: const EdgeInsets.only(bottom: 15),
      decoration: isSelected ? _underlined() : null,
      child: Text(
        itemText,
        style: GoogleFonts.nanumGothic(
          textStyle: isSelected ? selectedBottomNavBarText_1 : bottomNavBarText_1,
        ),
      ),
    );
  }

  BoxDecoration _underlined() {
    return const BoxDecoration(
      border: Border(
        bottom: BorderSide(
          color: Colors.black,
          width: 2.0,
        )
      )
    );
  }
}
