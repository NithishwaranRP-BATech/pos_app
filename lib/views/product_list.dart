import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pos_app/views/bluetooth_screen.dart';
import 'package:pos_app/views/your_product_list.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  _ProductListScreenState createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  int? expandedCardIndex; // To track which card is expanded
  final List<String> tipoOptions = ['FA', 'FB', 'FC', 'FD', 'FE', 'FG'];
  String selectedTipo = 'FA'; // Default selected value for 'TIPO'
  bool _isSearchActive = false; // To manage the visibility of the search input
  TextEditingController _searchController =
      TextEditingController(); // Controller for the search input

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              // AppBar replacement container (blue)
              Container(
                color: Color(0xFF0062FF),
                height: 100.h,
              ),
              // Smaller container beneath header
              Container(
                color: Color(0xFF0062FF),
                height: 80.h,
              ),
              // Expanded ListView for products
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(
                      top: _isSearchActive
                          ? 0
                          : 30.h), // Ensure it's below the overlay

                  child: ListView.builder(
                    itemCount: 15,
                    itemBuilder: (context, index) {
                      return _ProductCard(
                        title: 'Tenzin $index',
                        unitPrice: 250,
                        cva: 250,
                        quantity: 2,
                        imageUrl: 'assets/png/apple.png',
                        isExpanded: expandedCardIndex == index,
                        onTap: () {
                          setState(() {
                            expandedCardIndex =
                                expandedCardIndex == index ? null : index;
                          });
                        },
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
          // Go to Cart button positioned at the bottom overlay
          _buildGoToCartButton(context),
          _buildOverlayContainer(),
          _buildAppBar(),
        ],
      ),
    );
  }

  Widget _buildAppBar() {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Container(
        color: Color(0xFF0062FF),
        padding: EdgeInsets.only(top: 40.h, left: 16.w, right: 16.w),
        height: 100.h,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: const Icon(Icons.keyboard_arrow_left_rounded,
                  color: Colors.white, size: 35),
              onPressed: () {
                Navigator.pop(context); // Go back to the previous screen
              },
            ),
            const Text('Product List',
                style: TextStyle(color: Colors.white, fontSize: 25)),
            IconButton(
              icon: Icon(
                _isSearchActive ? Icons.close : Icons.search,
                color: Colors.white,
                size: 35,
              ),
              onPressed: () {
                setState(() {
                  _isSearchActive =
                      !_isSearchActive; // Toggle search input visibility
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOverlayContainer() {
    return Positioned(
      top: 100.h,
      left: 10.w,
      right: 10.w,
      child: Container(
        padding: EdgeInsets.all(8.w),
        decoration: BoxDecoration(
          color: _isSearchActive
              ? Colors.transparent
              : const Color.fromARGB(255, 236, 247, 255),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            if (_isSearchActive) ...[
              // Show the search input when _isSearchActive is true
              TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  fillColor: Color.fromARGB(255, 255, 255, 255),
                  filled: true,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
                ),
              ),
              SizedBox(height: 10.h),
            ],
            if (!_isSearchActive) ...[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: _buildSingleContainerDropdown(
                        'TIPO:', selectedTipo, tipoOptions),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: _buildSingleContainerText('NUMBER:', '0096'),
                  ),
                ],
              ),
              SizedBox(height: 10.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: _buildSingleContainerText('SERIE:', '2022'),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: _buildSingleContainerText('DATE:', '08-12-2022'),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildSingleContainerDropdown(
      String label, String value, List<String> options) {
    return Container(
      width: 80.w, // Responsive width for the blue container
      height: 50.h, // Responsive height
      decoration: BoxDecoration(
        color: Colors.blue[900], // Blue background for the container
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Label inside the blue background
          Padding(
            padding:
                EdgeInsets.symmetric(horizontal: 8.w), // Responsive padding
            child: Text(
              label,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 12.sp, // Smaller font size for the label
              ),
            ),
          ),
          // Dropdown Button inside the white container with a fixed width
          Container(
            width: 80.w, // Fixed width for the white container (adjustable)
            height: 50.h, // Slightly smaller height
            decoration: BoxDecoration(
              color: Colors.white, // White background for the value
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: DropdownButton<String>(
                value: value,
                icon: const Icon(Icons.arrow_drop_down, color: Colors.black),
                iconSize: 24,
                elevation: 16,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 12.sp, // Smaller font size for the value text
                ),
                underline: SizedBox(),
                onChanged: (String? newValue) {
                  setState(() {
                    // Update the selected value when the dropdown option is selected
                    if (newValue != null) {
                      selectedTipo = newValue;
                    }
                  });
                },
                items: options.map<DropdownMenuItem<String>>((String option) {
                  return DropdownMenuItem<String>(
                    value: option,
                    child: Text(option),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSingleContainerText(String label, String value) {
    return Container(
      width: 80.w, // Responsive width for the blue container
      height: 50.h, // Responsive height
      decoration: BoxDecoration(
        color: Colors.blue[900], // Blue background for the container
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Label inside the blue background
          Padding(
            padding:
                EdgeInsets.symmetric(horizontal: 8.w), // Responsive padding
            child: Text(
              label,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 12.sp, // Smaller font size for the label
              ),
            ),
          ),
          // Static text value inside the white container
          Container(
            width: 78.w, // Fixed width for the white container
            height: 50.h, // Slightly smaller height
            decoration: BoxDecoration(
              color: Colors.white, // White background for the value
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Text(
                value,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 12.sp, // Smaller font size for the value text
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGoToCartButton(BuildContext context) {
    return Positioned(
      bottom: 20.0, // Adjust according to your layout needs
      left: 60.0,
      right: 60.0,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CartScreen(
                cartItems: [
                  CartItem(
                      title: "Tenzin 1",
                      unitPrice: 250.0,
                      quantity: 2,
                      imageUrl: 'assets/png/apple.png'),
                  CartItem(
                      title: "Tenzin 2",
                      unitPrice: 150.0,
                      quantity: 1,
                      imageUrl: 'assets/png/apple.png'),
                ],
              ),
            ),
          );
        },
        child: Container(
          height: 70.0, // Adjust as needed
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 10.0,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 40.0,
                height: 40.0,
                decoration: const BoxDecoration(
                  color: Color(0xFF386CF6),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.shopping_bag_rounded,
                  color: Colors.white,
                ),
              ),
              const Text(
                'Go to Cart',
                style:
                    TextStyle(fontSize: 18, color: Color.fromRGBO(0, 0, 0, 1)),
              ),
              const Icon(
                Icons.arrow_forward,
                color: Color(0xFF386CF6),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProductCard extends StatefulWidget {
  final String title;
  final int unitPrice;
  final int cva;
  final int quantity;
  final String imageUrl;
  final bool isExpanded;
  final VoidCallback onTap;

  const _ProductCard({
    Key? key,
    required this.title,
    required this.unitPrice,
    required this.cva,
    required this.quantity,
    required this.imageUrl,
    required this.isExpanded,
    required this.onTap,
  }) : super(key: key);

  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<_ProductCard> {
  late int _currentQuantity;

  @override
  void initState() {
    super.initState();
    _currentQuantity = widget.quantity;
  }

  void _incrementQuantity() {
    setState(() {
      _currentQuantity++;
    });
  }

  void _decrementQuantity() {
    setState(() {
      if (_currentQuantity > 0) _currentQuantity--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: widget.isExpanded
              ? BorderSide(
                  color: const Color.fromARGB(255, 112, 144, 231), width: 1)
              : BorderSide.none,
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0), // Add more padding if needed
          child: Column(
            children: [
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(widget.imageUrl,
                        width: 60, height: 60), // Increase image size
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.title,
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const Text('Check your overview'),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove, color: Colors.black),
                        onPressed: _decrementQuantity,
                      ),
                      Text('$_currentQuantity',
                          style: const TextStyle(fontSize: 18)),
                      IconButton(
                        icon: const Icon(Icons.add, color: Colors.black),
                        onPressed: _incrementQuantity,
                      ),
                    ],
                  ),
                ],
              ),
              if (widget.isExpanded) ...[
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildGreyTextField('Unit Price:', '\$${widget.unitPrice}'),
                    _buildGreyTextField('CVA:', '\$${widget.cva}'),
                  ],
                ),
                const SizedBox(height: 10),
                _buildPriceDetail(
                    'Total Value:', '\$${widget.unitPrice * _currentQuantity}'),
              ]
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGreyTextField(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        Container(
          width: 150.w, // You can adjust this width as needed
          height: 40.h, // Increase the height of the text field
          decoration: BoxDecoration(
            color: Color.fromARGB(131, 224, 224, 224),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Align(
            alignment: Alignment.centerLeft, // Aligns the text to the left
            child: Padding(
              padding: const EdgeInsets.only(
                  left:
                      8.0), // Adds padding to avoid touching the container edge
              child: Text(
                value,
                style: const TextStyle(fontSize: 16),
                textAlign:
                    TextAlign.left, // Ensures text is aligned to the left
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPriceDetail(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        Text(value),
      ],
    );
  }
}
