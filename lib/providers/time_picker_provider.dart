import 'package:flutter/material.dart';

class TimePickerProvider with ChangeNotifier {
  String _hourSelected = '1';
  String _minuteSelected = '00';
  String _meridianSelected = 'AM';

  String get hourSelected => _hourSelected;
  String get minuteSelected => _minuteSelected;
  String get meridianSelected => _meridianSelected;

  void setHourSelected({required String value}) {
    _hourSelected = value;
    notifyListeners();
  }

  void setMinuteSelected({required String value}) {
    _minuteSelected = value;
    notifyListeners();
  }

  void setMeridianSelected({required String value}) {
    _meridianSelected = value;
    notifyListeners();
  }
}
