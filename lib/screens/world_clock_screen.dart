import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:samsung_clock_app_clone/constants/text_styles.dart';
import 'package:samsung_clock_app_clone/widgets/add_settings_icons.dart';
import 'package:samsung_clock_app_clone/widgets/bottom_nav_bar.dart';
import 'package:intl/intl.dart';

class WorldClockScreen extends StatelessWidget {
  const WorldClockScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.175),
        width: double.infinity,
        child: Column(
          children: [
            const MainWorldClock(),
            const MainCity(),
            Padding(
              padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.225),
              child: const AddSettingsIcons(),
            ),
            const CitiesList(),
          ],
        )
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}

class MainCity extends StatelessWidget {
  const MainCity({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.12),
      child: Text(
        'Manila', 
        style: GoogleFonts.nanumGothic(
          textStyle: subHeader_1,
        )
      ),
    );
  }
}

class CitiesList extends StatelessWidget {
  const CitiesList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      'No cities', 
      style: GoogleFonts.nanumGothic(
        textStyle: subHeader_1,
      ),
    );
  }
}

class MainWorldClock extends StatelessWidget {
  const MainWorldClock({
    Key? key,
  }) : super(key: key);

  Map<String, String> getTimeNow() {
    final DateTime now = DateTime.now(); 
    String formattedTime = DateFormat('h:mm').format(now);
    String meridianTime = DateFormat('a').format(now);

    return {
      'time': formattedTime,
      'meridian': meridianTime
    };
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, String> timeInfo = getTimeNow(); 

    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.005),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.baseline,
        textBaseline: TextBaseline.alphabetic,
        children: [
          Padding(
            padding: EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.025),
            child: Text(
              timeInfo['time']!, 
              style: GoogleFonts.nanumGothic(
                textStyle: header_1,
              ),
            ),
          ),
          Text(
            timeInfo['meridian']!, 
            style: GoogleFonts.nanumGothic(
              textStyle: subHeader_1,
            ),
          ),
        ],
      ),
    );
  }
}