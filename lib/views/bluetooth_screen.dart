import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';

class BluetoothScanWidget extends StatefulWidget {
  const BluetoothScanWidget({Key? key}) : super(key: key);

  @override
  _BluetoothScanWidgetState createState() => _BluetoothScanWidgetState();
}

class _BluetoothScanWidgetState extends State<BluetoothScanWidget> {
  final flutterReactiveBle = FlutterReactiveBle();
  late StreamSubscription<DiscoveredDevice> _scanStream;
  List<DiscoveredDevice> devices = [];
  bool isScanning = false;
  bool isConnected = false;
  bool supportsBle = false;
  bool reconnect = false;
  late StreamSubscription<ConnectionStateUpdate> _connectionStream;
  final TextEditingController _emailController = TextEditingController();
  bool isEmailValid = true;

  @override
  void initState() {
    super.initState();

    // Check BLE support and status
    flutterReactiveBle.statusStream.listen((status) {
      if (status == BleStatus.ready) {
        setState(() {
          supportsBle = true;
        });
        print("BLE is ready!");
      } else if (status == BleStatus.unauthorized) {
        setState(() {
          supportsBle = false;
        });
        print("BLE is not supported or permissions are missing.");
      } else {
        print("BLE status: $status");
      }
    });
  }

  @override
  void dispose() {
    _scanStream.cancel();
    _connectionStream.cancel();
    super.dispose();
  }

  void startScan() {
    if (isScanning) return;
    setState(() {
      devices.clear();
      isScanning = true;
    });

    _scanStream = flutterReactiveBle.scanForDevices(withServices: []).listen(
      (device) {
        setState(() {
          if (!devices.any((d) => d.id == device.id)) {
            devices.add(device);
          }
        });
      },
      onError: (error) {
        setState(() => isScanning = false);
      },
    );
  }

  void stopScan() {
    _scanStream.cancel();
    setState(() => isScanning = false);
  }

  void connectToDevice(DiscoveredDevice device) {
    _connectionStream = flutterReactiveBle
        .connectToDevice(id: device.id)
        .listen((connectionState) {
      setState(() {
        isConnected =
            connectionState.connectionState == DeviceConnectionState.connected;
      });
    }, onError: (error) {
      setState(() => isConnected = false);
    });
  }

  void disconnectFromDevice() {
    _connectionStream.cancel();
    setState(() => isConnected = false);
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
        // actions: [
        //   IconButton(
        //     icon: const Icon(Icons.search, color: Colors.white),
        //     onPressed: () {
        //       // Add search functionality if needed
        //     },
        //   ),
        // ],
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
                      final device = devices[index];
                      return ListTile(
                        title: Text(
                          device.name.isEmpty ? "Unknown Device" : device.name,
                        ),
                        subtitle: Text(device.id),
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
