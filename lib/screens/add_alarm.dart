import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:samsung_clock_app_clone/constants/colors.dart';
import 'package:samsung_clock_app_clone/db/alarms_database.dart';
import 'package:samsung_clock_app_clone/models/alarm.dart';
import 'package:samsung_clock_app_clone/widgets/date_picker.dart';
import '../constants/text_styles.dart';
import '../widgets/alarm_setting_input_fields.dart';
import '../widgets/timer_picker.dart';

class AddAlarm extends StatefulWidget {
  const AddAlarm({
    Key? key,
  }) : super(key: key);

  @override
  State<AddAlarm> createState() => _AddAlarmState();
}

class _AddAlarmState extends State<AddAlarm> {
  @override
  void initState() {
    super.initState();
  }
    
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            color: lightGrey,
            padding: const EdgeInsets.symmetric(vertical: 75.0),
            height: MediaQuery.of(context).size.height * 0.40,
            width: double.infinity,
            child: TimePicker(),
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white
              ),
              child: Column(
                children: const [
                  DatePicker(),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25.0),
                    child: AlarmSettingInputFields(),
                  )
                ]
              ),
            )
          )
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        color: lightGrey,
        child: SizedBox(
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Spacer(),
              SettingBottomNavBarItem(itemLabel: 'Cancel'),
              Spacer(),
              SettingBottomNavBarItem(itemLabel: 'Save', toSave: true,),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}

class SettingBottomNavBarItem extends StatelessWidget {
  final String itemLabel;
  final bool toSave;
  const SettingBottomNavBarItem({
    Key? key, 
    required this.itemLabel,
    this.toSave = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: InkWell(
        onTap: () async {
          if (toSave) {
            DateTime now = DateTime.now();
            DateTime alarmTime = now.add(const Duration(minutes: 2));

            Alarm alarm = Alarm(isEnabled: true, alarmTime: alarmTime);

            AlarmsDatabase.instance.create(alarm);

            Navigator.pushNamed(context, '/alarm');
          } else {
            Navigator.pop(context);
          }
        },
        child: Text(
          itemLabel,
          style: GoogleFonts.nanumGothic(
            textStyle: settingBottomNavBarText,
          ),
        ),
      ),
    );
  }
}
