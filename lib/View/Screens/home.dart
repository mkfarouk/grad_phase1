import 'package:flutter/material.dart';
import '../../Model/Contacts.dart';
import '../Widgets/CircleLayout.dart';

class HomeScreen extends StatelessWidget {
  final List<ContactModel>? contacts;

  const HomeScreen({Key? key, required this.contacts}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100), // AppBar height
        child: AppBar(
          backgroundColor: Colors.black,
          elevation: 0, // Flat AppBar
          flexibleSpace: Align(
            alignment: Alignment.bottomCenter, // Place content at the very bottom
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20), // Adds spacing
              child: Text(
                'S H O F L Y',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28, // Larger font size for better impact
                  fontWeight: FontWeight.w600, // Slightly lighter than bold for elegance
                  letterSpacing: 1.5, // Add space between letters for a modern look
                  shadows: [
                    Shadow(
                      blurRadius: 4.0,
                      color: Colors.black.withOpacity(0.5),
                      offset: const Offset(0, 2),
                    ),
                  ], // Add subtle shadow for depth
                ),
              ),
            ),
          ),
        ),
      ),
      body: CircleLayout(contacts: contacts ?? []), // Pass contacts to CircleLayout
    );
  }
}
