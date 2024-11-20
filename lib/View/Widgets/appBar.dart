// components/app_bar_widget.dart
import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget  {
  @override
  final Size preferredSize;
  final String text;
  const AppBarWidget({super.key, required this.text}) : preferredSize = const Size.fromHeight(kToolbarHeight);


  @override
  Widget build(BuildContext context) {
    //final String text = '';
    return AppBar(
      title:  Text(
        text,
        style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        textAlign: TextAlign.center,

      ),
      backgroundColor: Colors.blueGrey,
      centerTitle: true,
      elevation: 0,
    );
  }
}
