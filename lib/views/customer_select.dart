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
                        Navigator.of(context).push(_createRoute());
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

  // Custom Route for CustomerPage
  Route _createRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => const CustomerPage(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0); // Starts from the bottom
        const end = Offset.zero; // Ends at the top
        const curve = Curves.easeInOut; // Customizable curve
        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);

        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
      transitionDuration: const Duration(milliseconds: 800), // Slower transition
    );
  }
}
