import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:google_maps_webservice/places.dart' as Places;
import 'Map.dart';

class Pickup extends StatefulWidget {
  @override
  _PickupState createState() => _PickupState();
}

class _PickupState extends State<Pickup> {
  String _address = '';
  LocationData? _currentLocation;
  late GoogleMapController _mapController;
  TextEditingController _nameController = TextEditingController();
  TextEditingController _mobileController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  final places = Places.GoogleMapsPlaces(apiKey: 'AIzaSyBcfwu-Rj73Gr9dvOvN_rCMmGDn-Mmp024');

  Future<void> _getCurrentLocation() async {
    Location location = Location();
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    LocationData _locData = await location.getLocation();
    setState(() {
      _currentLocation = _locData;
    });
  }

  Future<void> _searchPlaces(String query) async {
    Places.PlacesSearchResponse response = await places.searchByText(query);
    if (response.isOkay) {

    } else {
      // Handle error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange, // Set background color here
      appBar: AppBar(
        title: Text('Address and Location'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset(
                'assets/pickup.png',
                height: 150,
              ),
              SizedBox(height: 20),
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  hintText: 'Enter Name',
                  filled: true,
                  fillColor: Colors.white,
                ),
                onChanged: (value) {
                  _searchPlaces(value);
                },
              ),
              SizedBox(height: 20),
              TextField(
                controller: _mobileController,
                decoration: InputDecoration(
                  hintText: 'Enter Mobile Number',
                  filled: true,
                  fillColor: Colors.white,
                ),
                onChanged: (value) {
                  _searchPlaces(value);
                },
              ),
              SizedBox(height: 20),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  hintText: 'Enter Email',
                  filled: true,
                  fillColor: Colors.white,
                ),
                onChanged: (value) {
                  _searchPlaces(value);
                },
              ),
              SizedBox(height: 20),
              TextField(
                controller: _addressController,
                decoration: InputDecoration(
                  hintText: 'Enter address',
                  filled: true,
                  fillColor: Colors.white,
                ),
                onChanged: (value) {
                  setState(() {
                    _address = value;
                  });
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _getCurrentLocation,
                child: Text('Get Current Location'),
              ),
              SizedBox(height: 20),

              SizedBox(),
              SizedBox(height: 20),
              _address.isNotEmpty
                  ? Text(
                'Entered Address: $_address',
                style: TextStyle(color: Colors.white),
              )
                  : SizedBox(),
              SizedBox(height: 20),
              _currentLocation != null
                  ? Text(
                'Live Location:\nLatitude: ${_currentLocation!.latitude}\nLongitude: ${_currentLocation!.longitude}',
                style: TextStyle(color: Colors.white),
              )
                  : SizedBox(),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MapScreen()),
                  );
                },
                child: Text('Map'),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
