import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:samsung_clock_app_clone/constants/text_styles.dart';

class DatePicker extends StatelessWidget {
  const DatePicker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 30.0),
              child: Text(
                'Tomorrow-Tue, Mar 29',
                style: GoogleFonts.nanumGothic(
                  textStyle: datePickerSmall
                ),
              ),
            ),
            const Spacer(),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 30.0),
              child: Icon(Icons.calendar_month_rounded, color: Colors.grey,),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 35.0),
          child: DayPicker(),
        ),
      ],
    );
  }
}

class DayPicker extends StatelessWidget {
  DayPicker({Key? key}) : super(key: key);
  final List<String> dayList = ['S', 'M', 'T', 'W', 'T', 'F', 'S'];

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: dayList.map((day) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.05),
          child: Text(
            day, 
            style: GoogleFonts.nanumGothic(
              textStyle: datePickerSmall
            ),
          ),
        );
      }).toList()
    );
  }
}
