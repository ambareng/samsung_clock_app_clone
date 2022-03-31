import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/text_styles.dart';

class ToggleSettingInputField extends StatelessWidget {
  final String settingName;
  final String settingValue;
  final bool isLast;
  const ToggleSettingInputField({
    Key? key, 
    required this.settingName, 
    required this.settingValue,
    this.isLast = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 5.0),
          child: IntrinsicHeight(
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      settingName,
                      style: GoogleFonts.nanumGothic(
                        textStyle: toggleSettingLabelText
                      ),
                    ),
                    Text(
                      settingValue,
                      style: GoogleFonts.nanumGothic(
                        textStyle: tappableSmallText
                      ),
                    )
                  ],
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 10.0, 20.0, 10.0),
                  child: VerticalDivider(
                    width: 0.0,
                    thickness: 0.5,
                    color: Colors.grey[350],
                  ),
                ),
                const ToggleSwitch(),
              ],
            ),
          ),
        ),
        !isLast ?
        Padding(
          padding: const EdgeInsets.only(bottom: 15.0),
          child: Divider(
            color: Colors.grey[350],
            thickness: 1.0,
          ),
        )
        :
        Container()
      ],
    );
  }
}

class ToggleSwitch extends StatefulWidget {
  const ToggleSwitch({
    Key? key,
  }) : super(key: key);

  @override
  State<ToggleSwitch> createState() => _ToggleSwitchState();
}

class _ToggleSwitchState extends State<ToggleSwitch> {
  bool isToggled = false;

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: 1.15,
      child: Switch(
        activeColor: Colors.white,
        activeTrackColor: Colors.blue[800],
        value: isToggled, 
        onChanged: (value) {
          setState(() {
            isToggled = value;
          });
        }
      ),
    );
  }
}
