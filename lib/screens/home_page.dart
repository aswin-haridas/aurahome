import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:aurahome/widgets/devices_grid.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late DatabaseReference _temperatureRef;
  late DatabaseReference _humidityRef;
  late DatabaseReference _lightsRef;
  late DatabaseReference _fanRef;
  late DatabaseReference _automationRef;
  late DatabaseReference _daylightsRef;
  late DatabaseReference _motionRef;

  String temperature = "25°C";
  String humidity = "50%";
  bool _automationValue = false;
  bool _daylightsValue = false;
  bool _motionValue = false;

  final List<List<dynamic>> devices = [
    ["Light 1", 'lib/icons/bulb.png', false],
    ["Light 2", 'lib/icons/bulb.png', false],
    ["Light 3", 'lib/icons/bulb.png', false],
    ["Fan", 'lib/icons/fan.png', false],
  ];

  @override
  void initState() {
    super.initState();
    _initializeFirebaseReferences();
    _setFirebaseListeners();
  }

  void _initializeFirebaseReferences() {
    _temperatureRef = FirebaseDatabase.instance.ref().child('temperature');
    _humidityRef = FirebaseDatabase.instance.ref().child('humidity');
    _lightsRef = FirebaseDatabase.instance.ref().child('lights');
    _fanRef = FirebaseDatabase.instance.ref().child('fan');
    _automationRef = FirebaseDatabase.instance.ref().child('automation');
    _daylightsRef = FirebaseDatabase.instance.ref().child('daylight');
    _motionRef = FirebaseDatabase.instance.ref().child('motion');
  }

  void _setFirebaseListeners() {
    _temperatureRef.onValue.listen((event) {
      setState(() {
        temperature = "${(event.snapshot.value ?? 0.0)}°C";
      });
    });

    _humidityRef.onValue.listen((event) {
      setState(() {
        humidity = "${(event.snapshot.value ?? 0.0)}%";
      });
    });

    _lightsRef.onValue.listen((event) {
      final Map<dynamic, dynamic> lights =
          event.snapshot.value as Map<dynamic, dynamic>;
      for (int i = 0; i < 3; i++) {
        setState(() {
          devices[i][2] = lights['light ${i + 1}'] ?? false;
        });
      }
    });

    _fanRef.onValue.listen((event) {
      setState(() {
        devices[3][2] = (event.snapshot.value ?? false) as bool;
      });
    });

    _automationRef.onValue.listen((event) {
      setState(() {
        _automationValue = (event.snapshot.value ?? false) as bool;
      });
    });

    _daylightsRef.onValue.listen((event) {
      setState(() {
        _daylightsValue = (event.snapshot.value ?? false) as bool;
      });
    });

    _motionRef.onValue.listen((event) {
      setState(() {
        _motionValue = (event.snapshot.value ?? false) as bool;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lime[100],
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              const SizedBox(height: 60),
              _buildEnvironmentInfo(),
              const SizedBox(height: 60),
              _buildDevicesGrid(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        const Text(
          'Aura',
          style: TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 30, 28, 3),
          ),
        ),
        const Spacer(),
        Switch(
          inactiveTrackColor: Colors.lime[800],
          inactiveThumbColor: Colors.lime[200],
          activeColor: Colors.lime[800],
          value: _automationValue,
          onChanged: (value) {
            _automationRef.set(value);
            setState(() {
              _automationValue = value;
            });
          },
        ),
      ],
    );
  }

  Widget _buildEnvironmentInfo() {
    return Row(
      children: [
        const SizedBox(width: 8),
        _buildTemperatureAndHumidityInfo(),
        const SizedBox(width: 80),
        _buildIcons(),
      ],
    );
  }

  Widget _buildTemperatureAndHumidityInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildInfoText('Temperature', temperature),
        const SizedBox(height: 40),
        _buildInfoText('Humidity', humidity),
      ],
    );
  }

  Widget _buildInfoText(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w400,
            color: Colors.black,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.w400,
            color: Colors.black,
          ),
        ),
      ],
    );
  }

  Widget _buildIcons() {
    return Column(
      children: [
        Icon(
          _daylightsValue ? Icons.sunny : Icons.bedtime_outlined,
          color: Colors.lime[800],
          size: 60,
        ),
        const SizedBox(height: 60),
        Icon(
          Icons.directions_walk,
          color: _motionValue ? Colors.lime[800] : Colors.lime[200],
          size: 60,
        ),
      ],
    );
  }

  Widget _buildDevicesGrid() {
    return Expanded(
      child: GridView.builder(
        itemCount: devices.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.5,
        ),
        itemBuilder: (context, index) {
          return DevicesGrid(
            deviceName: devices[index][0] as String,
            iconPath: devices[index][1] as String,
            initialIsOn: devices[index][2] as bool,
            onChanged: (value) => _updateDeviceState(index, value),
          );
        },
      ),
    );
  }

  void _updateDeviceState(int index, bool newState) {
    if (index <= 2) {
      _lightsRef.update({'light ${index + 1}': newState});
    } else {
      _fanRef.set(newState);
    }
  }
}
