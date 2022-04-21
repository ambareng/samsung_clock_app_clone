import 'package:flutter/material.dart';
import 'package:no_context_navigation/no_context_navigation.dart';

class AddSettingsIcons extends StatelessWidget {
  const AddSettingsIcons({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 10.0),
          child: IconButton(onPressed: () {
            // Navigator.pushNamed(context, '/add_alarm');
            NavigationService().pushNamed('/add_alarm');
          }, icon: const Icon(Icons.add, size: 30),)
        ),
        Padding(
          padding: const EdgeInsets.only(right: 15.0),
          child: IconButton(onPressed: () async {
            // const int alarmId = 0;
            // await AndroidAlarmManager.oneShotAt(
            //   DateTime.now().add(const Duration(seconds: 7)), 
            //   alarmId,
            //   createAlarmNotificatication,
            //   alarmClock: true, 
            //   allowWhileIdle: true,
            // );
          }, icon: const Icon(Icons.more_vert, size: 30),)
        )
      ],
    );
  }
}