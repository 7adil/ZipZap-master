import 'package:flutter/material.dart';

class Vehicles extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Vehicles', textAlign: TextAlign.center),
        ),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.orange, Colors.deepOrange], // Use specific colors or shades
            ),
          ),
          child: ImageList(),
        ),
      ),
    );
  }
}

class ImageList extends StatefulWidget {
  @override
  _ImageListState createState() => _ImageListState();
}

class _ImageListState extends State<ImageList> {
  ImageData? selectedImageData;
  bool isCardVisible = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                itemCount: images.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      SizedBox(
                        height: 80, // Set the height of the button
                        width: double.infinity, // Set the width of the button to fill the available width
                        child: ElevatedButton(
                          onPressed: () {
                            // Handle button press event
                            setState(() {
                              selectedImageData = images[index];
                              isCardVisible = true; // Show the card
                            });
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Image(
                                    image: images[index].image,
                                    height: 65, // Set the height of the image
                                    width: 75, // Set the width of the image
                                  ),
                                  SizedBox(width: 8),
                                  Text(images[index].description), // Description
                                ],
                              ),
                              Icon(Icons.arrow_forward_ios), // Arrow icon
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
        AnimatedPositioned(
          duration: Duration(milliseconds: 500), // Set animation duration
          curve: Curves.easeInOut, // Set animation curve
          bottom: isCardVisible ? 20 : -300, // Move the card to the bottom center
          left: MediaQuery.of(context).size.width / 2 - 150, // Center horizontally
          child: AnimatedOpacity(
            opacity: isCardVisible ? 1.0 : 0.0,
            duration: Duration(milliseconds: 500), // Set opacity animation duration
            curve: Curves.easeInOut, // Set opacity animation curve
            child: Card(
              elevation: 4,
              margin: EdgeInsets.all(10),
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      selectedImageData?.description ?? '',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Capacity: ${selectedImageData?.capacity ?? ''}', // Display additional details
                      style: TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  final List<ImageData> images = [
    ImageData(
      image: AssetImage('assets/Delivery.png'), // Image for the button
      description: 'Two Wheeler',
      capacity: 'Order under 5 kg', // Additional detail
    ),
    ImageData(
      image: AssetImage('assets/mirza.png'), // Image for the button
      description: 'Car',
      capacity: 'Premium Service', // Additional detail
    ),
    ImageData(
      image: AssetImage('assets/van.png'), // Image for the button
      description: 'Van',
      capacity: 'Order above 5 kg ', // Additional detail
    ),
    ImageData(
      image: AssetImage('assets/truck.png'), // Image for the button
      description: 'Truck',
      capacity: 'Large order', // Additional detail
    ),
  ];
}

class ImageData {
  final ImageProvider image;
  final String description;
  final String capacity; // Additional detail

  ImageData({
    required this.image,
    required this.description,
    required this.capacity,
  });
}
