import 'dart:async';

import 'package:flutter/material.dart';

class StopwatchProvider with ChangeNotifier {
  late Timer stopwatch;
  static late Timer lapStopwatch;

  int _minute = 0;
  int _second = 0;
  int _millisecond = 0;

  int _lapMinute = 0;
  int _lapSecond = 0;
  int _lapMillisecond = 0;

  bool _isLapRunning = false;

  bool get isLapRunning => _isLapRunning;

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

  String get lapMinute {
    if (_lapMinute < 10) {
      return '0$_lapMinute';
    }
    return '$_lapMinute';
  }

  String get lapSecond {
    if (_lapSecond < 10) {
      return '0$_lapSecond';
    }
    return '$_lapSecond';
  }

  String get lapMillisecond {
    if (_lapMillisecond < 10) {
      return '0$_lapMillisecond';
    }
    return '$_lapMillisecond';
  }

  void startTimer({bool isFromPause=false}) {
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

  void startLapTimer({bool isFromPause=false}) {
    lapStopwatch = Timer.periodic(const Duration(milliseconds: 10), (timer) { 
      _lapMillisecond++;
      if (_lapMillisecond == 100) {
        _lapMillisecond = 0;
        _lapSecond++;
      }
      if (_lapSecond == 60) {
        _lapSecond = 0;
        _lapMinute++;
      }
      _isLapRunning = true;
      notifyListeners();
    });
  }

  void resetLapTimer() {
    lapStopwatch.cancel();

    _lapMinute = 0;
    _lapSecond = 0;
    _lapMillisecond = 0;

    lapStopwatch = Timer.periodic(const Duration(milliseconds: 10), (timer) { 
      _lapMillisecond++;
      if (_lapMillisecond == 100) {
        _lapMillisecond = 0;
        _lapSecond++;
      }
      if (_lapSecond == 60) {
        _lapSecond = 0;
        _lapMinute++;
      }
      _isLapRunning = true;
      notifyListeners();
    });
  }

  void resetTimer() {
    stopTimer();

    _minute = 0;
    _second = 0;
    _millisecond = 0;

    _lapMinute = 0;
    _lapSecond = 0;
    _lapMillisecond = 0;
    _isLapRunning = false;
    notifyListeners();
  }

  void stopTimer() {
    stopwatch.cancel();
    lapStopwatch.cancel();
    notifyListeners();
  }
}