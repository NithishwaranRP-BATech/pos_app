import 'package:flutter/material.dart';
import 'package:pos_app/views/bluetooth_screen.dart';

class CartScreen extends StatefulWidget {
  final List<CartItem> cartItems;

  const CartScreen({Key? key, required this.cartItems}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  bool _isDetailsVisible = false; // To track if details are visible
  double _containerHeight = 100.0; // Initial height of the container

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Product List"),
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        elevation: 0,
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: widget.cartItems.length,
                  itemBuilder: (context, index) {
                    CartItem item = widget.cartItems[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          children: [
                            Image.asset(
                              item.imageUrl,
                              width: 60,
                              height: 60,
                              fit: BoxFit.cover,
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.title,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                      'Unit Price: \$${item.unitPrice.toStringAsFixed(2)}'),
                                  const SizedBox(height: 8),
                                  Text('Quantity: ${item.quantity}'),
                                ],
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.remove_circle_outline),
                              onPressed: () {
                                setState(() {
                                  widget.cartItems.removeAt(index);
                                });
                              },
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
          // Background container that can slide up
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              height: _containerHeight, // Control the height of the container
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 6.0,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  InkWell(
                    onTap: _toggleDetailsVisibility,
                    child: Icon(
                      _isDetailsVisible
                          ? Icons.arrow_drop_down
                          : Icons.arrow_drop_up,
                      size: 30,
                      color: Color(0xFF0062FF),
                    ),
                  ),
                  if (_isDetailsVisible)
                    Column(
                      children: [
                        const SizedBox(height: 16),
                        _buildDetailRow("Cred Develucoes", "0.00"),
                        const SizedBox(height: 8),
                        _buildDetailRow("Total Descontos", "0.0"),
                        const SizedBox(height: 8),
                        _buildDetailRow("Total Iliquido", "798657.06"),
                        const SizedBox(height: 8),
                        _buildDetailRow("Total IEC/Contrib", "0.00"),
                        const SizedBox(height: 8),
                        _buildDetailRow("Total de IVA", "68657.00"),
                        const SizedBox(height: 8),
                        _buildDetailRow("Total", "8977788.00"),
                      ],
                    ),
                ],
              ),
            ),
          ),
          // Fixed "Go to Print" button at the bottom
          Positioned(
            bottom: 16, // Slightly above the animated container
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: InkWell(
                onTap: () {
                  // Navigate to the print screen
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => BluetoothScanWidget()),
                  );
                },
                child: Container(
                  height: 60.0,
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  decoration: BoxDecoration(
                    color: Color(0xFF0062FF),
                    borderRadius: BorderRadius.circular(30.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 10.0,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.print,
                        color: Colors.white,
                        size: 28,
                      ),
                      SizedBox(width: 10),
                      Text(
                        'Go to Print',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Toggle the visibility of the details section
  void _toggleDetailsVisibility() {
    setState(() {
      _isDetailsVisible = !_isDetailsVisible;
      // If details are being shown, increase container height
      _containerHeight = _isDetailsVisible ? 350.0 : 100.0;
    });
  }

  // Helper method to create rows for details
  Widget _buildDetailRow(String title, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        Text(
          value,
          style: const TextStyle(fontSize: 16),
        ),
      ],
    );
  }
}

// Model for cart items
class CartItem {
  final String title;
  final double unitPrice;
  final int quantity;
  final String imageUrl;

  CartItem({
    required this.title,
    required this.unitPrice,
    required this.quantity,
    required this.imageUrl,
  });
}
