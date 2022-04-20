// import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:samsung_clock_app_clone/constants/colors.dart';
import 'package:samsung_clock_app_clone/db/alarms_database.dart';
import 'package:samsung_clock_app_clone/models/alarm.dart';
import 'package:samsung_clock_app_clone/providers/time_picker_provider.dart';
import 'package:samsung_clock_app_clone/widgets/date_picker.dart';
import '../constants/text_styles.dart';
import '../widgets/alarm_setting_input_fields.dart';
import '../widgets/timer_picker.dart';

void createAlarmNotificatication(DateTime alarmTime) async {
  await AwesomeNotifications().createNotification(
    content: NotificationContent(
      id: 0, 
      channelKey: 'test_channel',
      title: 'Sample Title',
      body: 'Sample Body',
      notificationLayout: NotificationLayout.Default,
      locked: true,
      fullScreenIntent: true,
      criticalAlert: true,
      autoDismissible: false,
      displayOnForeground: true,
      displayOnBackground: true,
      category: NotificationCategory.Call,
      wakeUpScreen: true,
    ),
    actionButtons: [
      NotificationActionButton(
        key: 'DISMISS_ALARM', 
        label: 'Dismiss',
        showInCompactView: true
      ),
      // NotificationActionButton(
      //   key: 'SNOOZE', 
      //   label: 'Snooze',
      //   showInCompactView: true,
      // ),
    ],
    schedule: NotificationCalendar(
      year: alarmTime.year,
      month: alarmTime.month,
      day: alarmTime.day,
      hour: alarmTime.hour,
      minute: alarmTime.minute,
      timeZone: 'Asia/Manila',
      allowWhileIdle: true,
      preciseAlarm: true,
      repeats: false,
    )
  );
}

class AddAlarm extends StatefulWidget {
  const AddAlarm({
    Key? key,
  }) : super(key: key);

  @override
  State<AddAlarm> createState() => _AddAlarmState();
}

class _AddAlarmState extends State<AddAlarm> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }
    
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            color: lightGrey,
            padding: const EdgeInsets.symmetric(vertical: 75.0),
            height: MediaQuery.of(context).size.height * 0.40,
            width: double.infinity,
            child: const TimePicker(),
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white
              ),
              child: Column(
                children: const [
                  DatePicker(),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25.0),
                    child: AlarmSettingInputFields(),
                  )
                ]
              ),
            )
          )
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        color: lightGrey,
        child: SizedBox(
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Spacer(),
              SettingBottomNavBarItem(itemLabel: 'Cancel'),
              Spacer(),
              SettingBottomNavBarItem(itemLabel: 'Save', toSave: true,),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}

class SettingBottomNavBarItem extends StatelessWidget {
  final String itemLabel;
  final bool toSave;
  const SettingBottomNavBarItem({
    Key? key, 
    required this.itemLabel,
    this.toSave = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: InkWell(
        onTap: () async {
          if (toSave) {
            final int minute = int.parse(Provider.of<TimePickerProvider>(context, listen: false).minuteSelected);
            final String meridian = Provider.of<TimePickerProvider>(context, listen: false).meridianSelected;
            late int hour;

            if (meridian != 'AM') {
              hour = int.parse(Provider.of<TimePickerProvider>(context, listen: false).hourSelected) - 12;
            } else {
              hour = int.parse(Provider.of<TimePickerProvider>(context, listen: false).hourSelected);
            }

            DateTime alarmTime = DateTime(
              DateTime.now().year,
              DateTime.now().month,
              DateTime.now().day+1,
              hour,
              minute,
            );

            Alarm alarm = Alarm(isEnabled: true, alarmTime: alarmTime);

            AlarmsDatabase.instance.create(alarm);

            createAlarmNotificatication(alarmTime);

            // const int alarmId = 0;
            // await AndroidAlarmManager.oneShotAt(
            //   alarmTime,
            //   alarmId,
            //   createAlarmNotificatication,
            //   alarmClock: true, 
            //   allowWhileIdle: true,
            //   exact: true,
            //   wakeup: true,
            // );

            Navigator.pushNamed(context, '/alarm');
          } else {
            Navigator.pop(context);
          }
        },
        child: Text(
          itemLabel,
          style: GoogleFonts.nanumGothic(
            textStyle: settingBottomNavBarText,
          ),
        ),
      ),
    );
  }
}
