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
      designSize: const Size(375, 812), // Default design size for responsiveness
      builder: (context, child) {
        return MaterialApp(
          title: 'Digital Data',
          theme: ThemeData(primarySwatch: Colors.blue),
          home: const LoginPage(), // Set LoginPage as the first screen
          debugShowCheckedModeBanner: false,
        );
      },
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

  // Only HomePage, CustomerPage, and ProfilePage are part of the navbar
  static const List<Widget> _pages = [
    HomePage(),
    RecentOrdersPage(),
    CustomerSelect(),
    ProfilePage(),
  ];

  // Function to handle bottom navigation bar selection
  void _onTabSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex], // Render only the selected page from the navbar
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _selectedIndex,
        onTabSelected: _onTabSelected,
      ),
    );
  }
}
