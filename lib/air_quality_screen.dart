import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class AirQualityScreen extends StatefulWidget {
  const AirQualityScreen({Key? key}) : super(key: key);

  @override
  _AirQualityScreenState createState() => _AirQualityScreenState();
}

class _AirQualityScreenState extends State<AirQualityScreen> {

  final reference = FirebaseDatabase.instance.reference().child('test').child('air_quality');

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: reference.onValue,
      builder: (context, snapshot) {
        if (snapshot.hasData && !snapshot.hasError && snapshot.data!.snapshot.value != null) {
          // Parse distance value from snapshot
          double distance = double.tryParse(snapshot.data!.snapshot.value.toString()) ?? 0.0;
          // Return LevelProgressBar widget with distance value
          return Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                const Text(
                  'Air Quality',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24.0,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                    (distance*1000).toStringAsFixed(2),
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 60,
                  ),
                ),
                const Text(
                  'AQI',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          );
        } else {
          return const Text('No data');
        }
      },
    );
  }
}