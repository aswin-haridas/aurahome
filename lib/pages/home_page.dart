import 'package:aurahome/util/devices_grid.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final String font = "monopsace";

  final List devices = [
    ["Light1", 'lib/icons/bulb.png', false],
    ["Light2", 'lib/icons/bulb.png', false],
    ["Light3", 'lib/icons/bulb.png', false],
    ["fan", 'lib/icons/fan.png', false],
  ];

  void powerSwtitchChanged(bool value, int index) {
    setState(() {
      devices[index][2] = value;
    });
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
                    Text(
                      'Bedroom',
                      style: TextStyle(fontSize: 24, fontFamily: font),
                    ),
                    Text(
                      'Livingroom',
                      style: TextStyle(
                          fontSize: 24,
                          fontFamily: font,
                          color: Colors.black26),
                    ),
                    Text(
                      'Kitchen',
                      style: TextStyle(
                          fontSize: 24,
                          fontFamily: font,
                          color: Colors.black26),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text('t', style: TextStyle(fontSize: 60, fontFamily: font)),
                  Text('H', style: TextStyle(fontSize: 60, fontFamily: font)),
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
                      onChanged: (value) => powerSwtitchChanged(value, index),
                    );
                  },
                ),
              ))
            ],
          ),
        ));
  }
}
