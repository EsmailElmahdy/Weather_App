import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import '../LocationHandler.dart';
import 'models/normal/weather_model.dart';


class WeatherService {
  final String apiKey = '903b8e4d1788c82221eadac06ca4d553';

  Future<WeatherModel?> fetchWeatherData(String unit) async { // Add unit parameter
    try {
      Position? position = await LocationHandler.getCurrentPosition();

      if (position != null) {
        double latitude = position.latitude;
        double longitude = position.longitude;

        // Construct the API URL with the selected unit
        String apiUrl =
            'https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&units=$unit&appid=$apiKey';

        final response = await http.get(Uri.parse(apiUrl));

        if (response.statusCode == 200) {
          Map<String, dynamic> jsonData = json.decode(response.body);

          WeatherModel weatherData = WeatherModel.fromJson(jsonData);

          return weatherData;
        } else {
          print('Failed to load weather data');
          return null;
        }
      } else {
        print('Failed to get location');
        return null;
      }
    } catch (e) {
      print('Error occurred while fetching weather data: $e');
      return null;
    }
  }
}

