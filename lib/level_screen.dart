import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

import 'level_progress_bar.dart';

class DistanceScreen extends StatefulWidget {
  const DistanceScreen({super.key});
  @override
  _DistanceScreenState createState() => _DistanceScreenState();
}

class _DistanceScreenState extends State<DistanceScreen> {
  final reference = FirebaseDatabase.instance.reference().child('test').child('distance');

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: reference.onValue,
      builder: (context, snapshot) {
        if (snapshot.hasData && !snapshot.hasError && snapshot.data!.snapshot.value != null) {
          // Parse distance value from snapshot
          double distance = double.tryParse(snapshot.data!.snapshot.value.toString()) ?? 0.0;
          // Return LevelProgressBar widget with distance value
          return DistanceProgressScreen(distance: distance);
        } else {
          return const Text('No data');
        }
      },
    );
  }
}
