import 'package:aurahomev1/utils/app_constants.dart';
import 'package:flutter/material.dart';

class EnvironmentInfo extends StatelessWidget {
  final String temperature;
  final String humidity;
  final bool daylightsValue;
  final bool motionValue;

  const EnvironmentInfo({
    super.key,
    required this.temperature,
    required this.humidity,
    required this.daylightsValue,
    required this.motionValue,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Temperature',
                style: Theme.of(context).textTheme.displayMedium,
              ),
              const SizedBox(height: 8),
              Text(
                temperature,
                style: Theme.of(context).textTheme.displayLarge,
              ),
              const SizedBox(height: 20),
              Text(
                'Humidity',
                style: Theme.of(context).textTheme.displayMedium,
              ),
              const SizedBox(height: 8),
              Text(
                humidity,
                style: Theme.of(context).textTheme.displayLarge,
              ),
            ],
          ),
        ),
        const SizedBox(width: 40),
        Column(
          children: [
            Icon(
              daylightsValue ? Icons.sunny : Icons.bedtime_outlined,
              color: AppConstants.primaryColor,
              size: 60,
            ),
            const SizedBox(height: 30),
            Icon(
              Icons.directions_walk,
              color: motionValue ? AppConstants.primaryColor : Colors.grey,
              size: 60,
            ),
          ],
        ),
      ],
    );
  }
}