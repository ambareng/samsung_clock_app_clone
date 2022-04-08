// ignore_for_file: avoid_print
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:samsung_clock_app_clone/screens/add_alarm.dart';
import 'package:samsung_clock_app_clone/screens/alarm_screen.dart';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';

// void printHello() {
//   final DateTime now = DateTime.now();
//   final int isolateId = Isolate.current.hashCode;
//   print("[$now] Hello, world! isolate=$isolateId function='$printHello'");
// }

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark, 
    )
  );
  await AndroidAlarmManager.initialize();
  runApp(const Main());
  // const int helloAlarmID = 0;
  // await AndroidAlarmManager.periodic(const Duration(seconds: 10), helloAlarmID, printHello, allowWhileIdle: true);
  // await AndroidAlarmManager.oneShotAt(DateTime.now().add(const Duration(seconds: 5)), helloAlarmID, printHello, alarmClock: true, allowWhileIdle: true, );
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
