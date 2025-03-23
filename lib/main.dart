import 'package:flutter/material.dart';
import 'package:weatherapp/theme_services.dart';
import 'package:weatherapp/weather_screen.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light().copyWith(
        brightness: Brightness.light,
        iconTheme: IconThemeData(color: Colors.black), // Icônes noires en mode clair
      ),
      darkTheme: ThemeData.dark().copyWith(
        brightness: Brightness.dark,
        iconTheme: IconThemeData(color: Colors.white), // Icônes blanches en mode sombre
      ),
      themeMode: ThemeService().theme,

      home: const WeatherScreen(),
    );
  }
}
