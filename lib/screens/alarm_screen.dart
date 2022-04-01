// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:samsung_clock_app_clone/constants/text_styles.dart';

class AlarmScreen extends StatelessWidget {
  const AlarmScreen({Key? key}) : super(key: key);

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
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 10.0),
                  child: IconButton(onPressed: () {
                    Navigator.pushNamed(context, '/add_alarm');
                  }, icon: Icon(Icons.add, size: 30),)
                ),
                Padding(
                  padding: EdgeInsets.only(right: 15.0),
                  child: Icon(Icons.more_vert, size: 30),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 200),
              child: Text(
                'No alarms', 
                style: GoogleFonts.nanumGothic(
                  textStyle: subHeader_1,
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        color: Colors.transparent,
        child: SizedBox(
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Spacer(),
              BottomNavBarItem(itemText: 'Alarm', isSelected: true,),
              Spacer(),
              BottomNavBarItem(itemText: 'World clock'),
              Spacer(),
              BottomNavBarItem(itemText: 'Stopwatch'),
              Spacer(),
              BottomNavBarItem(itemText: 'Timer'),
              Spacer(),
            ],
          ),
        ),
      )
    );
  }
}

class BottomNavBarItem extends StatelessWidget {
  final String itemText;
  final bool isSelected;
  const BottomNavBarItem({
    Key? key,
    required this.itemText,
    this.isSelected = false
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 5),
      margin: const EdgeInsets.only(bottom: 15),
      decoration: isSelected ? _underlined() : null,
      child: Text(
        itemText,
        style: GoogleFonts.nanumGothic(
          textStyle: isSelected ? selectedBottomNavBarText_1 : bottomNavBarText_1,
        ),
      ),
    );
  }

  BoxDecoration _underlined() {
    return const BoxDecoration(
      border: Border(
        bottom: BorderSide(
          color: Colors.black,
          width: 2.0,
        )
      )
    );
  }
}
