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
          IconButton(
            onPressed: () {
              print('object');
            },
            icon: Icon(Icons.refresh),
          ),
        ],
      ),
      body: Column(
        children: [
          //main card
          const Placeholder(
            fallbackHeight: 250,
            //child: const Text('Main Card'),
          ),
          const SizedBox(
            height: 20,
          ),
          // weather forecast card
          const Placeholder(
            fallbackHeight: 150,
          ),
          const SizedBox(
            height: 20,
          ),
          // sweather additonal information
          const Placeholder(
            fallbackHeight: 150,
          ),
        ],
      ),
    );
  }
}
