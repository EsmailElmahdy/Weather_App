import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'api/models/normal/weather_model.dart';
import 'api/normal_weather_service.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  // Add variables for dynamic values
  String cityName = 'Montreal';
  String currentDegree = '19';
  String weatherStatus = 'Mostly Clear';
  String highDegree = '24';
  String lowDegree = '18';
  WeatherModel? weatherModel;


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
            )

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
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  Text(
                    '$currentDegree\u00b0', // Use the variable for degree
                    style: TextStyle(
                      fontFamily: 'SanProDisplay',
                      color: Colors.white,
                      fontSize: screenWidth * 0.16,
                    ),
                  ),
                  Text(
                    weatherStatus, // Use the weather status variable
                    style: TextStyle(
                        fontFamily: 'SanProDisplay',
                        color: Color(0xEBEBF599),
                        fontSize: screenWidth * 0.05,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  Text(
                    'H:$highDegree\u00b0 L:$lowDegree\u00b0', // Use the high and low degree variables
                    style: TextStyle(
                        fontFamily: 'SanProDisplay',
                        color: Colors.white,
                        fontSize: screenWidth * 0.05,
                        fontWeight: FontWeight.bold
                    ),
                  )
                ],
              ),
            ),
            // Positioned(
            //   bottom: screenHeight * 0.03,
            //   child: Container(
            //     width: screenWidth,
            //     height: screenHeight * 0.25,
            //     decoration: BoxDecoration(
            //         image: DecorationImage(
            //           image: AssetImage('assets/images/bgrectangle.png'),
            //           fit: BoxFit.fill,
            //         )
            //     ),
            //     child: Padding(
            //       padding: EdgeInsets.only(left: screenWidth * 0.04),
            //       child: SingleChildScrollView(
            //         scrollDirection: Axis.horizontal,
            //         child: Row(
            //           children: List.generate(6, (index) => Padding(
            //             padding: EdgeInsets.only(right: screenWidth * 0.04),
            //             child: Container(
            //               width: screenWidth * 0.14,
            //               height: screenHeight * 0.15,
            //               decoration: BoxDecoration(
            //                   borderRadius: BorderRadius.horizontal(
            //                     right: Radius.circular(screenWidth * 0.1),
            //                     left: Radius.circular(screenWidth * 0.1),
            //                   ),
            //                   color: Color(0xff5936B4)
            //               ),
            //               child: Column(
            //                 mainAxisAlignment: MainAxisAlignment.center,
            //                 children: [
            //                   Text(
            //                     '12 AM', // Dynamic Time
            //                     style: TextStyle(
            //                       fontFamily: 'SanProDisplayBold',
            //                       color: Colors.white,
            //                       fontSize: screenWidth * 0.035,
            //                     ),
            //                   ),
            //                   Padding(
            //                     padding: EdgeInsets.only(top: screenWidth * 0.01),
            //                     child: Image(
            //                       width: screenWidth * 0.11,
            //                       height: screenWidth * 0.11,
            //                       image: AssetImage('assets/images/cloud.png'),
            //                       fit: BoxFit.cover,
            //                     ),
            //                   ),
            //                   Padding(
            //                     padding: EdgeInsets.only(top: screenWidth * 0.01),
            //                     child: Text(
            //                       '$currentDegree\u00b0', // Use the degree variable for this as well
            //                       style: TextStyle(
            //                         fontFamily: 'SanProDisplayBold',
            //                         color: Colors.white,
            //                         fontSize: screenWidth * 0.035,
            //                       ),
            //                     ),
            //                   ),
            //                 ],
            //               ),
            //             ),
            //           )),
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  Future<void> fetchWeather() async {
    WeatherService weatherService = WeatherService();
    WeatherModel? model = await weatherService.fetchWeatherData();

    setState(() {
      weatherModel = model;
      cityName = weatherModel!.name.toString();
      currentDegree = weatherModel!.main!.temp.toString();
      weatherStatus = weatherModel!.weather![0].description.toString();
      highDegree = weatherModel!.main!.tempMax.toString();
      lowDegree = weatherModel!.main!.tempMin.toString();
    });

  }
}
