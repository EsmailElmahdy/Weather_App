import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'api/models/normal/weather_model.dart';
import 'api/normal_weather_service.dart';


class CloudsScreen extends StatefulWidget {
  const CloudsScreen({super.key});

  @override
  State<CloudsScreen> createState() => _CloudsScreenState();
}

class _CloudsScreenState extends State<CloudsScreen> {

  WeatherModel? weatherModel;
  String highDegree = '24';
  String lowDegree = '18';
  String windSpeed = '7.72';
  String windDegree = '360';
  String humidity = '1.18';
  String feelsLike = '31.67';
  String visibility = '10';
  int pressure = 2011;


  @override
  void initState() {
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
        child: Padding(
          padding: EdgeInsets.all(screenWidth * 0.05),
          child: GridView(
            scrollDirection: Axis.vertical,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            children: [
              Padding(
                padding: EdgeInsets.all(screenWidth * 0.015),
                child: Container(
                  width: screenWidth * 0.4,
                  height: screenWidth * 0.4,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/bgrectangle.png'),
                      fit: BoxFit.fitWidth,
                    ),
                    borderRadius: BorderRadius.circular(screenWidth * 0.1),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2), // Shadow color
                        spreadRadius: 2, // How much the shadow spreads
                        blurRadius: 8, // Softness of the shadow
                        offset: Offset(4, 4), // Horizontal and vertical offset of the shadow
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(screenWidth * 0.05),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Image(
                              image: AssetImage(
                                  'assets/images/max.png'
                              ),
                              color: Colors.grey,
                              width: screenWidth * 0.05,
                              height: screenWidth * 0.05,

                            ),
                            SizedBox(
                              width: screenWidth * 0.02,
                            ),
                            Text(
                              'Temperature',
                              style: TextStyle(
                                fontFamily: 'SanProDisplayBold',
                                color: Colors.grey,
                                fontSize: screenWidth * 0.035,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: screenWidth * 0.04,
                        ),
                        Text(
                          'Max Temp: $highDegree' + '\u00b0',
                          style: TextStyle(
                            fontFamily: 'SanProDisplayBold',
                            color: Colors.white,
                            fontSize: screenWidth * 0.035,
                          ),
                        ),
                        SizedBox(
                          height: screenWidth* 0.01,
                        ),
                        Text(
                          'Min Temp: $lowDegree' + '\u00b0',
                          style: TextStyle(
                            fontFamily: 'SanProDisplayBold',
                            color: Colors.white,
                            fontSize: screenWidth * 0.035,
                          ),
                        ),

                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(screenWidth * 0.015),
                child: Container(
                  width: screenWidth * 0.4,
                  height: screenWidth * 0.4,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/bgrectangle.png'),
                      fit: BoxFit.fitWidth,
                    ),
                    borderRadius: BorderRadius.circular(screenWidth * 0.1),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2), // Shadow color
                        spreadRadius: 2, // How much the shadow spreads
                        blurRadius: 8, // Softness of the shadow
                        offset: Offset(4, 4), // Horizontal and vertical offset of the shadow
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(screenWidth * 0.05),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Image(
                              image: AssetImage(
                                'assets/images/wind.png'
                              ),
                              color: Colors.grey,
                              width: screenWidth * 0.05,
                              height: screenWidth * 0.05,

                            ),
                            SizedBox(
                              width: screenWidth * 0.02,
                            ),
                            Text(
                              'Wind',
                              style: TextStyle(
                                fontFamily: 'SanProDisplayBold',
                                color: Colors.grey,
                                fontSize: screenWidth * 0.035,
                              ),
                              ),
                          ],
                        ),
                        SizedBox(
                          height: screenWidth * 0.04,
                        ),
                        Text(
                          'Speed: $windSpeed KM',
                          style: TextStyle(
                            fontFamily: 'SanProDisplayBold',
                            color: Colors.white,
                            fontSize: screenWidth * 0.035,
                          ),
                        ),
                        SizedBox(
                          height: screenWidth* 0.01,
                        ),
                        Text(
                          'Degree: $windDegree' + '\u00b0',
                          style: TextStyle(
                            fontFamily: 'SanProDisplayBold',
                            color: Colors.white,
                            fontSize: screenWidth * 0.035,
                          ),
                        ),

                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(screenWidth * 0.015),
                child: Container(
                  width: screenWidth * 0.4,
                  height: screenWidth * 0.4,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/bgrectangle.png'),
                      fit: BoxFit.fitWidth,
                    ),
                    borderRadius: BorderRadius.circular(screenWidth * 0.1),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2), // Shadow color
                        spreadRadius: 2, // How much the shadow spreads
                        blurRadius: 8, // Softness of the shadow
                        offset: Offset(4, 4), // Horizontal and vertical offset of the shadow
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(screenWidth * 0.05),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Image(
                              image: AssetImage(
                                  'assets/images/humidity.png'
                              ),
                              color: Colors.grey,
                              width: screenWidth * 0.05,
                              height: screenWidth * 0.05,

                            ),
                            SizedBox(
                              width: screenWidth * 0.02,
                            ),
                            Text(
                              'Humidity',
                              style: TextStyle(
                                fontFamily: 'SanProDisplayBold',
                                color: Colors.grey,
                                fontSize: screenWidth * 0.035,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: screenWidth * 0.04,
                        ),
                        Text(
                          '$humidity MM',
                          style: TextStyle(
                            fontFamily: 'SanProDisplayBold',
                            color: Colors.white,
                            fontSize: screenWidth * 0.05,
                          ),
                        ),
                        SizedBox(
                          height: screenWidth* 0.01,
                        ),
                        Text(
                          'At the last hour',
                          style: TextStyle(
                            fontFamily: 'SanProDisplayBold',
                            color: Colors.white,
                            fontSize: screenWidth * 0.035,
                          ),
                        ),

                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(screenWidth * 0.015),
                child: Container(
                  width: screenWidth * 0.4,
                  height: screenWidth * 0.4,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/bgrectangle.png'),
                      fit: BoxFit.fitWidth,
                    ),
                    borderRadius: BorderRadius.circular(screenWidth * 0.1),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2), // Shadow color
                        spreadRadius: 2, // How much the shadow spreads
                        blurRadius: 8, // Softness of the shadow
                        offset: Offset(4, 4), // Horizontal and vertical offset of the shadow
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(screenWidth * 0.05),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Image(
                              image: AssetImage(
                                  'assets/images/heatwave.png'
                              ),
                              color: Colors.grey,
                              width: screenWidth * 0.05,
                              height: screenWidth * 0.05,

                            ),
                            SizedBox(
                              width: screenWidth * 0.02,
                            ),
                            Text(
                              'Feels Like',
                              style: TextStyle(
                                fontFamily: 'SanProDisplayBold',
                                color: Colors.grey,
                                fontSize: screenWidth * 0.035,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: screenWidth * 0.07,
                        ),
                        Text(
                          'Temp: $feelsLike' + '\u00b0',
                          style: TextStyle(
                            fontFamily: 'SanProDisplayBold',
                            color: Colors.white,
                            fontSize: screenWidth * 0.05,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(screenWidth * 0.015),
                child: Container(
                  width: screenWidth * 0.4,
                  height: screenWidth * 0.4,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/bgrectangle.png'),
                      fit: BoxFit.fitWidth,
                    ),
                    borderRadius: BorderRadius.circular(screenWidth * 0.1),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2), // Shadow color
                        spreadRadius: 2, // How much the shadow spreads
                        blurRadius: 8, // Softness of the shadow
                        offset: Offset(4, 4), // Horizontal and vertical offset of the shadow
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(screenWidth * 0.05),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Image(
                              image: AssetImage(
                                  'assets/images/eye.png'
                              ),
                              color: Colors.grey,
                              width: screenWidth * 0.05,
                              height: screenWidth * 0.05,

                            ),
                            SizedBox(
                              width: screenWidth * 0.02,
                            ),
                            Text(
                              'Visibility',
                              style: TextStyle(
                                fontFamily: 'SanProDisplayBold',
                                color: Colors.grey,
                                fontSize: screenWidth * 0.035,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: screenWidth * 0.07,
                        ),
                        Text(
                          '$visibility KM',
                          style: TextStyle(
                            fontFamily: 'SanProDisplayBold',
                            color: Colors.white,
                            fontSize: screenWidth * 0.05,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(screenWidth * 0.015),
                child: Container(
                  width: screenWidth * 0.4,
                  height: screenWidth * 0.4,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/bgrectangle.png'),
                      fit: BoxFit.fitWidth,
                    ),
                    borderRadius: BorderRadius.circular(screenWidth * 0.1),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2), // Shadow color
                        spreadRadius: 2, // How much the shadow spreads
                        blurRadius: 8, // Softness of the shadow
                        offset: Offset(4, 4), // Horizontal and vertical offset of the shadow
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(screenWidth * 0.05),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Image(
                              image: AssetImage(
                                  'assets/images/pressure.png'
                              ),
                              color: Colors.grey,
                              width: screenWidth * 0.05,
                              height: screenWidth * 0.05,

                            ),
                            SizedBox(
                              width: screenWidth * 0.02,
                            ),
                            Text(
                              'Pressure',
                              style: TextStyle(
                                fontFamily: 'SanProDisplayBold',
                                color: Colors.grey,
                                fontSize: screenWidth * 0.035,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: screenWidth * 0.07,
                        ),
                        Text(
                          NumberFormat('#,##0').format(pressure), // Format the number with commas
                          style: TextStyle(
                            fontFamily: 'SanProDisplayBold',
                            color: Colors.white,
                            fontSize: screenWidth * 0.05,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> fetchWeather() async {
    WeatherService weatherService = WeatherService();
    WeatherModel? model = await weatherService.fetchWeatherData();

    setState(() {
      weatherModel = model;
      highDegree = weatherModel!.main!.tempMax.toString();
      lowDegree = weatherModel!.main!.tempMin.toString();
      windSpeed = weatherModel!.wind!.speed.toString();
      windDegree = weatherModel!.wind!.deg.toString();
      humidity = weatherModel!.main!.humidity.toString();
      feelsLike = weatherModel!.main!.feelsLike.toString();
      double x = weatherModel!.visibility! / 1000;
      visibility = x.toString();
      pressure = weatherModel!.main!.pressure!;
    });

  }
}
