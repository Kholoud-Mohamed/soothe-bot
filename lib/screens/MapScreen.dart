// MapScreen.dart file
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/services.dart';
import 'package:mapfeature_project/Map_doctorsLocation/DoctorCard.dart';
import 'package:mapfeature_project/Map_doctorsLocation/DoctorLocationData.dart';
import 'package:mapfeature_project/Map_doctorsLocation/halperLocation.dart';

class mapScreen extends StatefulWidget {
  const mapScreen({Key? key}) : super(key: key);

  @override
  State<mapScreen> createState() => _mapScreenState();
}

class _mapScreenState extends State<mapScreen> {
  static Position? position;
  final Completer<GoogleMapController> _mapController = Completer();
  late List<Marker> markers = [];
  late List<Doctor> doctors = [];
  Set<Polyline> _polylines = {};

  bool _isMounted = false;

  Future<void> loadMarkersAndDoctors() async {
    if (!_isMounted) return;

    try {
      String csvData =
          await rootBundle.loadString('lib/assets/DoctorsLocations.csv');

      if (_isMounted) {
        setState(() {
          doctors = LocationData.getDoctorsFromCSV(csvData);
          doctors = _sortDoctorsByDistance(doctors);
          markers =
              LocationData.getMarkersFromDoctors(doctors, showCustomInfoWindow);
        });
      }
    } catch (e) {
      print('Error loading markers and doctors: $e');
    }
  }

  List<Doctor> _sortDoctorsByDistance(List<Doctor> doctors) {
    if (position == null) {
      // If user's location is not available, return the original list
      return doctors;
    }

    // Sort doctors based on distance from the user's location
    doctors.sort((a, b) {
      double distanceToA =
          _calculateDistance(position!, LatLng(a.latitude, a.longitude));
      double distanceToB =
          _calculateDistance(position!, LatLng(b.latitude, b.longitude));
      return distanceToA.compareTo(distanceToB);
    });

    return doctors;
  }

  double _calculateDistance(Position from, LatLng to) {
    return Geolocator.distanceBetween(
        from.latitude, from.longitude, to.latitude, to.longitude);
  }

  void showCustomInfoWindow(String doctorName, String government, double rate) {
    // ... existing code for showing info window
  }

  Future<void> getMyCurrentLocation() async {
    bool isServiceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!isServiceEnabled) {
      // Handle case where location services are not enabled
      return;
    }

    LocationPermission permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      // Handle case where the user denied location permission
      return;
    }

    // Use a local variable to store the position
    Position? currentLocation;

    try {
      currentLocation = await LocationHelper.getCurrentLocation();
    } catch (e) {
      print('Error getting current location: $e');
    }

    // Check if the widget is still mounted before updating the state
    if (!_isMounted) return;

    setState(() {
      position = currentLocation;
    });
  }

  void _showDoctorLocation(Doctor doctor) {
    // Update the map markers to only show the selected doctor's marker
    setState(() {
      markers = [
        Marker(
          markerId: MarkerId(doctor.doctorId),
          position: LatLng(doctor.latitude, doctor.longitude),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
          onTap: () {
            showCustomInfoWindow(
                doctor.doctorId, doctor.government, doctor.rate);
          },
        ),
      ];
    });

    // Draw the route from the current location to the doctor's location
    _drawRoute(
      LatLng(position!.latitude, position!.longitude),
      LatLng(doctor.latitude, doctor.longitude),
    );

    // Move the camera to the selected doctor's location
    _goToDoctorLocation(LatLng(doctor.latitude, doctor.longitude));
  }

  void _goToDoctorLocation(LatLng doctorLocation) async {
    final GoogleMapController controller = await _mapController.future;

    CameraPosition newPosition = CameraPosition(
      bearing: 0.0,
      target: doctorLocation,
      tilt: 0.0,
      zoom: 17,
    );

    controller.animateCamera(CameraUpdate.newCameraPosition(newPosition));
  }

  void _drawRoute(LatLng origin, LatLng destination) {
    Polyline polyline = Polyline(
      polylineId: const PolylineId("route"),
      points: [origin, destination],
      color: Colors.blue,
      width: 3,
    );

    setState(() {
      _polylines = {polyline};
    });
  }

  Future<void> _goToMyCurrentLocation() async {
    final GoogleMapController controller = await _mapController.future;

    // Check if position is not null before using it
    if (position != null) {
      CameraPosition newPosition = CameraPosition(
        bearing: 0.0,
        target: LatLng(position!.latitude, position!.longitude),
        tilt: 0.0,
        zoom: 17,
      );

      controller.animateCamera(CameraUpdate.newCameraPosition(newPosition));
    }
  }

  Widget buildMap() {
    return GoogleMap(
      mapType: MapType.normal,
      myLocationEnabled: true,
      zoomControlsEnabled: false,
      myLocationButtonEnabled: false,
      markers: Set<Marker>.of(markers ?? []),
      initialCameraPosition: _myCurrentLocationCameraPosition,
      onMapCreated: (GoogleMapController controller) {
        _mapController.complete(controller);
      },
      onTap: (position) {
        // Simulate a tap outside markers to hide the info window
        _simulateTapOutsideMarkers();
      },
    );
  }

  void _simulateTapOutsideMarkers() {
    _mapController.future.then((controller) {
      if (markers.isNotEmpty) {
        String validMarkerId = markers.first.markerId.value;
        controller.showMarkerInfoWindow(MarkerId(validMarkerId));
      }
    });
  }

  static CameraPosition _myCurrentLocationCameraPosition = const CameraPosition(
    bearing: 0.0,
    target: LatLng(0, 0), // Placeholder, will be updated in _initializeMap
    tilt: 0.0,
    zoom: 17,
  );

  @override
  void initState() {
    super.initState();
    _isMounted = true;
    _initializeMap();
  }

  @override
  void dispose() {
    _isMounted = false;
    super.dispose();
  }

  Future<void> _initializeMap() async {
    await getMyCurrentLocation();
    await loadMarkersAndDoctors();

    // Update the initial camera position with the user's location
    if (position != null) {
      setState(() {
        _myCurrentLocationCameraPosition = CameraPosition(
          bearing: 0.0,
          target: LatLng(position!.latitude, position!.longitude),
          tilt: 0.0,
          zoom: 17,
        );
      });
    }
  }

  void _showDoctorsList() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.8,
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Doctors List',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: doctors.length,
                  itemBuilder: (context, index) {
                    return DoctorCard(
                      doctor: doctors[index],
                      onTap: () {
                        _showDoctorLocation(doctors[index]);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          position != null
              ? Column(
                  children: [
                    Expanded(
                      flex: 3,
                      child: buildMap(),
                    ),
                  ],
                )
              : Center(
                  child: Container(
                    child: const CircularProgressIndicator(
                      color: Color(0xff7db2be),
                    ),
                  ),
                ),
          // Move the FloatingActionButton to the top right corner
          Positioned(
            bottom: 16.0,
            right: 16.0,
            child: FloatingActionButton(
              backgroundColor: const Color(0xff7db2be),
              onPressed: _showDoctorsList,
              shape: const CircleBorder(),
              child: const Icon(Icons.list, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
