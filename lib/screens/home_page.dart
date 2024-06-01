import 'package:aurahome/models/home_data.dart';
import 'package:aurahome/screens/settings_page.dart';
import 'package:aurahome/utils/app_constants.dart';
import 'package:aurahome/widgets/device_grid_item.dart';
import 'package:aurahome/widgets/environment_info.dart';
import 'package:aurahome/widgets/header.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomeData(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppConstants.primaryColor,
          title: const Text(
            'AuraHome',
            style: TextStyle(
              color: AppConstants.textColor,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SettingsPage(),
                  ),
                );
              },
              icon: const Icon(Icons.settings),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Consumer<HomeData>(
            builder: (context, homeData, child) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Header(),
                  const SizedBox(height: 20),
                  EnvironmentInfo(
                    temperature: homeData.temperature,
                    humidity: homeData.humidity,
                    daylightsValue: homeData.daylightsValue,
                    motionValue: homeData.motionValue,
                  ),
                  const SizedBox(height: 30),
                  Expanded(
                    child: GridView.builder(
                      itemCount: homeData.devices.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                      ),
                      itemBuilder: (context, index) {
                        return DeviceGridItem(
                          device: homeData.devices[index],
                          onChanged: (value) {
                            homeData.updateDeviceState(index, value);
                          },
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Switch(
                        activeColor: AppConstants.primaryColor,
                        inactiveThumbColor: AppConstants.backgroundLightColor,
                        inactiveTrackColor: AppConstants.primaryColor,
                        value: homeData.automationValue,
                        onChanged: (value) {
                          homeData.updateAutomation(value);
                        },
                      ),
                      const SizedBox(width: 10),
                      const Text(
                        'Automation',
                        style: TextStyle(
                          color: AppConstants.textColor,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}