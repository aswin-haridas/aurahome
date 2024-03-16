import 'package:flutter/material.dart';

class DevicesGrid extends StatelessWidget {
  final String deviceName;
  final String iconPath;
  final bool isOn;
  final Function(bool)? onChanged;

  const DevicesGrid({
    super.key,
    required this.deviceName,
    required this.iconPath,
    required this.isOn,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: isOn? Colors.black : Colors.grey[200]
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Row(
                children: [
                  Image.asset(
                    iconPath,
                    height: 35,
                    color: isOn? Colors.yellow : Colors.black87,
                  ),
                  const Spacer(),
                  Switch(value: isOn,
                   onChanged: onChanged,
                   inactiveTrackColor: Colors.white,
                  activeColor: Colors.grey,),
                ],
              ),
              Text(
                deviceName,
                style:TextStyle(color: isOn? Colors.white : Colors.black87) ,
                textAlign: TextAlign.left,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
