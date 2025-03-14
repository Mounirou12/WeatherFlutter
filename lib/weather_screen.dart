import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
  late Future<Map<String, dynamic>> weather;
  Future<Map<String, dynamic>> getWeatherCurrent() async {
    try {
      String cityName = 'London';
      final res = await http.get(Uri.parse(
          'https://api.openweathermap.org/data/2.5/forecast?q=$cityName&APPID=$openWeatherAPIKey'));
      final data = jsonDecode(res.body);

      if (data['cod'] != '200') {
        //throw 'Error: ${data['message']}.';
        throw 'An unexpected error occured';
      }
      return data;
      //data['list'][0]['main']['temp'];
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  void initState() {
    super.initState();
    weather = getWeatherCurrent();
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
              setState(() {
               // weather = getWeatherCurrent();
              });
            },
            icon: Icon(Icons.refresh),
          ),
        ],
      ),
      body: FutureBuilder(
        //future: weather,
        future: getWeatherCurrent(),
        builder: (context, snapshot) {
          //print(snapshot);
          //print(snapshot.runtimeType);
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Text(
                snapshot.error.toString(),
                style: const TextStyle(color: Colors.red),
              ),
            );
          }

          final data = snapshot.data!;
          final curentWeatherdata = data['list'][0];
          final currentWeathertemp = curentWeatherdata['main']['temp'];
          final currentSky = curentWeatherdata['weather'][0]['main'];
          final currentWeatherPressure = curentWeatherdata['main']['pressure'];
          final currentWeatherHumidity = curentWeatherdata['main']['humidity'];
          final currentWeatherWindSpeed = curentWeatherdata['wind']['speed'];
          return Padding(
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
                                '$currentWeathertemp k',
                                style: TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              Icon(
                                currentSky == 'Clouds' || currentSky == 'Rain'
                                    ? Icons.cloud
                                    : Icons.sunny,
                                size: 60,
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              Text(
                                currentSky.toString().toLowerCase(),
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
                    style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                // weather forecast card
/*                 SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      for (int i = 0; i < 39; i++)
                        HourlyForecastItem(
                          hour: data['list'][i + 1]['dt'].toString(),
                          temperature:
                              data['list'][i + 1]['main']['temp'].toString(),
                          icon: data['list'][i + 1]['weather'][0]['mai + 1n'] ==
                                      'Clouds' ||
                                  data['list'][i + 1]['weather'][0]['main'] ==
                                      'Rain'
                              ? Icons.cloud
                              : Icons.sunny,
                        ),
                    ],
                  ),
                ), */
                SizedBox(
                  height: 130,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 5, // exclude the first item (current weather)
                      itemBuilder: (context, index) {
                        final hourlyForecast = data['list'][index + 1];
                        final hourlSky =
                            data['list'][index + 1]['weather'][0]['main'];
                        final time =
                            DateTime.parse(hourlyForecast['dt_txt'].toString());
                        return HourlyForecastItem(
                          hour: DateFormat.Hm().format(time),
                          temperature:
                              hourlyForecast['main']['temp'].toString(),
                          icon: hourlSky == 'Clouds' || hourlSky == 'Rain'
                              ? Icons.cloud
                              : Icons.sunny,
                        );
                      }),
                ),
                const SizedBox(
                  height: 8,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    'Additional Information',
                    style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                // weather additional information
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    AdditionalIInfoItem(
                      icon: Icons.water_drop_rounded,
                      label: 'Humidity',
                      value: currentWeatherHumidity.toString(),
                    ),
                    SizedBox(width: 10),
                    AdditionalIInfoItem(
                      icon: Icons.air,
                      label: 'Wind speed',
                      value: currentWeatherWindSpeed.toString(),
                    ),
                    SizedBox(width: 10),
                    AdditionalIInfoItem(
                      icon: Icons.beach_access,
                      label: 'Pressure',
                      value: currentWeatherPressure.toString(),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
