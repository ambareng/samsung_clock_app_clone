import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:samsung_clock_app_clone/widgets/toggle_setting_input_field.dart';

import '../constants/text_styles.dart';

class AlarmSettingInputFields extends StatelessWidget {
  const AlarmSettingInputFields({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 35.0),
          child: TextField(
            decoration: const InputDecoration(
              hintText: 'Alarm name',
              isDense: true,
            ),
            style: GoogleFonts.nanumGothic(
              textStyle: datePickerSmall
            ),
          ),
        ),
        const ToggleSettingInputField(
          settingName: 'Alarm sound', 
          settingValue: 'Homecoming',
        ),
        const ToggleSettingInputField(
          settingName: 'Vibration', 
          settingValue: 'Basic call',
        ),
        const ToggleSettingInputField(
          settingName: 'Snooze', 
          settingValue: '5 minutes, 3 times',
          isLast: true,
        ),
      ],
    );
  }
}
