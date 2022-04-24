import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:samsung_clock_app_clone/constants/text_sizes.dart';
import 'package:samsung_clock_app_clone/constants/text_styles.dart';
import 'package:samsung_clock_app_clone/providers/stopwatch_provider.dart';
import 'package:samsung_clock_app_clone/widgets/bottom_nav_bar.dart';

int minute = 0;
int second = 0;
int millisecond = 0;

enum stopwatchStates {
  running, paused, stopped   
}

class Stopwatch extends StatelessWidget {
  const Stopwatch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.3),
        child: Column(
          children: const [
            TimerWidget(),
            TimerButtons(),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}

class TimerButtons extends StatefulWidget {
  const TimerButtons({
    Key? key,
  }) : super(key: key);

  @override
  State<TimerButtons> createState() => _TimerButtonsState();
}

class _TimerButtonsState extends State<TimerButtons> {
  stopwatchStates currentStopwatchState = stopwatchStates.stopped;

  void startPauseStopwatchHandler(BuildContext context) {
    setState(() {
      if (currentStopwatchState == stopwatchStates.stopped) {
        currentStopwatchState = stopwatchStates.running;
        context.read<StopwatchProvider>().startTimer();
      } else if (currentStopwatchState == stopwatchStates.running) {
        currentStopwatchState = stopwatchStates.paused;
        context.read<StopwatchProvider>().stopTimer();
      } else if (currentStopwatchState == stopwatchStates.paused) {
        currentStopwatchState = stopwatchStates.running;
        context.read<StopwatchProvider>().startTimer();
      }
    });
  }

  void resetLapStopwatchHandler(BuildContext context) {
    setState(() {
      if (currentStopwatchState == stopwatchStates.running) {
        // lapHandler();
      } else if (currentStopwatchState == stopwatchStates.paused) {
        currentStopwatchState = stopwatchStates.stopped;
        context.read<StopwatchProvider>().resetTimer();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: const StadiumBorder(),
            elevation: 0,
            primary: Colors.grey[300]
          ),
          onPressed: () => resetLapStopwatchHandler(context), 
          child: SizedBox(
            // padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 14.0),
            height: 45.0,
            width: 90.0,
            child: Center(
              child: Text(
                (currentStopwatchState == stopwatchStates.stopped) ? 'Lap' : (currentStopwatchState == stopwatchStates.running) ? 'Lap' : 'Reset',
                style: GoogleFonts.nanumGothic(
                  textStyle: const TextStyle(
                    color: Colors.black,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
            ),
          ),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: const StadiumBorder(),
            elevation: 0,
            primary: (currentStopwatchState == stopwatchStates.stopped || currentStopwatchState == stopwatchStates.paused) ? Colors.blue[800] : Colors.red[600],
          ),
          onPressed: () => startPauseStopwatchHandler(context), 
          child: SizedBox(
            // padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 14.0),
            height: 45.0,
            width: 90.0,
            child: Center(
              child: Text(
                (currentStopwatchState == stopwatchStates.stopped) ? 'Start' : (currentStopwatchState == stopwatchStates.running) ? 'Stop' : 'Resume',
                style: GoogleFonts.nanumGothic(
                  textStyle: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}

class TimerWidget extends StatefulWidget {
  const TimerWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<TimerWidget> createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<TimerWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.45),
      child: Text(
        '${context.watch<StopwatchProvider>().minute}:${context.watch<StopwatchProvider>().second}.${context.watch<StopwatchProvider>().millisecond}',
        style: GoogleFonts.nanumGothic(
          textStyle: timer,
        ),
      ),
    );
  }
}
