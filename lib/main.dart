// ignore_for_file: avoid_print
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:samsung_clock_app_clone/screens/add_alarm.dart';
import 'package:samsung_clock_app_clone/screens/alarm_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark, 
    )
  );
  await AndroidAlarmManager.initialize();
  AwesomeNotifications().initialize(
    null, 
    [
      NotificationChannel(
        channelKey: 'basic_channel',
        channelName: 'Basic Notifications',
        channelDescription: 'Sample Description',
        defaultColor: Colors.teal,
        importance: NotificationImportance.Max,
        channelShowBadge: true,
        criticalAlerts: true,
        defaultRingtoneType: DefaultRingtoneType.Alarm,
        enableVibration: true,
        vibrationPattern: highVibrationPattern,
        playSound: true,
        soundSource: 'resource://raw/res_custom_notification',
      )
    ]
  );
  runApp(const Main());
}

class Main extends StatelessWidget {
  const Main({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/alarm',
      routes: {
        '/alarm': (context) => const AlarmScreen(),
        '/add_alarm': (context) => const AddAlarm(),
      },
    );
  }
}
