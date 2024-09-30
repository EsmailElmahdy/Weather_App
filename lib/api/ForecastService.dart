import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import '../LocationHandler.dart';
import 'models/forecast/list_model_forecast.dart';

class ForecastService {
  final String apiKey = '903b8e4d1788c82221eadac06ca4d553';

  Future<ForecastModel?> fetchForecastData(String unit) async {
    try {
      // Get current position (latitude, longitude)
      Position? position = await LocationHandler.getCurrentPosition();

      if (position != null) {
        double latitude = position.latitude;
        double longitude = position.longitude;

        // Use the unit passed from the drawer (either 'metric' or 'imperial')
        String apiUrl =
            'https://api.openweathermap.org/data/2.5/forecast?lat=$latitude&lon=$longitude&units=$unit&appid=$apiKey';

        final response = await http.get(Uri.parse(apiUrl));

        if (response.statusCode == 200) {
          Map<String, dynamic> jsonData = json.decode(response.body);

          ForecastModel forecastData = ForecastModel.fromJson(jsonData);

          return forecastData;
        } else {
          print('Failed to load forecast data');
          return null;
        }
      } else {
        print('Failed to get location');
        return null;
      }
    } catch (e) {
      print('Error occurred while fetching forecast data: $e');
      return null;
    }
  }
}

