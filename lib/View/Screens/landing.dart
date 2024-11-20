import 'package:flutter/material.dart';
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
    // Show the permission dialog after a delay of 2 seconds
    Future.delayed(const Duration(seconds: 2), _showPermissionDialog);
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

  void _handlePermissionDenied() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('You denied access to contacts, please reconsider.'),
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
