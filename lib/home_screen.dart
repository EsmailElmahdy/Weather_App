import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled8/forecast_screen.dart';
import 'api/models/normal/weather_model.dart';
import 'main_screen.dart';
import 'weather_details.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();

}

class _HomeScreenState extends State<HomeScreen> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  int selectedIndex = 0;

  List<Widget> screens = [
    MainScreen(),
    CloudsScreen(),
    ForecastScreen()
  ];
  @override
  void initState(){
    selectedIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double screenHeight = size.height;
    double screenWidth = size.width;

    return Scaffold(
      backgroundColor: Colors.black,
      key: scaffoldKey,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Color(0xff405274), // Set the background color here
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0), // Set the radius for top-left corner
            topRight: Radius.circular(20.0), // Set the radius for top-right corner
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2), // Optional: Add shadow for elevation effect
              spreadRadius: 1,
              blurRadius: 5,
              offset: Offset(0, -3), // Move shadow upwards
            ),
          ],
        ),
        child: BottomNavigationBar(
          backgroundColor: Colors.transparent, // Set to transparent to show container color
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.black,
          onTap: (value) {
            setState(() {
              selectedIndex = value;
              print(selectedIndex);
              screens[value];
            });
          },
          currentIndex: selectedIndex,
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                size: screenWidth * 0.09,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.cloud,
                size: screenWidth * 0.09,
              ),
              label: 'Cloud',
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                  'assets/images/forecast_1.png',
                  width: screenWidth * 0.09,
                  height: screenWidth * 0.09,
                ),
              label: 'Forecast',
            ),
          ],
        ),
      ),
      body: screens[selectedIndex],
    );
  }
}
