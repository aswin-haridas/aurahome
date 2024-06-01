import 'package:aurahome/models/device.dart';
import 'package:aurahome/utils/app_constants.dart';
import 'package:flutter/material.dart';

class DeviceGridItem extends StatelessWidget {
  final Device device;
  final Function(bool) onChanged;

  const DeviceGridItem({
    super.key,
    required this.device,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      onTap: () {
        onChanged(!device.isOn);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          color: device.isOn
              ? AppConstants.deviceOnColor
              : AppConstants.deviceOffColor,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Image.asset(
                  device.iconPath,
                  height: 35,
                  color: device.isOn
                      ? AppConstants.deviceIconOnColor
                      : AppConstants.deviceIconOffColor,
                ),
                const SizedBox(width: 8.0),
                Expanded(
                  child: Text(
                    device.name,
                    style: TextStyle(
                      color: device.isOn
                          ? AppConstants.deviceIconOnColor
                          : AppConstants.textColor,
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
    );
  }
}