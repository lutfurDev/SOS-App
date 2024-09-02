import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isSosActive = false;
  bool isLoading = false;
  String latitude = '0';
  String longitude = '0';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Location services'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: GestureDetector(
                onTap: _toggleSos,
                child: CircleAvatar(
                  radius: 80,
                  backgroundColor: isSosActive ? Colors.green : Colors.red,
                  child: isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : Text(
                          isSosActive ? 'Deactivate' : 'SOS',
                          style: const TextStyle(
                              color: Colors.white, fontSize: 18),
                        ),
                ),
              ),
            ),
            const SizedBox(height: 32),
            Text("Latitude: $latitude  Longitude: $longitude"),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  void _toggleSos() async {
    setState(() {
      isLoading = true;
    });

    await getCurrentLocation();

    setState(() {
      isSosActive = !isSosActive;
      isLoading = false;
    });
  }

  Future<void> getCurrentLocation() async {
    try {
      // Check if location services are enabled
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        throw Exception('Location services are disabled.');
      }

      // Check if permission is granted
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        // Request permission
        permission = await Geolocator.requestPermission();
        if (permission != LocationPermission.whileInUse &&
            permission != LocationPermission.always) {
          throw Exception('Location permission is denied.');
        }
      }

      // Get the current position
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.bestForNavigation,
      );

      setState(() {
        latitude = position.latitude.toString();
        longitude = position.longitude.toString();
      });
    } catch (e) {
      print('Error: $e');
      // Handle the error accordingly
      setState(() {
        isLoading = false;
      });
    }
  }
}
