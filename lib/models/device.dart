class Device {
  final String name;
  final String iconPath;
  bool isOn;

  Device({
    required this.name,
    required this.iconPath,
    this.isOn = false,
  });
}