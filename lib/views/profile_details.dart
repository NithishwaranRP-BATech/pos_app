import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileDetailsPage extends StatelessWidget {
  const ProfileDetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20.h), // Spacing at the top

                    // User Details Form
                    const TextFieldLabel(text: 'User Name'),
                    const CustomTextField(),
                    SizedBox(height: 20.h),

                    const TextFieldLabel(text: 'Series'),
                    const CustomTextField(),
                    SizedBox(height: 20.h),

                    const TextFieldLabel(text: 'Ware House'),
                    const CustomTextField(),
                    SizedBox(height: 20.h),

                    const TextFieldLabel(text: 'Client'),
                    const CustomTextField(),
                    SizedBox(height: 20.h),

                    const TextFieldLabel(text: 'Language'),
                    const CustomTextField(),
                    SizedBox(height: 20.h),
                  ],
                ),
              ),
            ),
          ),

          // Save Details Button
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Action for saving details
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.w),
                  ),
                ),
                child: Text(
                  'Save Details',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
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
        fontSize: 16.sp,
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
        contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
              color: Color.fromARGB(255, 15, 15, 15), width: 1),
          borderRadius: BorderRadius.circular(8.w),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.blue, width: 2),
          borderRadius: BorderRadius.circular(8.w),
        ),
      ),
    );
  }
}
