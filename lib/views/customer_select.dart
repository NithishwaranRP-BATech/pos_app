import 'package:flutter/material.dart';
import 'package:pos_app/views/customer_page.dart';

class CustomerSelect extends StatelessWidget {
  const CustomerSelect({super.key});

  final List<String> customers = const [
    'UFPROMO1 SALES',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sales',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false, // Remove back icon
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Column(
        children: [
          // Removed the search bar
          Expanded(
            child: ListView.builder(
              itemCount: customers.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    ListTile(
                      leading: const CircleAvatar(
                        backgroundColor: Colors.blue,
                        child: Icon(Icons.person, color: Colors.white),
                      ),
                      title: Text(
                        customers[index],
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: const Text('LUANDA'),
                      trailing: const Icon(Icons.arrow_forward_ios),
                      onTap: () {
                        // Navigating to the CustomerPage when a list item is tapped
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                CustomerPage(), // Opening the same page (for demonstration)
                          ),
                        );
                      },
                    ),
                    const Divider(), // Divider between each customer
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}