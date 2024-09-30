import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'api/ForecastService.dart';
import 'api/models/forecast/list_model_forecast.dart';
import 'package:intl/intl.dart'; // For date formatting

class ForecastScreen extends StatefulWidget {
  final String selectedUnit;

  const ForecastScreen({super.key, required this.selectedUnit});

  @override
  State<ForecastScreen> createState() => _ForecastScreenState();
}

class _ForecastScreenState extends State<ForecastScreen> {
  ForecastModel? forecastData;
  List<ForecastList> dailyForecasts = [];

  @override
  void initState() {
    super.initState();
    _getForecastData();
  }

  void _getForecastData() async {
    ForecastService forecastService = ForecastService();

    try {
      // Retrieve the saved unit from SharedPreferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? savedUnit = prefs.getString('selectedUnit') ?? 'metric'; // Default to 'metric' if no value is saved

      // Fetch forecast data using the saved unit
      ForecastModel? data = await forecastService.fetchForecastData(savedUnit);

      if (data != null) {
        // Filter the forecast data to get one entry per day
        Map<String, ForecastList> uniqueDays = {};

        for (var forecast in data.forecastList) {
          // Extract only the date (yyyy-MM-dd) from dt_txt
          String date = DateFormat('yyyy-MM-dd').format(DateTime.parse(forecast.date));

          // If the date is not yet in the map, add the forecast
          if (!uniqueDays.containsKey(date)) {
            uniqueDays[date] = forecast;
          }
        }

        // Convert map values to a list and limit it to 10 days
        dailyForecasts = uniqueDays.values.take(10).toList();
      }

      setState(() {
        forecastData = data;
      });
    } catch (e) {
      // Handle any errors that might occur during the fetch
      print("Error fetching forecast data: $e");
      // Optionally show a snackbar or dialog to inform the user
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error fetching forecast data: $e'),
        ),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double screenHeight = size.height;
    double screenWidth = size.width;

    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: screenWidth * 0.08),
        width: screenWidth,
        height: screenHeight,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bg.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: dailyForecasts.isNotEmpty ? ListView.builder(
          itemCount: dailyForecasts.length,
          itemBuilder: (context, index) {
            final dayForecast = dailyForecasts[index];

            // Parse the date into a readable format
            String formattedDate = DateFormat('EEEE, MMM d').format(DateTime.parse(dayForecast.date));

            return Card(
              color: Color(0xff405274).withOpacity(0.5),
              margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              child: ListTile(
                title: Center(
                  child: Text(
                    formattedDate,
                    style: TextStyle(
                      fontFamily: 'SanProDisplayBold',
                      color: Colors.white,
                      fontSize: screenWidth * 0.04,
                    ),
                  ),
                ),
                subtitle: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween, // Aligns Low and High on opposite sides
                  children: [
                    Text(
                      'Low: ${dayForecast.tempMin.toStringAsFixed(1)}°C', // Low temperature at the start
                      style: TextStyle(
                        fontFamily: 'SanProDisplayBold',
                        color: Colors.white70,
                        fontSize: screenWidth * 0.035,
                      ),
                    ),
                    Text(
                      'High: ${dayForecast.tempMax.toStringAsFixed(1)}°C', // High temperature at the end
                      style: TextStyle(
                        fontFamily: 'SanProDisplayBold',
                        color: Colors.white70,
                        fontSize: screenWidth * 0.035,
                      ),
                    ),
                  ],
                ),

              ),
            );
          },
        )
            : Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
