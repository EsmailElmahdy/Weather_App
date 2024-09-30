import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled8/home_screen.dart';
import 'api/models/normal/weather_model.dart';
import 'api/normal_weather_service.dart';

class MainScreen extends StatefulWidget {
  final String selectedUnit;

  const MainScreen({super.key, required this.selectedUnit});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  // Variables for dynamic weather values
  String cityName = 'Montreal';
  String currentDegree = '19';
  String weatherStatus = 'Mostly Clear';
  String highDegree = '24';
  String lowDegree = '18';
  WeatherModel? weatherModel;

  @override
  void initState() {
    super.initState();
    fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double screenHeight = size.height;
    double screenWidth = size.width;

    return Scaffold(
      body: Container(
        width: screenWidth,
        height: screenHeight,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bg.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              bottom: screenWidth * 0.1,
              child: Image(
                image: AssetImage('assets/images/house.png'),
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              top: screenWidth * 0.2,
              child: Column(
                children: [
                  Text(
                    cityName,
                    style: TextStyle(
                      fontFamily: 'SanProDisplay',
                      color: Colors.white,
                      fontSize: screenWidth * 0.09,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '$currentDegree\u00b0', // Degree symbol
                    style: TextStyle(
                      fontFamily: 'SanProDisplay',
                      color: Colors.white,
                      fontSize: screenWidth * 0.16,
                    ),
                  ),
                  Text(
                    weatherStatus, // Weather status
                    style: TextStyle(
                      fontFamily: 'SanProDisplay',
                      color: Color(0xEBEBF599),
                      fontSize: screenWidth * 0.05,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'H:$highDegree\u00b0 L:$lowDegree\u00b0', // High and low degrees
                    style: TextStyle(
                      fontFamily: 'SanProDisplay',
                      color: Colors.white,
                      fontSize: screenWidth * 0.05,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> fetchWeather() async {
    WeatherService weatherService = WeatherService();

    try {
      // Retrieve the saved unit from SharedPreferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? savedUnit = prefs.getString('selectedUnit') ?? 'metric'; // Default to 'metric' if no value is saved

      // Fetch weather data using the saved unit
      WeatherModel? model = await weatherService.fetchWeatherData(savedUnit);

      setState(() {
        weatherModel = model;
        // Check if model is not null before accessing its properties
        if (weatherModel != null && weatherModel!.main != null) {
          cityName = weatherModel!.name ?? 'Unknown City';
          currentDegree = weatherModel!.main!.temp?.toString() ?? 'N/A';
          weatherStatus = weatherModel!.weather?.isNotEmpty == true
              ? weatherModel!.weather![0].description ?? 'No Description'
              : 'No Description';
          highDegree = weatherModel!.main!.tempMax?.toString() ?? 'N/A';
          lowDegree = weatherModel!.main!.tempMin?.toString() ?? 'N/A';
        }
      });
    } catch (e) {
      // Handle any errors that might occur during the fetch
      print("Error fetching weather data: $e");
      // Optionally show a snackbar or dialog to inform the user
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error fetching weather data: $e'),
        ),
      );
    }
  }

}
