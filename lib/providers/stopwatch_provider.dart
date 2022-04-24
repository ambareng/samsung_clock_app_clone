import 'dart:async';

import 'package:flutter/material.dart';

class StopwatchProvider with ChangeNotifier {
  late Timer stopwatch;
  int _minute = 0;
  int _second = 0;
  int _millisecond = 0;

  String get minute {
    if (_minute < 10) {
      return '0$_minute';
    }
    return '$_minute';
  }

  String get second {
    if (_second < 10) {
      return '0$_second';
    }
    return '$_second';
  }

  String get millisecond {
    if (_millisecond < 10) {
      return '0$_millisecond';
    }
    return '$_millisecond';
  }

  void startTimer() {
    stopwatch = Timer.periodic(const Duration(milliseconds: 10), (timer) { 
      _millisecond++;
      if (_millisecond == 100) {
        _millisecond = 0;
        _second++;
      }
      if (_second == 60) {
        _second = 0;
        _minute++;
      }
      notifyListeners();
    });
  }

  void resetTimer() {
    stopTimer();

    _minute = 0;
    _second = 0;
    _millisecond = 0;
    notifyListeners();
  }

  void stopTimer() {
    stopwatch.cancel();
    notifyListeners();
  }
}