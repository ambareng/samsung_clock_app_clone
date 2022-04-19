import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:samsung_clock_app_clone/providers/time_picker_provider.dart';

import '../constants/colors.dart';
import '../constants/text_styles.dart';

class TimePicker extends StatefulWidget {
  const TimePicker({
    Key? key,
  }) : super(key: key);

  @override
  State<TimePicker> createState() => _TimePickerState();
}

class _TimePickerState extends State<TimePicker> {
  final List<String> hourOptionsList = List<String>.generate(12, (index) {
    return '${index + 1}';
  });

  final List<String> minuteOptionsList = List<String>.generate(59, (index) {
    if (index < 10) {
      return '0$index';
    }
    return '$index';
  });

  final List<String> meridiemOptionsList = ['AM', 'PM'];

  @override
  void initState() {
    super.initState();
  }

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
          TimePickerScrollInput(
            optionsList: meridiemOptionsList, 
            isLooping: false, 
            textStyle: timePickerSmall
          ),
        ],
      ),
    );
  }
}

class TimePickerScrollInput extends StatefulWidget {
  final bool isLooping;
  final List<String> optionsList;
  final TextStyle textStyle;
  const TimePickerScrollInput({
    Key? key,
    this.isLooping = true,
    required this.optionsList,
    this.textStyle = timePicker,
  }) : super(key: key);

  @override
  State<TimePickerScrollInput> createState() => _TimePickerScrollInputState();
}

class _TimePickerScrollInputState extends State<TimePickerScrollInput> {
  @override
  void initState() {
    super.initState();
    context.read<TimePickerProvider>().setHourSelected(value: '1');
    context.read<TimePickerProvider>().setMinuteSelected(value: '00');
    context.read<TimePickerProvider>().setMeridianSelected(value: 'AM');
  }

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 1,
      child: CupertinoPicker(
        diameterRatio: 5.0,
        selectionOverlay: Container(),
        looping: widget.isLooping,
        itemExtent: 96, 
        onSelectedItemChanged: (value) {
          if (widget.optionsList.length == 12) {
            context.read<TimePickerProvider>().setHourSelected(value: widget.optionsList[value]);
          } else if (widget.optionsList.length == 59) {
            context.read<TimePickerProvider>().setMinuteSelected(value: widget.optionsList[value]);
          } else if (widget.optionsList.length == 2) {
            context.read<TimePickerProvider>().setMeridianSelected(value: widget.optionsList[value]);
          }
        }, 
        children: widget.optionsList.map((option) {
          return Center(
            child: Text(
              option.toString(), 
              style: GoogleFonts.nanumGothic(
                textStyle: widget.textStyle,
              ),
            ),
          );
        }).toList()
      ),
    );
  }
}
