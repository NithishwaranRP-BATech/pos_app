import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pos_app/views/login_page.dart';
import 'package:pos_app/views/profile_details.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Initialize ScreenUtil
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF0062FF),
        elevation: 0,
        automaticallyImplyLeading: false,
        title: const Text('Profile', style: TextStyle(color: Colors.white)),
      ),
      body: Stack(
        children: [
          // Main content with two blue containers and spacer
          Column(
            children: [
              // First blue container with profile info
              Container(
                color: Color(0xFF0062FF),
                height: 180.h, // height scaled using .h
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    CircleAvatar(
                      radius: 60, // radius scaled using .h
                      backgroundColor: Colors.white,
                      child: Icon(Icons.person, size: 60, color: Colors.blue),
                    ),
                    SizedBox(height: 12),
                    Text(
                      'Tenzin Khan',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24, // font size scaled using .sp
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              // Second blue container below
              Container(
                color: Color(0xFF0062FF),
                height: 80.h, // height scaled using .h
                width: double.infinity,
              ),
            ],
          ),

          // Profile Options container overlaid on the second blue container
          Positioned(
            top: 205.h, // Adjust position for the overlay effect using .h
            left: 16.w, // width scaled using .w
            right: 16.w, // width scaled using .w
            child: Container(
              padding: EdgeInsets.symmetric(
                  vertical: 10.h), // vertical padding scaled using .h
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 5,
                    spreadRadius: 1,
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildProfileOption(Icons.person, 'Profile', () {
                    // Navigate to Profile Details screen
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ProfileDetailsPage(),
                      ),
                    );
                  }),
                  _divider(),
                  _buildProfileOption(Icons.lock, 'Close Cash Box', () {
                    // Add functionality for Change Password
                    print('Change Password tapped');
                  }),
                  _divider(),
                  _buildProfileOption(Icons.logout, 'Log Out', () {
                    // Add functionality for Log Out
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginPage(),
                      ),
                    );
                    print('Log Out tapped');
                  }),
                ],
              ),
            ),
          ),

          // Version information at the bottom
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(
                  bottom: 20.h), // bottom padding scaled using .h
              child: const Text(
                'Version 0.01',
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14), // font size scaled using .sp
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Widget for each profile option
  Widget _buildProfileOption(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: Colors.blue),
      title: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
      ),
      trailing: const Icon(Icons.arrow_forward_ios, size: 18),
      onTap: onTap,
    );
  }

  // Divider between options
  Widget _divider() {
    return const Divider(
      height: 1,
      thickness: 1,
      color: Colors.grey,
    );
  }
}
