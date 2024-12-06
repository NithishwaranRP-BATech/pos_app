import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileDetailsPage extends StatelessWidget {
  const ProfileDetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Initialize ScreenUtil
    // ScreenUtil.init(context, designSize: Size(360, 690), minTextAdapt: true);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Profile Details',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: 20.w), // Using .w for horizontal padding
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20.h), // .h for vertical spacing

            const TextFieldLabel(text: 'User Name'),
            const CustomTextField(),
            SizedBox(height: 20.h),

            const TextFieldLabel(text: 'Email Id'),
            const CustomTextField(),
            SizedBox(height: 20.h),

            const TextFieldLabel(text: 'Phone Number'),
            const CustomTextField(),
            const Spacer(),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Action for saving details
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: EdgeInsets.symmetric(
                      vertical: 16.h), // .h for vertical padding
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(30.w), // .w for border radius
                  ),
                ),
                child: Text(
                  'Save Details',
                  style: TextStyle(
                    fontSize: 16.sp, // .sp for font size
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }
}

class TextFieldLabel extends StatelessWidget {
  final String text;

  const TextFieldLabel({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 16.sp, // Using .sp for font size
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  const CustomTextField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(
            horizontal: 12.w, vertical: 12.h), // .w and .h for padding
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
              color: Color.fromARGB(255, 15, 15, 15), width: 1),
          borderRadius: BorderRadius.circular(8.w), // .w for border radius
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.blue, width: 2),
          borderRadius: BorderRadius.circular(8.w), // .w for border radius
        ),
      ),
    );
  }
}
