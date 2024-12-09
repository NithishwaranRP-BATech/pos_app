import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class BluetoothScanWidget extends StatefulWidget {
  const BluetoothScanWidget({Key? key}) : super(key: key);

  @override
  _BluetoothScanWidgetState createState() => _BluetoothScanWidgetState();
}

class _BluetoothScanWidgetState extends State<BluetoothScanWidget> {
  final FlutterBluePlus flutterBlue = FlutterBluePlus();
  late StreamSubscription<List<ScanResult>> _scanStream;
  List<ScanResult> devices = [];
  bool isScanning = false;
  bool isConnected = false;
  bool supportsBle = false;
  bool reconnect = false;
  BluetoothDevice? connectedDevice;

  final TextEditingController _emailController = TextEditingController();
  bool isEmailValid = true;

  @override
  void initState() {
    super.initState();
    // Check BLE support and availability
    checkBLEAvailability();
  }

  // Check if BLE is available on the device
  Future<void> checkBLEAvailability() async {
    bool isAvailable = await FlutterBluePlus.isAvailable;
    setState(() {
      supportsBle = isAvailable;
    });
    print("BLE Available: $isAvailable");
  }

  @override
  void dispose() {
    // Cancel the scan subscription if active
    if (_scanStream != null) {
      _scanStream.cancel();
    }
    super.dispose();
  }

  void startScan() {
    if (isScanning) return;
    setState(() {
      devices.clear();
      isScanning = true;
    });

    // Start scanning and subscribe to scan results
    FlutterBluePlus.startScan(timeout: Duration(seconds: 4));

    _scanStream = FlutterBluePlus.scanResults.listen((results) {
      setState(() {
        // Update the devices list with the latest scan results
        devices = results;
      });
    });
  }

  void stopScan() {
    // Stop the scan and cancel the subscription
    FlutterBluePlus.stopScan();
    _scanStream.cancel();
    setState(() {
      isScanning = false;
    });
  }

  void connectToDevice(BluetoothDevice device) async {
    await device.connect();
    setState(() {
      isConnected = true;
      connectedDevice = device;
    });
    // Discover services once connected
    discoverServices(device);
  }

  void discoverServices(BluetoothDevice device) async {
    var services = await device.discoverServices();
    for (var service in services) {
      for (var characteristic in service.characteristics) {
        if (characteristic.properties.read) {
          // This is where you can interact with the characteristics
        }
      }
    }
  }

  void disconnectFromDevice() {
    connectedDevice?.disconnect();
    setState(() {
      isConnected = false;
      connectedDevice = null;
    });
  }

  // Function to validate the email
  bool validateEmail(String email) {
    final regex = RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$");
    return regex.hasMatch(email);
  }

  // Function to show the Send Email dialog
  void showSendEmailDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Send Email"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Recipient Email',
                  errorText: isEmailValid ? null : 'Please enter a valid email',
                ),
                keyboardType: TextInputType.emailAddress,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                final email = _emailController.text;
                if (validateEmail(email)) {
                  setState(() {
                    isEmailValid = true;
                  });
                  // Handle the send email action here
                  print('Email sent to: $email');
                  Navigator.pop(context);
                } else {
                  setState(() {
                    isEmailValid = false;
                  });
                }
              },
              child: const Text('Send'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'POS Digital Data',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF0062FF),
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
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: 150, // Set the width of the "Connect" button
                  child: ElevatedButton(
                    onPressed: startScan,
                    style: ElevatedButton.styleFrom(primary: Colors.green),
                    child: Text(
                      isScanning ? "Scanning..." : "Connect",
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(
                  width: 150, // Set the width of the "Disconnect" button
                  child: ElevatedButton(
                    onPressed: stopScan,
                    style: ElevatedButton.styleFrom(primary: Colors.red),
                    child: const Text("Disconnect",
                        style: TextStyle(color: Colors.white)),
                  ),
                ),
              ],
            ),
          ),
          // First point: BLE support toggle (left aligned text, right aligned toggle)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: const Text(
                    "This device supports BLE \n (low energy)",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Switch(
                  value: reconnect,
                  onChanged: (value) {
                    setState(() => reconnect = value);
                  },
                  activeTrackColor: const Color(0xFFD4FFEE), // Track color
                  activeColor: const Color(0xFF435F08), // Thumb color
                  inactiveThumbColor: Colors.grey, // Inactive thumb color
                  inactiveTrackColor:
                      Colors.grey.shade400, // Inactive track color
                ),
              ],
            ),
          ),
          // Second point: Reconnect toggle (left aligned text, right aligned toggle)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: const Text("Reconnect",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                Switch(
                  value: reconnect,
                  onChanged: (value) {
                    setState(() => reconnect = value);
                  },
                  activeTrackColor: const Color(0xFFD4FFEE), // Track color
                  activeColor: const Color(0xFF435F08), // Thumb color
                  inactiveThumbColor: Colors.grey, // Inactive thumb color
                  inactiveTrackColor:
                      Colors.grey.shade400, // Inactive track color
                ),
              ],
            ),
          ),
          Expanded(
            child: devices.isEmpty
                ? const Center(child: Text("No devices found"))
                : ListView.builder(
                    itemCount: devices.length,
                    itemBuilder: (context, index) {
                      final device = devices[index].device;
                      return ListTile(
                        title: Text(
                          device.name.isEmpty ? "Unknown Device" : device.name,
                        ),
                        subtitle: Text(device.id.id),
                        trailing: ElevatedButton(
                          onPressed: () => connectToDevice(device),
                          child: const Text("Connect"),
                        ),
                      );
                    },
                  ),
          ),
          if (isConnected)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: const Text(
                "Connected to device",
                style: TextStyle(color: Colors.green),
              ),
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: showSendEmailDialog,
        backgroundColor: const Color(0xFF0062FF),
        child: const Icon(Icons.send, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
