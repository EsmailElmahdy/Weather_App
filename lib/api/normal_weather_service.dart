import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'package:untitled8/Country_List.dart';
import '../LocationHandler.dart';
import 'models/normal/weather_model.dart';

class WeatherService {
  final String apiKey = '903b8e4d1788c82221eadac06ca4d553';

  Future<WeatherModel?> fetchWeatherData(String unit) async {
    // Add unit parameter
    try {
      String apiUrl;
      if (helper.Country == null) {
        Position? position = await LocationHandler.getCurrentPosition();
        if (position != null) {
          double latitude = position.latitude;
          double longitude = position.longitude;

          // Construct the API URL with the selected unit
          apiUrl =
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
      } else {
        String Country = helper.Country!;
      
          // Construct the API URL with the selected unit
          apiUrl =
              'https://api.openweathermap.org/data/2.5/weather?lat=${helper.countriesCoordinates[Country]?[0]}&lon=${helper.countriesCoordinates[Country]?[1]}&units=$unit&appid=$apiKey';

          final response = await http.get(Uri.parse(apiUrl));

          if (response.statusCode == 200) {
            Map<String, dynamic> jsonData = json.decode(response.body);

            WeatherModel weatherData = WeatherModel.fromJson(jsonData);

            return weatherData;
          } else {
            print('Failed to load weather data');
            return null;
          }
        
      }
    } catch (e) {
      print('Error occurred while fetching weather data: $e');
      return null;
    }
  }
}
