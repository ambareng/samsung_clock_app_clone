// ignore_for_file: avoid_print
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:no_context_navigation/no_context_navigation.dart';
import 'package:samsung_clock_app_clone/screens/add_alarm.dart';
import 'package:samsung_clock_app_clone/screens/alarm_screen.dart';
import 'screens/dismiss_alarm.dart';

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
        channelKey: 'test_channel',
        channelName: 'Basic Notifications',
        channelDescription: 'Sample Description',
        importance: NotificationImportance.Max,
        channelShowBadge: true,
        criticalAlerts: true,
        defaultRingtoneType: DefaultRingtoneType.Alarm,
        locked: true,
        enableVibration: true,
        vibrationPattern: highVibrationPattern,
        playSound: true,
        // soundSource: 'resource://raw/res_custom_notification',
      )
    ]
  );

  AwesomeNotifications().displayedStream.listen((ReceivedNotification notification) {
    NavigationService().pushNamed('/alarm/dismiss');
  });

  AwesomeNotifications().actionStream.listen((ReceivedAction action) {
    if (action.buttonKeyPressed == 'DISMISS_ALARM') {
      NavigationService().pushNamed('/alarm');
    }
  });

  runApp(const Main());
}

class Main extends StatefulWidget {
  const Main({Key? key}) : super(key: key);

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  @override
  void dispose() {
    AwesomeNotifications().displayedSink.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: NavigationService.navigationKey,
      onGenerateRoute: (RouteSettings settings) {
        switch(settings.name) {
          case '/alarm':
            return MaterialPageRoute(builder: (context) => const AlarmScreen());
          case '/add_alarm':
            return MaterialPageRoute(builder: (context) => const AddAlarm());
          case '/alarm/dismiss':
            return MaterialPageRoute(builder: (context) => const DismissAlarm());
          default:
            return MaterialPageRoute(builder: (context) => const AlarmScreen());
        }
      },
    );
  }
}
