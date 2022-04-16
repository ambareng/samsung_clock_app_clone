import 'package:avatar_glow/avatar_glow.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:no_context_navigation/no_context_navigation.dart';
import 'package:samsung_clock_app_clone/constants/text_sizes.dart';

class DismissAlarm extends StatelessWidget {
  const DismissAlarm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            AlarmTime(),
            AlarmDate(),
            AlarmName(),
            AlarmDismisser(),
          ],
        ),
      )
    );
  }
}

class AlarmDismisser extends StatelessWidget {
  const AlarmDismisser({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragStart: (DragStartDetails details) {
        NavigationService().pushNamed('/alarm');
        AwesomeNotifications().dismissAllNotifications();
      },
      onVerticalDragStart: (DragStartDetails details) {
        NavigationService().pushNamed('/alarm');
        AwesomeNotifications().dismissAllNotifications();
      },
      child: AvatarGlow(
        endRadius: 60.0,
        glowColor: Colors.white,
        repeat: true,
        showTwoGlows: false,
        duration: const Duration(milliseconds: 2000),
        repeatPauseDuration: const Duration(milliseconds: 100),
        child: Container(
          padding: const EdgeInsets.all(15.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(180),
            color: Colors.white,
          ),
          child: const Icon(
            Icons.close, 
            size: 40,
            color: Colors.blueAccent,
          ),
        ),
      ),
    );
  }
}

class AlarmName extends StatelessWidget {
  const AlarmName({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.35),
      child: Text(
        'Alarm', 
        style: GoogleFonts.nanumGothic(
          textStyle: const TextStyle(
            fontSize: medium,
            color: Colors.white
          )
        ),
      ),
    );
  }
}

class AlarmDate extends StatelessWidget {
  const AlarmDate({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.075),
      child: Text(
        'Thu, Apr 14', 
        style: GoogleFonts.nanumGothic(
          textStyle: const TextStyle(
            fontSize: medium,
            color: Colors.white
          )
        ),
      ),
    );
  }
}

class AlarmTime extends StatelessWidget {
  const AlarmTime({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      '10:35', 
      style: GoogleFonts.nanumGothic(
        textStyle: const TextStyle(
          fontSize: xxxLarge,
          color: Colors.white,
          fontWeight: FontWeight.w100,
        )
      ),
    );
  }
}
