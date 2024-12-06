import 'package:flutter/material.dart';
import 'package:pos_app/views/product_list.dart';
import 'package:pos_app/views/profile_details.dart';

class CustomerPage extends StatelessWidget {
  const CustomerPage({super.key});

  final List<String> customers = const [
    'Tenzin',
    'Tenzin',
    'Tenzin',
    'Tenzin',
    'Tenzin',
    'Tenzin',
    'Tenzin',
    'Tenzin',
    'Tenzin',
    'Tenzin',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Customers',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: true, // Add back icon by setting this to true
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search your Customer',
                suffixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[200],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: customers.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    ListTile(
                      leading: const CircleAvatar(
                        backgroundColor: Colors.blue,
                        child: Icon(Icons.person,
                            color: Colors.white), // Placeholder avatar
                      ),
                      title: Text(
                        customers[index],
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: const Text('Check your overview'),
                      trailing: const Icon(Icons.arrow_forward_ios),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProductListScreen(),
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
