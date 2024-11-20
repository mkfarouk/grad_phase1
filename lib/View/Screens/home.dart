import 'package:flutter/material.dart';

import '../../Model/Contacts.dart';
import '../Widgets/CircleLayout.dart';


class HomeScreen extends StatelessWidget {
  final List<ContactModel>? contacts;

  const HomeScreen({Key? key, required this.contacts}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shofly'),
        centerTitle: true,
      ),
      body: CircleLayout(contacts: contacts ?? []), // Pass contacts to CircleLayout
    );
  }
}
