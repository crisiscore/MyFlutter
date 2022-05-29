import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LocationData? _currentPosition;
 final Set<Marker> _markers = {};
  Location location = Location();

  @override
  void initState() {
    super.initState();
    _getCurrentPosition();
  }

  late GoogleMapController mapController;

  LatLng _initialCameraPosition = const LatLng(45.521563, -122.677433);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    location.onLocationChanged.listen((location) {
      _markers.clear();
      final marker = Marker(
        markerId: MarkerId(location.time.toString()),
        position: LatLng(location.latitude!, location.longitude!),
        infoWindow: const InfoWindow(
          title: 'Current Location',
        ),
      );
      _markers.add(marker);
      mapController.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: LatLng(location.latitude!, location.longitude!), zoom: 15),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        mapType: MapType.normal,
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
        markers: _markers,
        initialCameraPosition: CameraPosition(
          target: _initialCameraPosition,
          zoom: 15.0,
        ),
      ),
    );
  }

   _getCurrentPosition() async {
    bool serviceEnabled;
    PermissionStatus permissionGranted;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _currentPosition = await location.getLocation();
    _initialCameraPosition =
        LatLng(_currentPosition!.latitude!, _currentPosition!.longitude!);
    location.onLocationChanged.listen((LocationData currentLocation) {
      print("${currentLocation.longitude} : ${currentLocation.longitude}");
      setState(() {
        _currentPosition = currentLocation;
        _initialCameraPosition =
            LatLng(_currentPosition!.latitude!, _currentPosition!.longitude!);
      });
    });
  }
}
