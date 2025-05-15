import 'dart:async';
import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:frontend/services/api_service.dart';

class SensorTrackingPage extends StatefulWidget {
  const SensorTrackingPage({super.key});

  @override
  State<SensorTrackingPage> createState() => _SensorTrackingPageState();
}

class _SensorTrackingPageState extends State<SensorTrackingPage> {
  double accX = 0, accY = 0, accZ = 0;
  double gyroX = 0, gyroY = 0, gyroZ = 0;
  String prediction = 'Waiting...';

  late StreamSubscription _accelSub;
  late StreamSubscription _gyroSub;
  Timer? _sendTimer;

  @override
  void initState() {
    super.initState();
    _startSensors();
    _startSendingData();
  }

  void _startSensors() {
    _accelSub = accelerometerEvents.listen((event) {
      setState(() {
        accX = event.x;
        accY = event.y;
        accZ = event.z;
      });
    });

    _gyroSub = gyroscopeEvents.listen((event) {
      setState(() {
        gyroX = event.x;
        gyroY = event.y;
        gyroZ = event.z;
      });
    });
  }

  void _startSendingData() {
    _sendTimer = Timer.periodic(const Duration(seconds: 1), (_) async {
      try {
        final response = await predictBehavior({
          "AccX": accX,
          "AccY": accY,
          "AccZ": accZ,
          "GyroX": gyroX,
          "GyroY": gyroY,
          "GyroZ": gyroZ,
        });

        setState(() {
          prediction = response['prediction'] ?? 'Unknown';
        });
      } catch (e) {
        setState(() => prediction = 'Connection error');
      }
    });
  }

  @override
  void dispose() {
    _accelSub.cancel();
    _gyroSub.cancel();
    _sendTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Live Driver Behavior')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Prediction: $prediction', style: const TextStyle(fontSize: 20)),
            const SizedBox(height: 20),
            Text('Acceleration → X: $accX, Y: $accY, Z: $accZ'),
            Text('Gyroscope → X: $gyroX, Y: $gyroY, Z: $gyroZ'),
          ],
        ),
      ),
    );
  }
}
