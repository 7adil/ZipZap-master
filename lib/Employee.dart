import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart'; // Import the geolocator package

class Order {
  final String id;
  final String name;
  bool isDelivered;

  Order({
    required this.id,
    required this.name,
    this.isDelivered = false,
  });
}

class empos extends StatefulWidget {
  @override
  os createState() => os();
}

class os extends State<empos> {
  DateTime? startTime;
  DateTime? endTime;
  bool isClockingOut = false;
  late Timer timer;
  int secondsPassed = 0;

  List<Order> orders = [
    Order(id: '1', name: 'Order 1'),
    Order(id: '2', name: 'Order 2'),
    Order(id: '3', name: 'Order 3'),
  ];

  @override
  void initState() {
    super.initState();
    // Request location permission when the widget initializes
    requestLocationPermission();
  }

  Future<void> requestLocationPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse && permission != LocationPermission.always) {
        // Handle permission denial
        print('Location permission denied.');
      }
    }
  }

  void startTimer() {
    startTime = DateTime.now();
    timer = Timer.periodic(Duration(seconds: 1), (Timer t) {
      setState(() {
        secondsPassed++;
      });
      // Capture GPS coordinates periodically
      saveGPSFile();
    });
  }

  void stopTimer() {
    endTime = DateTime.now();
    timer.cancel();
    setState(() {
      isClockingOut = false;
    });
  }

  String formatTime(int seconds) {
    int hours = seconds ~/ 3600;
    int minutes = (seconds % 3600) ~/ 60;
    int secondsLeft = seconds % 60;
    return '$hours:$minutes:$secondsLeft';
  }

  // Function to capture and save GPS coordinates
  void saveGPSFile() async {
    if (isClockingOut) {
      // Check if location service is enabled
      bool isLocationServiceEnabled = await Geolocator.isLocationServiceEnabled();
      if (isLocationServiceEnabled) {
        // Get the current location
        try {
          Position position = await Geolocator.getCurrentPosition();
          // Here, you can write the logic to save the GPS coordinates to a file
          // For example, you can use the dart:io library to write to a file
          // You may also consider using a database to store the GPS coordinates along with timestamps
          // For simplicity, let's just print the coordinates to the console
          print("Latitude: ${position.latitude}, Longitude: ${position.longitude}");
        } catch (e) {
          print("Error getting location: $e");
        }
      } else {
        print('Location service is disabled.');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Remove debug banner
      home: Scaffold(
        appBar: AppBar(
          title: Text(''),
          actions: [
            if (startTime != null)
              Padding(
                padding: EdgeInsets.only(right: 20.0),
                child: Text(formatTime(secondsPassed)),
              ),
          ],
        ),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.orange.shade300, Colors.orange.shade700],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Icon(isClockingOut ? Icons.timer_off : Icons.timer),
                    color: isClockingOut ? Colors.red : Colors.green,
                    onPressed: () {
                      if (isClockingOut) {
                        stopTimer(); // Stop the timer when clocking out
                        setState(() {
                          isClockingOut = false;
                        });
                      } else {
                        startTimer(); // Start the timer when clocking in
                        setState(() {
                          isClockingOut = true;
                        });
                      }
                    },
                  ),
                ],
              ),
              SizedBox(height: 20),
              Text(
                'Orders to Deliver',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: orders.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(orders[index].name),
                      trailing: IconButton(
                        icon: Icon(orders[index].isDelivered
                            ? Icons.check_circle
                            : Icons.circle),
                        onPressed: () {
                          setState(() {
                            orders[index].isDelivered = !orders[index].isDelivered;
                          });
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
