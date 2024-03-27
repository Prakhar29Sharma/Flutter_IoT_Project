import 'package:dashed_circular_progress_bar/dashed_circular_progress_bar.dart';
import 'package:flutter/material.dart';

class DistanceProgressScreen extends StatefulWidget {
  final double distance;

  const DistanceProgressScreen({Key? key, required this.distance}) : super(key: key);

  @override
  _DistanceProgressScreenState createState() => _DistanceProgressScreenState();
}

class _DistanceProgressScreenState extends State<DistanceProgressScreen> {
  final ValueNotifier<double> _distanceNotifier = ValueNotifier<double>(0);

  @override
  void initState() {
    super.initState();
    _distanceNotifier.value = 100 - widget.distance/200*100; // Update _distanceNotifier with initial distance value
  }

  @override
  Widget build(BuildContext context) {
    return DashedCircularProgressBar.aspectRatio(
      aspectRatio: 1, // width ÷ height
      valueNotifier: _distanceNotifier,
      progress: 100 - widget.distance/200*100, // Initially set to the distance value
      startAngle: 225,
      sweepAngle: 270,
      foregroundColor: 100 - widget.distance/200*100 < 25 ? Colors.red : 100 - widget.distance/200*100 < 60 ? Colors.orange : Colors.green,
      backgroundColor: const Color(0xffeeeeee),
      foregroundStrokeWidth: 15,
      backgroundStrokeWidth: 15,
      animation: true,
      seekSize: 6,
      seekColor: const Color(0xffeeeeee),
      child: Center(
        child: ValueListenableBuilder(
          valueListenable: _distanceNotifier,
          builder: (_, double distance, __) => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '${(100 - widget.distance/200*100).toStringAsFixed(2)} %', // Display distance in centimeters
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w300,
                  fontSize: 60,
                ),
              ),
              const Text(
                'Level',
                style: TextStyle(
                  color: Color(0xff333333),
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
