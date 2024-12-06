import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pos_app/views/item_details_page.dart';
import 'package:pos_app/views/report_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isToggled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // Remove back icon
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Hi Clarence',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const Text(
              'Check your overview details',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
        actions: [
          Row(
            children: [
              Switch(
                value: _isToggled,
                onChanged: (value) {
                  setState(() {
                    _isToggled = value;
                  });
                },
                activeTrackColor: const Color(0xFFD4FFEE), // Track color
                activeColor: const Color(0xFF435F08), // Thumb color
                inactiveThumbColor:
                    Colors.grey, // Inactive thumb color (disabled grey)
                inactiveTrackColor:
                    Colors.grey.shade400, // Inactive track color
              ),
              const SizedBox(width: 10), // Space between text and avatar
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        // Add this for scroll functionality
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            const Text(
              'Dashboard Overview',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: _OverviewCard(
                    title: 'Today',
                    value: '10289',
                    percentage: '+2.5%',
                    isIncrease: true,
                    icon: Icons.arrow_upward,
                    suffixText: 'Compared to \n(21340 last year)',
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: _OverviewCard(
                    title: 'Total Profit',
                    value: '20921',
                    percentage: '+0.5%',
                    isIncrease: true,
                    icon: Icons.arrow_upward,
                    suffixText: 'Compared to \n(19000 last year)',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: _OverviewCard(
                    title: 'Sales Invoice',
                    value: '149',
                    percentage: '-1.5%',
                    isIncrease: false,
                    icon: Icons.arrow_downward,
                    suffixText: 'Compared to \n(165 last year)',
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: _OverviewCard(
                    title: 'Sales',
                    value: '17390',
                    percentage: '+2.5%',
                    isIncrease: true,
                    icon: Icons.arrow_upward,
                    suffixText: 'Compared to \n(10500 last year)',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 1,
                    blurRadius: 6,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Sales Report',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      _ColorDot(
                        color: Colors.green,
                        label: 'Online Sales',
                      ),
                      const SizedBox(width: 16),
                      _ColorDot(
                        color: Colors.blue,
                        label: 'Offline Sales',
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 200.h, // Ensure a fixed height for the chart
                    child: _SalesReportChart(),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
      floatingActionButton: Stack(
        children: [
          // "Add" button
          Positioned(
            bottom: 80.h, // Positioned slightly above the report button
            right: 16.w,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30), // Adjust the radius here
              child: FloatingActionButton(
                onPressed: () {
                  // Navigate to the ItemDetailsPage when "Add" is pressed
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ItemDetailsPage()),
                  );
                },
                backgroundColor: Colors.blue,
                child: const Icon(Icons.add),
              ),
            ),
          ),
          // "Report" button
          Positioned(
            bottom: 16.h,
            right: 16.w,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30), // Adjust the radius here
              child: FloatingActionButton(
                onPressed: () {
                  // Navigate to the Report Page when the report icon is clicked
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ReportPage()),
                  );
                },
                backgroundColor: Colors.green,
                child: const Icon(Icons.report),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ColorDot extends StatelessWidget {
  final Color color;
  final String label;

  const _ColorDot({Key? key, required this.color, required this.label})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color,
          ),
        ),
        const SizedBox(width: 8),
        Text(label),
      ],
    );
  }
}

class _OverviewCard extends StatelessWidget {
  final String title;
  final String value;
  final String percentage;
  final bool isIncrease;
  final IconData icon;
  final String suffixText;

  const _OverviewCard({
    Key? key,
    required this.title,
    required this.value,
    required this.percentage,
    required this.isIncrease,
    required this.icon,
    required this.suffixText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    // Define the background color based on the title
    Color backgroundColor;
    if (title == 'Today' || title == 'Sales Invoice' || title == 'Sales') {
      backgroundColor = const Color(0xFFF2DDCC); // Light peach color
    } else if (title == 'Total Profit') {
      backgroundColor = const Color(0xFFB9E3CD); // Light green color
    } else {
      backgroundColor = Colors.white; // Default background color
    }

    // Icon colors based on the title
    Color iconColor; // Don't use 'const' here
    switch (title) {
      case 'Today':
        iconColor = const Color(0xFFB3A2D6); // Light purple color for Today
        break;
      case 'Total Profit':
        iconColor =
            const Color(0xFF99CCA1); // Light green color for Total Profit
        break;
      case 'Sales Invoice':
        iconColor =
            const Color(0xFF96A6E1); // Light blue color for Sales Invoice
        break;
      case 'Sales':
        iconColor = const Color(0xFFF0BD92); // Light orange color for Sales
        break;
      default:
        iconColor = Colors.grey; // Default color
    }

    // Adjust width and height
    double containerWidth = screenWidth > 800 ? 200 : 170; // Increased width
    double containerHeight = 120; // Decreased height

    return Container(
      width: containerWidth,
      height: containerHeight, // Fixed height
      padding: const EdgeInsets.all(16), // Adjusted padding
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Stack(
        children: [
          // Main content (Value, Title, Icon, Percentage)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  // Left side: Title
                  Text(title,
                      style: const TextStyle(fontWeight: FontWeight.bold)),

                  // Spacer to push percentage to the right
                  Expanded(child: Container()),

                  Align(
                    alignment: Alignment.centerRight,
                    child: Row(
                      children: [
                        // Icon next to Percentage
                        Icon(
                          icon,
                          color: isIncrease ? Colors.green : Colors.red,
                          size: 10.w,
                        ),
                        Text(
                          percentage,
                          style: TextStyle(
                            fontSize: 10,
                            color: isIncrease ? Colors.green : Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Text(
                value,
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Text(suffixText, style: const TextStyle(fontSize: 12)),
            ],
          ),

          // Positioned the arrow_forward_ios icon at center-right
          Positioned(
            right: -10.h, // Place it to the very right edge
            top: 25.h, // Center vertically within the container
            child: IconButton(
              icon: Icon(Icons.arrow_circle_right_rounded,
                  size: 25, color: iconColor),
              onPressed: () {
                // Handle click event here
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _SalesReportChart extends StatelessWidget {
  const _SalesReportChart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final data = _getSalesData();

    return SizedBox(
      height: 200.h,
      child: BarChart(
        BarChartData(
          barGroups: data.map((sales) {
            return BarChartGroupData(
              x: sales.day.hashCode,
              barRods: [
                BarChartRodData(
                  y: sales.salesUp.toDouble(),
                  colors: [Colors.green],
                  width: 5,
                ),
                BarChartRodData(
                  y: sales.salesDown.toDouble(),
                  colors: [Colors.blue],
                  width: 5,
                ),
              ],
              barsSpace: 8,
            );
          }).toList(),
          titlesData: FlTitlesData(
            topTitles: SideTitles(showTitles: false), // Hide top titles
            rightTitles: SideTitles(showTitles: false), // Hide right titles
            leftTitles: SideTitles(
              showTitles: true,
              getTitles: (value) => value.toInt().toString(),
              reservedSize: 40,
            ),
            bottomTitles: SideTitles(
              showTitles: true,
              getTitles: (value) {
                final sales = data.firstWhere(
                  (element) => element.day.hashCode == value.toInt(),
                  orElse: () => SalesData(day: '', salesUp: 0, salesDown: 0),
                );
                return sales.day;
              },
              margin: 10,
            ),
          ),
          borderData: FlBorderData(
            show: true,
            border: Border(
              left: BorderSide(color: Colors.black12), // Show left border
              bottom: BorderSide(color: Colors.black12), // Show bottom border
            ),
          ),
          gridData: FlGridData(
            show: true,
            drawVerticalLine: true, // Show only vertical grid lines
            horizontalInterval: 5, // Customize interval for vertical grid lines
            verticalInterval: 1, // Adjust for the number of bars
            getDrawingHorizontalLine: (value) => FlLine(
              color: Colors.black12,
              strokeWidth: 1,
            ),
            getDrawingVerticalLine: (value) => FlLine(
              color: Colors.black12,
              strokeWidth: 1,
            ),
          ),
        ),
      ),
    );
  }

  List<SalesData> _getSalesData() {
    return [
      SalesData(day: 'Jan', salesUp: 5, salesDown: 3),
      SalesData(day: 'Feb', salesUp: 10, salesDown: 4),
      SalesData(day: 'Mar', salesUp: 15, salesDown: 7),
      SalesData(day: 'Apr', salesUp: 20, salesDown: 8),
      SalesData(day: 'May', salesUp: 25, salesDown: 12),
      SalesData(day: 'Jun', salesUp: 30, salesDown: 15),
      // SalesData(day: 'Jul', salesUp: 23, salesDown: 18),
      // SalesData(day: 'Aug', salesUp: 12, salesDown: 20),
      // SalesData(day: 'Sep', salesUp: 21, salesDown: 19),
      // SalesData(day: 'Oct', salesUp: 10, salesDown: 13),
      // SalesData(day: 'Nov', salesUp: 15, salesDown: 12),
      // SalesData(day: 'Dec', salesUp: 33, salesDown: 17),
    ];
  }
}

class SalesData {
  final String day;
  final int salesUp;
  final int salesDown;

  SalesData(
      {required this.day, required this.salesUp, required this.salesDown});
}

class _BottomNavBarItem extends StatelessWidget {
  final IconData icon;
  final String title;

  const _BottomNavBarItem({Key? key, required this.icon, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon),
        Text(title),
      ],
    );
  }
}
