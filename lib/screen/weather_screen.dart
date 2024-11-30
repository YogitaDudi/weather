import 'package:flutter/material.dart';
import 'package:weather/model/weather_model.dart';
import 'package:weather/screen/weather_api.dart';


class WeatherScreen extends StatefulWidget {
  const WeatherScreen({Key? key}) : super(key: key);

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  WeatherModel? weatherData;
  bool inProgress = false;
  final TextEditingController _searchController = TextEditingController();
  String message = "Search for a location to get weather data";
  final String backgroundImageUrl =
      'https://images.pexels.com/photos/29262880/pexels-photo-29262880/free-photo-of-golden-gate-bridge-shrouded-in-san-francisco-fog.jpeg?auto=compress&cs=tinysrgb&w=600';
  void _getWeatherData(String location) async {
    setState(() {
      inProgress = true;
    });

    try {
      final data = await WeatherApi().getCurrentWeather(location);
      setState(() {
        weatherData = data;
        message = "";
      });
    } catch (e) {
      setState(() {
        message = "Failed to load weather data";
      });
    } finally {
      setState(() {
        inProgress = false;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.network(
              backgroundImageUrl,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                color: Colors.white,
                alignment: Alignment.center,
                child: Text(
                  "Unable to load background image",
                  style: TextStyle(color: Colors.white, fontSize: 28),
                ),
              ),
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ),


          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                SizedBox(height: 40),
                TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: "Enter location",
                    suffixIcon: IconButton(
                      icon: Icon(Icons.search, color: Colors.black),
                      onPressed: () {
                        _getWeatherData(_searchController.text);
                      },
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    hintStyle: TextStyle(color: Colors.black),
                  ),
                  onSubmitted: (value) => _getWeatherData(value),
                ),
                SizedBox(height: 30),

                // Loading indicator
                if (inProgress)
                  CircularProgressIndicator(),
                if (!inProgress && weatherData != null)
                  _buildWeatherInfo(),
                if (!inProgress && weatherData == null)
                  Text(
                    message,
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  Widget _buildWeatherInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "${weatherData?.location?.name}, ${weatherData?.location?.country}",
          style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Colors.black,fontStyle: FontStyle.italic),
        ),
        SizedBox(height: 10),
        Text(
          "${weatherData?.current?.tempC}°C, ${weatherData?.current?.condition?.text}",
          style: TextStyle(fontSize: 30, color: Colors.black),
        ),
        SizedBox(height: 20),
        Image.network(
          'http:${weatherData?.current?.condition?.icon}'.replaceAll("64x64", "128x128"),
          height: 100,
        ),
        SizedBox(height: 10),

        Text("Humidity: ${weatherData?.current?.humidity}%", style: TextStyle(fontSize: 20,color: Colors.black,fontStyle: FontStyle.italic)),
        SizedBox(height: 10,),
        Text("Wind Speed: ${weatherData?.current?.windKph} Km/h", style: TextStyle(fontSize: 20,color: Colors.black,fontStyle: FontStyle.italic)),
        SizedBox(height: 10,),
        Text("PrecipMn: ${weatherData?.current?. precipMm} Km/h ", style: TextStyle(fontSize: 20,color: Colors.black,fontStyle: FontStyle.italic)),
      ],
    );
  }
}

