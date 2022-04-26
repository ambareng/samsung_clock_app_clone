import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:samsung_clock_app_clone/constants/text_sizes.dart';
import 'package:samsung_clock_app_clone/constants/text_styles.dart';
import 'package:samsung_clock_app_clone/models/lap_time.dart';
import 'package:samsung_clock_app_clone/providers/lap_times_list_provider.dart';
import 'package:samsung_clock_app_clone/providers/stopwatch_provider.dart';
import 'package:samsung_clock_app_clone/widgets/bottom_nav_bar.dart';

int minute = 0;
int second = 0;
int millisecond = 0;

bool isLapRunning = false;

enum stopwatchStates {
  running, paused, stopped   
}

class Stopwatch extends StatelessWidget {
  const Stopwatch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        // padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.25),
        child: Column(
          children: [
            const Spacer(flex: 6),
            const TimerWidget(),
            Provider.of<StopwatchProvider>(context).isLapRunning == true ? const TimerLaps() : Container(),
            const TimerButtons(),
            const Spacer(flex: 1),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}

class TimerLaps extends StatelessWidget {
  const TimerLaps({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return ListView.builder(
    //   itemCount: 1,
    //   itemBuilder: (context, index) {
    //     if (index == 0) {
    //       return 
    //     }
    //   }
    // );
    return Expanded(
      flex: 12,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.4,
        margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.05),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).size.height * 0.01,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'Lap',
                    style: GoogleFonts.nanumGothic(
                      textStyle: const TextStyle(
                        color: Colors.grey,
                        fontSize: small
                      ),
                    ),
                  ),
                  Text(
                    'Lap Times',
                    style: GoogleFonts.nanumGothic(
                      textStyle: const TextStyle(
                        color: Colors.grey,
                        fontSize: small
                      ),
                    ),
                  ),
                  Text(
                    'Overall Time',
                    style: GoogleFonts.nanumGothic(
                      textStyle: const TextStyle(
                        color: Colors.grey,
                        fontSize: small
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Divider(
              color: Colors.grey,
              indent: 50.0,
              endIndent: 50.0,
              thickness: 0.75,
            ),
            MediaQuery.removePadding(
              context: context,
              removeTop: true,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: Provider.of<LapTimesListProvider>(context).lapTimesList.length,
                itemBuilder: (context, index) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15.0),
                        child: Text(
                          Provider.of<LapTimesListProvider>(context).lapTimesList[index].lapOrder,
                          style: GoogleFonts.nanumGothic(
                            textStyle: const TextStyle(
                              color: Colors.grey,
                              fontSize: small
                            ),
                          ),
                        ),
                      ),
                      Text(
                        Provider.of<LapTimesListProvider>(context).lapTimesList[index].lapTime,
                        style: GoogleFonts.nanumGothic(
                          textStyle: const TextStyle(
                            color: Colors.grey,
                            fontSize: small
                          ),
                        ),
                      ),
                      Text(
                        Provider.of<LapTimesListProvider>(context).lapTimesList[index].overallTime,
                        style: GoogleFonts.nanumGothic(
                          textStyle: const TextStyle(
                            color: Colors.grey,
                            fontSize: small
                          ),
                        ),
                      ),
                    ],
                  );
                }
              ),
            )
          ],
        )
      ),
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
        isLapRunning = false;
      } else if (currentStopwatchState == stopwatchStates.paused) {
        currentStopwatchState = stopwatchStates.running;
        context.read<StopwatchProvider>().startTimer(isFromPause: true);
        if (context.read<StopwatchProvider>().isLapRunning) {
          isLapRunning = true;
          context.read<StopwatchProvider>().startLapTimer();
        }
      }
    });
  }

  void resetLapStopwatchHandler(BuildContext context) {
    setState(() {
      if (currentStopwatchState == stopwatchStates.running) {
        // lapHandler();
        if (context.read<StopwatchProvider>().isLapRunning) {
          addLapTime(context);
          isLapRunning = true;
          context.read<StopwatchProvider>().resetLapTimer();
        } else {
          isLapRunning = true;
          context.read<StopwatchProvider>().startLapTimer();
          addLapTime(context);
        }
      } else if (currentStopwatchState == stopwatchStates.paused) {
        currentStopwatchState = stopwatchStates.stopped;
        context.read<StopwatchProvider>().resetTimer();
        context.read<LapTimesListProvider>().resetLapTimeList();
      }
    });
  }

  void addLapTime(BuildContext context) {
    LapTime lapTime = LapTime(
      lapOrder: '0${(context.read<LapTimesListProvider>().lapTimesList.length) + 1}', 
      lapTime: '${context.read<StopwatchProvider>().lapMinute}:${context.read<StopwatchProvider>().lapSecond}.${context.read<StopwatchProvider>().lapMillisecond}', 
      overallTime: '${context.read<StopwatchProvider>().minute}:${context.read<StopwatchProvider>().second}.${context.read<StopwatchProvider>().millisecond}'
    );
    context.read<LapTimesListProvider>().setLapTime(lapTime);
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Row(
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
      ),
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
    return Expanded(
      flex: 5,
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.125,
        child: Column(
          children: [
            Text(
              '${context.watch<StopwatchProvider>().minute}:${context.watch<StopwatchProvider>().second}.${context.watch<StopwatchProvider>().millisecond}',
              style: GoogleFonts.nanumGothic(
                textStyle: timer,
              ),
            ),
            context.watch<StopwatchProvider>().isLapRunning ?
            Text(
              '${context.watch<StopwatchProvider>().lapMinute}:${context.watch<StopwatchProvider>().lapSecond}.${context.watch<StopwatchProvider>().lapMillisecond}',
              style: GoogleFonts.nanumGothic(
                textStyle: lapTimer,
              ),
            )
            :
            Container()
          ],
        ),
      ),
    );
  }
}
