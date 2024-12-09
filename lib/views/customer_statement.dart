import 'dart:math';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomerStatementPage extends StatefulWidget {
  const CustomerStatementPage({Key? key}) : super(key: key);

  @override
  State<CustomerStatementPage> createState() => _CustomerStatementPageState();
}

class _CustomerStatementPageState extends State<CustomerStatementPage> {
  String selectedCustomer = "Select Customer";
  String selectedDateRange = "Select Date Range";

  final List<String> customerList = [
    'Mani',
    'John',
    'Sarah',
    'Michael',
    'Jessica',
    'David',
    'Emma',
    'Daniel',
    'Sophia',
    'James'
  ];
  List<String> filteredCustomers = [];

  @override
  void initState() {
    super.initState();
    // Shuffle the customer list to make it random each time
    filteredCustomers = List.from(customerList)..shuffle(Random());
  }

  Future<void> _selectDateRange(BuildContext context) async {
    DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      initialDateRange: DateTimeRange(
        start: DateTime.now(),
        end: DateTime.now().add(const Duration(days: 7)),
      ),
    );

    if (picked != null) {
      String formattedStart = DateFormat('dd/MM/yyyy').format(picked.start);
      String formattedEnd = DateFormat('dd/MM/yyyy').format(picked.end);
      setState(() {
        selectedDateRange = "$formattedStart to $formattedEnd";
      });
    }
  }

  void _showCustomerSelectionPopup(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return DraggableScrollableSheet(
              initialChildSize: 0.5, // Show 50% of the screen height
              maxChildSize: 0.9, // Max height if user drags it up
              minChildSize: 0.5, // Minimum height
              expand: false,
              builder: (context, scrollController) {
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start, // Align text to the start
                    children: [
                      // "Select Customer" Text
                      const Text(
                        "Select Customer",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      const SizedBox(
                          height: 12), // Space between text and search box
                      // Search Bar
                      TextField(
                        onChanged: (value) {
                          setState(() {
                            filteredCustomers = customerList
                                .where((customer) => customer
                                    .toLowerCase()
                                    .contains(value.toLowerCase()))
                                .toList();
                          });
                        },
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.search,
                              size: 20), // Reduced icon size
                          isDense:
                              true, // Reduces the height of the input field
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 5,
                              horizontal: 8), // Controls the height
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),

                      const SizedBox(height: 16),
                      Expanded(
                        child: ListView.builder(
                          controller: scrollController,
                          itemCount: filteredCustomers.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(filteredCustomers[index]),
                              onTap: () {
                                setState(() {
                                  selectedCustomer = filteredCustomers[index];
                                });
                                Navigator.of(context).pop();
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Customer Statement',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF0062FF),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.keyboard_arrow_left_rounded,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        color: Color.fromARGB(255, 244, 244, 244),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Horizontal scrollable row for Customer Select and Date Range Picker
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  // Customer Select Dropdown
                  GestureDetector(
                    onTap: () => _showCustomerSelectionPopup(context),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.person, size: 18),
                          const SizedBox(width: 8),
                          Text(
                            selectedCustomer,
                            style: const TextStyle(fontSize: 14),
                            softWrap: false,
                            overflow: TextOverflow.visible,
                          ),
                          const Icon(Icons.arrow_drop_down, size: 18),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  // Date Range Picker
                  GestureDetector(
                    onTap: () => _selectDateRange(context),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.calendar_today, size: 18),
                          const SizedBox(width: 8),
                          Text(
                            selectedDateRange,
                            style: const TextStyle(fontSize: 14),
                            softWrap: false,
                            overflow: TextOverflow.visible,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // Statement List
            Expanded(
              child: ListView.builder(
                itemCount: 6,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        // border: Border.all(color: Colors.grey.shade200),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Cliente",
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              Text("Mani"),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Date",
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              Text("27/08/2024"),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Document",
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              Text("Opening basic"),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
