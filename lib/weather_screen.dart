import 'package:flutter/material.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(
          'Weather App',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          /* GestureDetector(
          onTap: () {
            print('Refresh');
          },
          child: const Icon(Icons.refresh)) */
          InkWell(
          onTap: () {
            print('Refresh');
          },
          child: const Icon(Icons.refresh))
          ],
      ),
    );
  }
}
