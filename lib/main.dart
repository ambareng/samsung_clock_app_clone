import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:samsung_clock_app_clone/screens/add_alarm.dart';
import 'package:samsung_clock_app_clone/screens/alarm_screen.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark, 
    )
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
