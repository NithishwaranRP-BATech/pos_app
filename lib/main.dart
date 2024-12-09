import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pos_app/views/custom_bottom_nav_bar.dart';
import 'package:pos_app/views/customer_page.dart';
import 'package:pos_app/views/customer_select.dart';
import 'package:pos_app/views/home_page.dart';
import 'package:pos_app/views/login_page.dart';
import 'package:pos_app/views/profile_page.dart';
import 'package:pos_app/views/profile_details.dart';
import 'package:pos_app/views/recent_orders_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize:
          const Size(375, 812), // Default design size for responsiveness
      builder: (context, child) {
        return MaterialApp(
          title: 'Digital Data',
          theme: ThemeData(primarySwatch: Colors.blue),
          home: const SplashScreen(), // Set SplashScreen as the first screen
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Wait for 5 seconds, then navigate to the LoginPage
    Timer(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity, // Full screen width
        height: double.infinity, // Full screen height
        child: Image.asset(
          'assets/png/pos_flash.png', // Path to your image
          fit: BoxFit.cover, // Makes the image cover the entire screen
        ),
      ),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  static const List<Widget> _pages = [
    HomePage(),
    CustomerSelect(),
    ProfilePage(),
  ];

  void _onTabSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[
          _selectedIndex], // Render only the selected page from the navbar
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _selectedIndex,
        onTabSelected: _onTabSelected,
      ),
    );
  }
}
