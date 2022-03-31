import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/colors.dart';
import '../constants/text_styles.dart';

class TimePicker extends StatelessWidget {
  TimePicker({Key? key}) : super(key: key);

  final List<int> hourOptionsList = List<int>.generate(12, (index) {
    return index + 1;
  });

  final List<String> minuteOptionsList = List<String>.generate(59, (index) {
    if (index < 10) {
      return '0$index';
    }
    return '$index';
  });

  final List<String> meridiemOptionsList = ['AM', 'PM'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightGrey,
      body: Row(
        children: [
          TimePickerScrollInput(optionsList: hourOptionsList),
          Text(
            ':',
            style: GoogleFonts.nanumGothic(
              textStyle: timePicker,
            ),
          ),
          TimePickerScrollInput(optionsList: minuteOptionsList),
          TimePickerScrollInput(optionsList: meridiemOptionsList, isLooping: false, textStyle: timePickerSmall,),
        ],
      ),
    );
  }
}

class TimePickerScrollInput extends StatelessWidget {
  final bool isLooping;
  final List<dynamic> optionsList;
  final TextStyle textStyle;
  const TimePickerScrollInput({
    Key? key,
    this.isLooping = true,
    required this.optionsList,
    this.textStyle = timePicker,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 1,
      child: CupertinoPicker(
        diameterRatio: 5.0,
        selectionOverlay: Container(),
        looping: isLooping,
        itemExtent: 96, 
        onSelectedItemChanged: (index) {}, 
        children: optionsList.map((option) {
          return Center(
            child: Text(
              option.toString(), 
              style: GoogleFonts.nanumGothic(
                textStyle: textStyle,
              ),
            ),
          );
        }).toList()
      ),
    );
  }
}
