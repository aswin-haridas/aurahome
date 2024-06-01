import 'package:aurahome/models/device.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class HomeData extends ChangeNotifier {
  final DatabaseReference _temperatureRef =
      FirebaseDatabase.instance.ref().child('temperature');
  final DatabaseReference _humidityRef =
      FirebaseDatabase.instance.ref().child('humidity');
  final DatabaseReference _lightsRef =
      FirebaseDatabase.instance.ref().child('lights');
  final DatabaseReference _fanRef = FirebaseDatabase.instance.ref().child('fan');
  final DatabaseReference _automationRef =
      FirebaseDatabase.instance.ref().child('automation');
  final DatabaseReference _daylightsRef =
      FirebaseDatabase.instance.ref().child('daylight');
  final DatabaseReference _motionRef =
      FirebaseDatabase.instance.ref().child('motion');

  String temperature = '25°C';
  String humidity = '50%';

  // Declare the values as fields
  late bool automationValue;
  late bool daylightsValue;
  late bool motionValue;

  List<Device> devices = [
    Device(name: 'Light 1', iconPath: 'assets/icons/bulb.png', isOn: false),
    Device(name: 'Light 2', iconPath: 'assets/icons/bulb.png', isOn: false),
    Device(name: 'Light 3', iconPath: 'assets/icons/bulb.png', isOn: false),
    Device(name: 'Fan', iconPath: 'assets/icons/fan.png', isOn: false),
  ];

  HomeData() {
    _initializeFirebaseListeners();
  }

  void _initializeFirebaseListeners() {
    _temperatureRef.onValue.listen((event) {
      temperature = '${(event.snapshot.value ?? 0.0)}°C';
      notifyListeners();
    });

    _humidityRef.onValue.listen((event) {
      humidity = '${(event.snapshot.value ?? 0.0)}%';
      notifyListeners();
    });

    _lightsRef.onValue.listen((event) {
      final Map<dynamic, dynamic> lights =
          event.snapshot.value as Map<dynamic, dynamic>;
      for (int i = 0; i < 3; i++) {
        devices[i].isOn = lights['light ${i + 1}'] ?? false;
      }
      notifyListeners();
    });

    _fanRef.onValue.listen((event) {
      devices[3].isOn = (event.snapshot.value ?? false) as bool;
      notifyListeners();
    });

    _automationRef.onValue.listen((event) {
      automationValue = (event.snapshot.value ?? false) as bool;
      notifyListeners();
    });

    _daylightsRef.onValue.listen((event) {
      daylightsValue = (event.snapshot.value ?? false) as bool;
      notifyListeners();
    });

    _motionRef.onValue.listen((event) {
      motionValue = (event.snapshot.value ?? false) as bool;
      notifyListeners();
    });
  }

  void updateDeviceState(int index, bool newState) {
    if (index <= 2) {
      _lightsRef.update({'light ${index + 1}': newState});
    } else {
      _fanRef.set(newState);
    }
  }

  void updateAutomation(bool value) {
    _automationRef.set(value);
    automationValue = value;
    notifyListeners();
  }
}