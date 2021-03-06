// ignore_for_file: prefer_const_constructors, must_be_immutable, avoid_print

// import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:samsung_clock_app_clone/constants/text_styles.dart';
import 'package:samsung_clock_app_clone/db/alarms_database.dart';
import 'package:samsung_clock_app_clone/models/alarm.dart';
import 'package:samsung_clock_app_clone/widgets/add_settings_icons.dart';
import 'package:samsung_clock_app_clone/widgets/bottom_nav_bar.dart';

// void createAlarmNotificatication() async {
//   await AwesomeNotifications().createNotification(
//     content: NotificationContent(
//       id: 0, 
//       channelKey: 'test_channel',
//       title: 'Sample Title',
//       body: 'Sample Body',
//       notificationLayout: NotificationLayout.Default,
//       locked: true,
//       fullScreenIntent: true,
//       criticalAlert: true,
//       autoDismissible: false,
//       displayOnForeground: true,
//       displayOnBackground: true,
//       category: NotificationCategory.Call,
//       wakeUpScreen: true,
//     ),
//     actionButtons: [
//       NotificationActionButton(
//         key: 'DISMISS_ALARM', 
//         label: 'Dismiss',
//         showInCompactView: true
//       ),
//       // NotificationActionButton(
//       //   key: 'SNOOZE', 
//       //   label: 'Snooze',
//       //   showInCompactView: true,
//       // ),
//     ],
//   );
// }

class AlarmScreen extends StatefulWidget {
  const AlarmScreen({Key? key}) : super(key: key);

  @override
  State<AlarmScreen> createState() => _AlarmScreenState();
}

class _AlarmScreenState extends State<AlarmScreen> {
  @override
  void initState() {
    super.initState();
    AwesomeNotifications().isNotificationAllowed().then(
      (isAllowed) {
        if (!isAllowed) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Allow Notifications'),
              content: Text('Our app would like to send you notifications'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Don\'t Allow',
                    style: TextStyle(color: Colors.grey, fontSize: 18),
                  ),
                ),
                TextButton(
                  onPressed: () => AwesomeNotifications()
                      .requestPermissionToSendNotifications()
                      .then((_) => Navigator.pop(context)),
                  child: Text(
                    'Allow',
                    style: TextStyle(
                      color: Colors.teal,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }

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
            AddSettingsIcons(),
            AlarmWidget()
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar()
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
          late List<Alarm> alarmsList;
          if (snapshot.data!.isNotEmpty) {
            alarmsList = snapshot.data as List<Alarm>;
          } else {
            return NoAlarms();
          }
          if (alarmsList.isNotEmpty) {
            return Expanded(
              child: SingleChildScrollView(
                child: Column(
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
                ),
              ),
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
