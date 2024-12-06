import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTabSelected;

  const CustomBottomNavBar({
    Key? key,
    required this.currentIndex,
    required this.onTabSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h), // Add 10px gap at the bottom
      child: Container(
        height: 70.h, // Height of the navigation bar
        margin: const EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(50),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildNavItem(Icons.home, 'Home', 0),
            _buildNavItem(Icons.history, 'Recent', 1),
            _buildNavItem(Icons.people, 'Customer', 2),
            _buildNavItem(Icons.person, 'Profile', 3),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index) {
    bool isActive = currentIndex == index;
    return GestureDetector(
      onTap: () => onTabSelected(index),
      child: Stack(
        clipBehavior: Clip.none, // Allow the circle to overlap
        alignment: Alignment.center, // Center the icon inside the container
        children: [
          Column(
            mainAxisSize: MainAxisSize.min, // Align items vertically
            children: [
              Container(
                width: 40.w, // Icon container width
                height: 40.h, // Icon container height
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.transparent, // Transparent for inactive icons
                ),
                child: Icon(
                  icon,
                  color: isActive ? Colors.white : Colors.grey,
                  size: 24, // Icon size
                ),
              ),
              SizedBox(height: 4.h), // Space between icon and label
              Text(
                label,
                style: TextStyle(
                  fontSize: 12.sp, // Label font size
                  color: isActive
                      ? Color(0xFF0062FF)
                      : Colors.grey, // Active color
                ),
              ),
            ],
          ),
          if (isActive)
            Positioned(
              top: -20.h, // Move the circle above the navigation bar
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: 60.w, // Active circle width
                height: 60.h, // Active circle height
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFF0062FF), // Active state color
                  border: Border.all(
                    color: Colors.transparent,
                    width: 4, // Thin gap border
                  ),
                ),
                child: Icon(
                  icon,
                  color: Colors.white,
                  size: 30, // Icon size inside the circle
                ),
              ),
            ),
        ],
      ),
    );
  }
}
