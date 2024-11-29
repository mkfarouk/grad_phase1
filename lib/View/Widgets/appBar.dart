// components/app_bar_widget.dart
import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget  {
  @override
  final Size preferredSize;
  final String text;
  final VoidCallback onRefresh; // Callback function for the refresh button
  const AppBarWidget({super.key, required this.text, required this.onRefresh}) : preferredSize = const Size.fromHeight(kToolbarHeight);


  @override
  Widget build(BuildContext context) {
    //final String text = '';
    return AppBar(
      title:  Text(
        text,
        style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        textAlign: TextAlign.center,

      ),
      backgroundColor: const Color.fromARGB(255, 139, 96, 96),
      centerTitle: true,
      elevation: 0,
      actions: [
        IconButton(
          icon: const Icon(Icons.refresh),
          tooltip: 'Refresh Contacts',
          onPressed: onRefresh,
        ),
      ],
    );
  }
}
