import 'package:aurahome/util/devices_grid.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';


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
  bool isOn = false;
  String temperature = "25°C";
  String humidity = "50%";

  final List devices = [
    ["Light1", 'lib/icons/bulb.png', false],
    ["Light2", 'lib/icons/bulb.png', false],
    ["Light3", 'lib/icons/bulb.png', false],
    ["fan", 'lib/icons/fan.png', false],
  ];

  void powerSwitchChanged(bool value, int index) {
    setState(() {
      devices[index][2] = value;
    });
    if (index < 3) {
      _lightsRef.child('light${index + 1}').set(value);
    } else {
      _fanRef.set(value);
    }
  }

 @override
    void initState() {
    super.initState();
    _temperatureRef = FirebaseDatabase.instance.ref().child('temperature');
    _temperatureRef.onValue.listen((event) {
      setState(() {
        temperature = "${(double.tryParse(event.snapshot.value.toString()) ?? 0.0)
                .toStringAsFixed(1)}°C";
      });
    });

    _humidityRef = FirebaseDatabase.instance.ref().child('humidity');
    _humidityRef.onValue.listen((event) {
      setState(() {
        humidity = "${(double.tryParse(event.snapshot.value.toString()) ?? 0.0)
                .toStringAsFixed(1)}%";
      });
    });

    _lightsRef = FirebaseDatabase.instance.ref().child('lights');
    _lightsRef.onValue.listen((event) {
      final Map lights = event.snapshot.value as Map;
      for (int i = 1; i <= 3; i++) {
        setState(() {
          devices[i - 1][2] = lights['light$i'];
        });
      }
        });

    _fanRef = FirebaseDatabase.instance.ref().child('fan');
    _fanRef.onValue.listen((event) {
      final fan = event.snapshot.value;
      if (fan != null) {
        setState(() {
          devices[3][2] = fan;
        });
      }
    });
  }


  @override
  void dispose() {
    _temperatureRef.onDisconnect();
    _humidityRef.onDisconnect();
    _lightsRef.onDisconnect();
    _fanRef.onDisconnect();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            children: [
              //appbar
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                      'lib/icons/menu.png',
                      height: 30,
                    ),
                    const Text(
                      'Bedroom',
                      style: TextStyle(fontSize: 24),
                    ),
                    const Text(
                      'Livingroom',
                      style: TextStyle(
                          fontSize: 24,
                          color: Colors.black26),
                    ),
                    const Text(
                      'Kitchen',
                      style: TextStyle(
                          fontSize: 24,
                          color: Colors.black26),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(temperature, style: const TextStyle(fontSize: 60,)),
                  Text(humidity, style: const TextStyle(fontSize: 60,)),
                ],
              ),

              

              const SizedBox(height: 40),

              Expanded(
                  child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: GridView.builder(
                  itemCount: devices.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemBuilder: (context, index) {
                    return DevicesGrid(
                      deviceName: devices[index][0],
                      iconPath: devices[index][1],
                      isOn: devices[index][2],
                      onChanged: (value) => powerSwitchChanged(value, index),
                    );
                  },
                ),
              ))
            ],
          ),
        ));
  }
}
