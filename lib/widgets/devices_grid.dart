import 'package:flutter/material.dart';

class DevicesGrid extends StatefulWidget {
  final String deviceName;
  final String iconPath;
  final bool initialIsOn;
  final Function(bool) onChanged;

  const DevicesGrid({
    super.key,
    required this.deviceName,
    required this.iconPath,
    required this.initialIsOn,
    required this.onChanged,
  });

  @override
  State<DevicesGrid> createState() => _DevicesGridState();
}

class _DevicesGridState extends State<DevicesGrid> {
  late bool isOn;

  @override
  void initState() {
    super.initState();
    isOn = widget.initialIsOn;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        splashColor: Colors.transparent,
        onTap: () {
          setState(() {
            isOn = !isOn;
            widget.onChanged(isOn);
          });
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            color: isOn ? const Color.fromARGB(255, 103, 108, 46) : Colors.lime[200],
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Image.asset(
                    widget.iconPath,
                    height: 35,
                    color: isOn ? const Color(0xFFEDFFDF) : const Color(0xFF604E1B),
                  ),
                  const SizedBox(width: 8.0),
                  Expanded(
                    child: Text(
                      widget.deviceName,
                      style: TextStyle(
                        color: isOn ? const Color(0xFFEDFFDF) : Colors.black,
                      ),
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
