// widgets/home_screen.dart
import 'package:flutter/material.dart';
//import '../Widgets/circle_layout.dart'; // Import your existing CircleLayout widget
import '../Widgets/appBar.dart';
import '../Widgets/CircleLayout.dart';
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(text: 'Shofly'),
      body:  CircleLayout(), // Use your CircleLayout widget here

    );
  }
}
