import 'package:flutter/material.dart';
import 'dart:io'; // Import this to use exit(0)
import '../../Controller/fetchContactsHandler.dart';
import '../Widgets/permissionDialog.dart';
import 'home.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({Key? key}) : super(key: key);

  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  final ContactController _controller = ContactController();

  @override
  void initState() {
    super.initState();
    // Show the permission dialog after a delay of 3 seconds
    Future.delayed(const Duration(seconds: 3), _showPermissionDialog);
  }

  void _showPermissionDialog() {
    PermissionDialog.showPermissionDialog(
      context: context,
      onAccept: _fetchContactsAndNavigate, // Fetch contacts and navigate to HomeScreen
      onDeny: _handlePermissionDenied,     // Handle permission denial
    );
  }

  Future<void> _fetchContactsAndNavigate() async {
    try {
      await _controller.loadContacts();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomeScreen(contacts: _controller.contacts),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to load contacts. Please try again.'),
        ),
      );
    }
  }

  // Handle when the permission is denied
  void _handlePermissionDenied() {
    // Show the dialog asking the user to reconsider or close the app
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Permission Denied'),
          content: const Text(
            'This app requires permission to access contacts. Do you want to reconsider or close the app?',
          ),
          actions: [
            TextButton(
              onPressed: () {
                // Show the original permission dialog again if "Reconsider" is pressed
                Navigator.pop(context); // Close this dialog
                _showPermissionDialog(); // Show the permission dialog again
              },
              child: const Text('Reconsider'),
            ),
            TextButton(
              onPressed: () {
                // Close the app if "Close App" is pressed
                Navigator.pop(context); // Close this dialog
                exit(0); // Close the app
              },
              child: const Text('Close App'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/nodes_image2.png'), // Replace with your image path
            fit: BoxFit.cover,  // Adjust the image to cover the screen
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.people,
                size: 80,
                color: Colors.black,
              ),
              const SizedBox(height: 20),
              const Text(
                'Welcome to Social Network App',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 20),
              const CircularProgressIndicator(
                color: Colors.black,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
