import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:weatherapp/additional_info.dart';
import 'package:weatherapp/hourly_forecast_Item.dart';
import 'package:http/http.dart' as http;
import 'package:weatherapp/secrets.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  double temp = 0;
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    getWeatherCurrent();
  }

  Future getWeatherCurrent() async {
    try {
      setState(() {
        isLoading = true;
      });
      String cityName = 'London';
      final res = await http.get(Uri.parse(
          'https://api.openweathermap.org/data/2.5/forecast?q=$cityName&APPID=$openWeatherAPIKey'));
      final data = jsonDecode(res.body);

      if (data['cod'] != '200') {
        throw 'Error: ${data['message']}.';
      }

      setState(() {
        temp = data['list'][0]['main']['temp'];
        isLoading = false;
      });
    } catch (e) {
      throw e.toString();
    }
  }

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
              // print('object');
            },
            icon: Icon(Icons.refresh),
          ),
        ],
      ),
      body: isLoading // or temp ==0
          ? Center(child: CircularProgressIndicator(color: Colors.white,))
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                //crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //main card
                  SizedBox(
                    width: double.infinity,
                    child: Card(
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                          child: Padding(
                            padding: const EdgeInsets.all(14.0),
                            child: Column(
                              children: [
                                Text(
                                  '${temp.toString()}K',
                                  style: TextStyle(
                                    fontSize: 32,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                const Icon(
                                  Icons.cloud,
                                  size: 60,
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                const Text(
                                  'Rain',
                                  style: TextStyle(fontSize: 20),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: const Text(
                      'Weather Forecast',
                      style:
                          TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  // weather forecast card
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        HourlyForecastItem(
                          hour: '00:00',
                          temperature: '301.22',
                          icon: Icons.cloud,
                        ),
                        HourlyForecastItem(
                          hour: '03:00',
                          temperature: '300.52',
                          icon: Icons.sunny,
                        ),
                        HourlyForecastItem(
                          hour: '06:00',
                          temperature: '302.22',
                          icon: Icons.cloud,
                        ),
                        HourlyForecastItem(
                          hour: '09:00',
                          temperature: '300.12',
                          icon: Icons.sunny,
                        ),
                        HourlyForecastItem(
                          hour: '12:00',
                          temperature: '404:12',
                          icon: Icons.cloud,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: const Text(
                      'Additional Information',
                      style:
                          TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  // weather additional information
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      AdditionalIInfoItem(
                        icon: Icons.water_drop_rounded,
                        label: 'Humidity',
                        value: '94',
                      ),
                      SizedBox(width: 10),
                      AdditionalIInfoItem(
                        icon: Icons.air,
                        label: 'Wind speed',
                        value: '7.67',
                      ),
                      SizedBox(width: 10),
                      AdditionalIInfoItem(
                        icon: Icons.beach_access,
                        label: 'Pressure',
                        value: '1006',
                      ),
                    ],
                  ),
                ],
              ),
            ),
    );
  }
}
