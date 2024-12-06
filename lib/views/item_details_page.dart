import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ItemDetailsPage extends StatefulWidget {
  const ItemDetailsPage({Key? key}) : super(key: key);

  @override
  _ItemDetailsPageState createState() => _ItemDetailsPageState();
}

class _ItemDetailsPageState extends State<ItemDetailsPage> {
  // Create controllers for 15 input fields
  final List<TextEditingController> _controllers =
      List.generate(15, (_) => TextEditingController());

  // List of field titles
  final List<String> _fieldTitles = [
    'Item',
    'Description',
    'IVA',
    'Formula',
    'Subformula',
    'Marca',
    'Modelo',
    'Base',
    'Compra',
    'Venda',
    'Entrada',
    'Saida'
  ];

  // Define RSP Titles and Moving Units Titles
  final List<String> _rspTitles = [
    'RSP 1:',
    'RSP 2:',
    'RSP 3:',
    'RSP 4:',
    'RSP 5:'
  ];
  final List<String> _movingUnitsTitles = [
    'Base:',
    'Compra:',
    'Venda:',
    'Entrada:',
    'Saida:'
  ];

  @override
  void dispose() {
    // Dispose of all controllers when the page is disposed
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Item Details',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color(0xFF0062FF),
        leading: IconButton(
          icon: const Icon(
            Icons.keyboard_arrow_left_rounded,
            color: Colors.white,
          ), // Back arrow icon
          onPressed: () {
            Navigator.pop(context); // Navigate back to the previous screen
          },
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // General Fields (Item, Description, IVA, etc.)
                ...List.generate(3, (index) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: 16.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(_fieldTitles[index],
                            style: TextStyle(
                                fontSize: 16.sp, fontWeight: FontWeight.bold)),
                        SizedBox(height: 8.h),
                        TextField(
                          controller: _controllers[index],
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }),

                // Sale Prices Section with RSP fields in GridView
                Padding(
                  padding: EdgeInsets.only(top: 16.h, bottom: 8.h),
                  child: Text(
                    'Sale Prices in AKZ currency',
                    style:
                        TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
                  ),
                ),
                GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16.w,
                    mainAxisSpacing: 5.h,
                    childAspectRatio: 1.2,
                  ),
                  itemCount: _rspTitles.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(bottom: 16.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(_rspTitles[index],
                              style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold)),
                          SizedBox(height: 8.h),
                          TextField(
                            controller: _controllers[
                                3 + index], // Adjust index to start from RSP 1
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            keyboardType: TextInputType.number,
                          ),
                        ],
                      ),
                    );
                  },
                ),

                // General Fields (Formula, Subformula, Marca, Modelo)
                ...List.generate(4, (index) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: 16.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(_fieldTitles[index + 3],
                            style: TextStyle(
                                fontSize: 16.sp, fontWeight: FontWeight.bold)),
                        SizedBox(height: 8.h),
                        TextField(
                          controller: _controllers[index + 3],
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }),

                // Moving Units Section with fields in GridView
                Padding(
                  padding: EdgeInsets.only(top: 16.h, bottom: 8.h),
                  child: Text(
                    'Moving Units',
                    style:
                        TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
                  ),
                ),
                GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16.w,
                    mainAxisSpacing: 5.h,
                    childAspectRatio: 1.2,
                  ),
                  itemCount: _movingUnitsTitles.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(bottom: 16.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(_movingUnitsTitles[index],
                              style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold)),
                          SizedBox(height: 8.h),
                          TextField(
                            controller: _controllers[
                                7 + index], // Adjust index to start from Base
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            keyboardType: TextInputType.number,
                          ),
                        ],
                      ),
                    );
                  },
                ),

                // Remaining Fields (Entrada, Saida)
                ...List.generate(2, (index) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: 16.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(_fieldTitles[index + 9],
                            style: TextStyle(
                                fontSize: 16.sp, fontWeight: FontWeight.bold)),
                        SizedBox(height: 8.h),
                        TextField(
                          controller: _controllers[index + 9],
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }),

                // Save Button at the bottom (Vertical Length)
                Padding(
                  padding: EdgeInsets.only(top: 32.h),
                  child: Center(
                    child: Container(
                      width: double.infinity, // Full width
                      height: 60.h, // Fixed height to make the button taller
                      child: TextButton(
                        onPressed: () {
                          // You can add logic to save or process the data
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Data Saved!')),
                          );
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.blue,
                          primary: Colors.white,
                          padding: EdgeInsets.symmetric(
                              vertical: 0), // No padding needed here
                        ),
                        child: Text(
                          'Save',
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
