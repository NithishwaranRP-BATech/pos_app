import 'package:flutter/material.dart';
import 'package:pos_app/views/product_list.dart';

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
        title: const Text(
          'Customers',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: true,
        iconTheme: const IconThemeData(color: Colors.black),
        actions: [
          IconButton(
            icon: Image.asset(
              'assets/png/add_person.png', // Make sure the image path is correct
              width: 24, // You can adjust the width and height
              height: 24,
            ),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    title: const Text(
                      'Enter Customer Details',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Enter Name',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(height: 5),
                        TextField(
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 8.0, // Reduces height
                              horizontal: 10.0,
                            ),
                          ),
                        ),
                        const SizedBox(height: 15),
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Enter NIF Number',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(height: 5),
                        TextField(
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 8.0,
                              horizontal: 10.0,
                            ),
                          ),
                        ),
                        const SizedBox(height: 15),
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Enter Mobile Number',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(height: 5),
                        TextField(
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 8.0,
                              horizontal: 10.0,
                            ),
                          ),
                        ),
                        const SizedBox(height: 15),
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Enter Location',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(height: 5),
                        TextField(
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 8.0,
                              horizontal: 10.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                    actions: [
                      Center(
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width *
                              0.8, // 80% of screen width
                          child: ElevatedButton(
                            onPressed: () {
                              // Add your form submission logic here
                              Navigator.pop(context); // Close the dialog
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            child: const Text(
                              'Submit',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
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
