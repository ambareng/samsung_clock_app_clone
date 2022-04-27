import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:samsung_clock_app_clone/constants/colors.dart';
import 'package:samsung_clock_app_clone/constants/text_sizes.dart';
import 'package:samsung_clock_app_clone/constants/text_styles.dart';
import 'package:samsung_clock_app_clone/widgets/add_settings_icons.dart';

import 'package:samsung_clock_app_clone/widgets/bottom_nav_bar.dart';

class TimerScreen extends StatelessWidget {
  const TimerScreen({Key? key}) : super(key: key);

  static final FixedExtentScrollController hourController = FixedExtentScrollController();
  static final FixedExtentScrollController minuteController = FixedExtentScrollController();
  static final FixedExtentScrollController secondController = FixedExtentScrollController();

  static final List<String> hourChoices = List<String>.generate(100, (int index) {
    if (index < 10) {
      return '0$index';
    }
    return '$index';
  }, growable: false);

  static final List<String> minuteChoices = List<String>.generate(59, (int index) {
    if (index < 10) {
      return '0$index';
    }
    return '$index';
  }, growable: false);

  static final List<String> secondChoices = List<String>.generate(59, (int index) {
    if (index < 10) {
      return '0$index';
    }
    return '$index';
  }, growable: false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.05),
        width: double.infinity,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.075),
              child: const AddSettingsIcons(),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.25,
              width: MediaQuery.of(context).size.width * 0.85,
              margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.4),
              child: Row(
                children: [
                  TimePickerV2(controller: hourController, label: 'Hours', choices: hourChoices,),
                  Padding(
                    padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.02),
                    child: Text(
                      ':',
                      style: GoogleFonts.nanumGothic(
                        textStyle: timePicker,
                      ),
                    ),
                  ),
                  TimePickerV2(controller: minuteController, label: 'Minutes', choices: minuteChoices,),
                  Padding(
                    padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.02),
                    child: Text(
                      ':',
                      style: GoogleFonts.nanumGothic(
                        textStyle: timePicker,
                      ),
                    ),
                  ),
                  TimePickerV2(controller: secondController, label: 'Seconds', choices: secondChoices,)
                ],
              ),
            ),
            const StartTimerButton()
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}

class StartTimerButton extends StatelessWidget {
  const StartTimerButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: const StadiumBorder(),
        elevation: 0,
        primary: Colors.blue[800]
      ),
      onPressed: () => {},
      child: SizedBox(
        height: 45.0,
        width: 90.0,
        child: Center(
          child: Text(
            'Start',
            style: GoogleFonts.nanumGothic(
              textStyle: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class TimePickerV2 extends StatelessWidget {
  final FixedExtentScrollController controller;
  final String label;
  final List<String> choices;

  const TimePickerV2({
    Key? key,
    required this.controller,
    required this.label,
    required this.choices
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Text(
            label,
            style: GoogleFonts.nanumGothic(
              textStyle: const TextStyle(
                fontSize: small,
                color: Colors.grey
              ),
            ),
          ),
          Expanded(
            child: CupertinoPicker(
              selectionOverlay: null,
              diameterRatio: 5.0,
              looping: true,
              itemExtent: 96, 
              onSelectedItemChanged: (value) {
                // if (widget.optionsList.length == 12) {
                //   context.read<TimePickerProvider>().setHourSelected(value: widget.optionsList[value]);
                // } else if (widget.optionsList.length == 59) {
                //   context.read<TimePickerProvider>().setMinuteSelected(value: widget.optionsList[value]);
                // } else if (widget.optionsList.length == 2) {
                //   context.read<TimePickerProvider>().setMeridianSelected(value: widget.optionsList[value]);
                // }
              }, 
              children: choices.map((choice) {
                return Center(
                  child: Text(
                    choice.toString(), 
                    style: GoogleFonts.nanumGothic(
                      textStyle: timePicker
                    ),
                  ),
                );
              }).toList()
            ),
          ),
        ],
      ),
    );
  }
}
