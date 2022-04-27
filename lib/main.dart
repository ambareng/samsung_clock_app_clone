// ignore_for_file: avoid_print
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:no_context_navigation/no_context_navigation.dart';
import 'package:provider/provider.dart';
import 'package:samsung_clock_app_clone/providers/lap_times_list_provider.dart';
import 'package:samsung_clock_app_clone/providers/stopwatch_provider.dart';
import 'package:samsung_clock_app_clone/providers/time_picker_provider.dart';
import 'package:samsung_clock_app_clone/screens/add_alarm.dart';
import 'package:samsung_clock_app_clone/screens/alarm_screen.dart';
import 'package:samsung_clock_app_clone/screens/stopwatch_screen.dart';
import 'package:samsung_clock_app_clone/screens/timer_screen.dart';
import 'package:samsung_clock_app_clone/screens/world_clock_screen.dart';
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

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TimePickerProvider()),
        ChangeNotifierProvider(create: (_) => StopwatchProvider()),
        ChangeNotifierProvider(create: (_) => LapTimesListProvider())
      ],
      child: const Main(),
    )
  );
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
          case '/world_clock':
            return MaterialPageRoute(builder: (context) => const WorldClockScreen());
          case '/stopwatch':
            return MaterialPageRoute(builder: (context) => const Stopwatch());
          case '/timer':
            return MaterialPageRoute(builder: (context) => const TimerScreen());
          default:
            return MaterialPageRoute(builder: (context) => const AlarmScreen());
        }
      },
    );
  }
}
