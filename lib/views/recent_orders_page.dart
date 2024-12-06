import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RecentOrdersPage extends StatefulWidget {
  const RecentOrdersPage({Key? key}) : super(key: key);

  @override
  _RecentOrdersPageState createState() => _RecentOrdersPageState();
}

class _RecentOrdersPageState extends State<RecentOrdersPage> {
  TextEditingController _startDateController = TextEditingController();
  TextEditingController _endDateController = TextEditingController();

  Future<void> _selectDate(
      BuildContext context, TextEditingController controller) async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (selectedDate != null) {
      setState(() {
        controller.text =
            '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recent Orders'),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.print,
              color: Colors.white,
            ),
            onPressed: () {},
          ),
        ],
        backgroundColor: Color(0xFF0062FF),
      ),
      body: Column(
        children: [
          // Blue container with date selectors
          Container(
            color: Color(0xFF0062FF),
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
            child: Column(
              children: [
                _buildDateInput('Start Date', _startDateController),
                SizedBox(height: 10.h),
                _buildDateInput('End Date', _endDateController),
              ],
            ),
          ),
          SizedBox(height: 16.h), // Space between blue container and list

          // Expanded list view for orders
          Expanded(
            child: ListView.builder(
              itemCount: 5, // Mock data count
              itemBuilder: (context, index) {
                return Card(
                  margin:
                      EdgeInsets.only(bottom: 10.h, left: 16.w, right: 16.w),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: ExpansionTile(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Name: NATACEL COMERCIO & FILHOS,LDA',
                          style: TextStyle(fontSize: 11),
                        ),
                      ],
                    ),
                    // Customizing the arrow to be at the center below the container
                    trailing: Icon(
                      Icons.arrow_drop_down,
                      size: 30, // Arrow size
                      color: Colors.blue, // Arrow color
                    ),
                    subtitle: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: const [
                            Icon(Icons.calendar_today, size: 16),
                            SizedBox(width: 5),
                            Text('27/08/2024'),
                          ],
                        ),
                        const Text('Valor: 345600.30'),
                      ],
                    ),
                    children: [
                      // Divider line above the expanded details
                      const Divider(
                        thickness: 1,
                        color: Colors.grey,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // TipoDoc and NumDoc in the same row
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text('TipoDoc: NDE'),
                                Text('NumDoc: 3051'),
                              ],
                            ),
                            // Print button and icon in the same row
                            ElevatedButton.icon(
                              onPressed: () {},
                              icon: const Icon(Icons.print, size: 18),
                              label: const Text('Print'),
                              style: ElevatedButton.styleFrom(
                                primary: Colors.transparent, // No background
                                shadowColor:
                                    Colors.transparent, // Remove shadow
                                padding: EdgeInsets.symmetric(
                                    horizontal: 8.w, vertical: 4.h),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                // side: BorderSide.none, // No border
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // Date input builder
  Widget _buildDateInput(String hintText, TextEditingController controller) {
    return TextField(
      controller: controller,
      readOnly: true, // Make it read-only to show the date picker
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        hintText: hintText,
        suffixIcon: const Icon(Icons.calendar_today, color: Colors.black54),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      ),
      onTap: () {
        _selectDate(context, controller); // Show the date picker on tap
      },
    );
  }
}
