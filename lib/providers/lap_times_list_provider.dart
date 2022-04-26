import 'package:flutter/material.dart';
import 'package:samsung_clock_app_clone/models/lap_time.dart';

class LapTimesListProvider with ChangeNotifier {
  static List<LapTime> _lapTimesList = [];

  List<LapTime> get lapTimesList => _lapTimesList;

  void setLapTime(LapTime lapTime) {
    _lapTimesList.add(lapTime);
    notifyListeners();
  }

  void resetLapTimeList() {
    _lapTimesList = [];
    notifyListeners();
  }
}
