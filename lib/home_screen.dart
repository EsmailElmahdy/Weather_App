import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Import shared_preferences
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
  String selectedUnit = 'metric'; // Default unit is 'metric'

  late List<Widget>  screens = [
    MainScreen(selectedUnit: selectedUnit),
    CloudsScreen(selectedUnit: selectedUnit),
    ForecastScreen(selectedUnit: selectedUnit),
  ];

  @override
  void initState() {
    super.initState();
    _loadSelectedUnit(); // Load the saved unit when the screen initializes
  }

  Future<void> _loadSelectedUnit() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      selectedUnit = prefs.getString('selectedUnit') ?? 'metric'; // Default to 'metric' if not found

    });
  }

  Future<void> _saveSelectedUnit(String unit) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('selectedUnit', unit); // Save the selected unit

    setState(() {
      selectedUnit = unit;
      screens[0] = MainScreen(selectedUnit: selectedUnit);
      screens[1] = CloudsScreen(selectedUnit: selectedUnit);
      screens[2] = ForecastScreen(selectedUnit: selectedUnit);
    });
  }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double screenHeight = size.height;
    double screenWidth = size.width;

    return Scaffold(
      backgroundColor: Colors.black,
      key: scaffoldKey,
      drawer: Drawer(
        width: screenWidth * 0.5,
        backgroundColor: Color(0xff405274).withAlpha(150),
        child: Padding(
          padding: EdgeInsets.only(top: screenWidth * 0.2),
          child: Container(
            child: Column(
              children: [
                RadioListTile(
                  groupValue: selectedUnit,
                  activeColor: Colors.white,
                  value: 'metric',
                  title: Text(
                    'Metric',
                    style: TextStyle(
                      fontFamily: 'SanProDisplay',
                      color: Colors.white,
                      fontSize: screenWidth * 0.05,
                    ),
                  ),
                  onChanged: (value) {
                    _saveSelectedUnit(value!);  // Save and reload screens with the new unit
                  },
                ),
                RadioListTile(
                  groupValue: selectedUnit,
                  activeColor: Colors.white,
                  value: 'imperial',
                  title: Text(
                    'Imperial',
                    style: TextStyle(
                      fontFamily: 'SanProDisplay',
                      color: Colors.white,
                      fontSize: screenWidth * 0.05,
                    ),
                  ),
                  onChanged: (value) {
                    _saveSelectedUnit(value!);  // Save and reload screens with the new unit
                  },
                ),

              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Color(0xff405274),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 5,
              offset: Offset(0, -3),
            ),
          ],
        ),
        child: BottomNavigationBar(
          backgroundColor: Colors.transparent,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.black,
          onTap: (value) {
            setState(() {
              selectedIndex = value;
              print(selectedIndex);
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
