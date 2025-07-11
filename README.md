# AuraHome

AuraHome is a smart home application built using the Flutter framework. It allows users to control and manage various smart home devices seamlessly. The application leverages Firebase for real-time data synchronization and provides a user-friendly interface for an intuitive experience.

## Features

- **Device Control:** Easily control and manage smart home devices such as lights, fans, and other connected appliances.
- **Real-time Updates:** Utilizes Firebase Realtime Database to ensure that the status of devices is always up-to-date across all connected clients.
- **User-Friendly Interface:** Designed with a clean and intuitive interface, making it easy for users to navigate and control their smart home environment.
- **Customizable Themes:** Offers customizable themes to personalize the app's appearance according to user preferences.
- **Cross-Platform:** Built with Flutter, AuraHome is a cross-platform application that can run on Android, iOS, and other platforms supported by Flutter.

## Installation

To get started with AuraHome, follow these steps:

1. **Clone the repository:**
   ```bash
   git clone https://github.com/your-username/aurahome.git
   ```
   (Replace `your-username` with the actual username or organization name)
2. **Navigate to the project directory:**
   ```bash
   cd aurahome
   ```
3. **Install dependencies:**
   Ensure you have Flutter SDK installed. Run the following command to fetch the project dependencies:
   ```bash
   flutter pub get
   ```

## Usage

After successfully installing the dependencies, you can run the application on a connected device or an emulator.

1. **Ensure you have a device or emulator running.**
2. **Run the app using the following command:**
   ```bash
   flutter run
   ```

## Dependencies

AuraHome relies on the following key packages:

- **`flutter`**: The core Flutter framework.
- **`cupertino_icons`**: Provides iOS-style icons.
- **`google_fonts`**: For using custom fonts from Google Fonts.
- **`firebase_core`**: Required for initializing Firebase.
- **`firebase_database`**: For interacting with Firebase Realtime Database.
- **`provider`**: For state management.

For a full list of dependencies, please refer to the `pubspec.yaml` file.

## Contributing

Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

## License

[MIT](https://choosealicense.com/licenses/mit/)
