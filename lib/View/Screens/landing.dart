// views/screens/splash_screen.dart
import 'package:flutter/material.dart';
import '../Widgets/permissionDialog.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  @override
  void initState() {
    super.initState();
    // Set a delay of 2 seconds before showing the permission dialog
    Future.delayed(const Duration(seconds: 2), () {
      PermissionDialog.showPermissionDialog(context, _onDeny);
    });
  }

  void _onDeny() {
    // Show a SnackBar when the permission is denied
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('You denied access to contacts, please re-consider'),
        duration: Duration(seconds: 4),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.grey,
      body: Center(
        child: Text(
          'Welcome to Social Network App',
          style: TextStyle(
            fontStyle: FontStyle.italic,
            fontSize: 24,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
