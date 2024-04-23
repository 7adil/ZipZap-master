import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController? _mapController;
  LocationData? _currentLocation;
  Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

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
      _markers.add(
        Marker(
          markerId: MarkerId('current_location'),
          position: LatLng(_currentLocation!.latitude!, _currentLocation!.longitude!),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Map Screen'),
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: _currentLocation != null
              ? LatLng(_currentLocation!.latitude!, _currentLocation!.longitude!)
              : LatLng(0, 0),
          zoom: 15,
        ),
        markers: _markers,
        onMapCreated: (GoogleMapController controller) {
          _mapController = controller;
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _markers.isEmpty ? _getCurrentLocation() : _markers.clear();
          });
        },
        child: Icon(_markers.isEmpty ? Icons.add_location : Icons.clear),
      ),
    );
  }
}
