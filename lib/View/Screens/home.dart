import 'package:flutter/material.dart';
import '../../Model/Contacts.dart';
import '../Widgets/CircleLayout.dart';
import '../Widgets/SearchContactsOverlay.dart';

class HomeScreen extends StatefulWidget {
  final List<ContactModel>? contacts;

  const HomeScreen({Key? key, required this.contacts}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isSearchOpen = false; // Tracks whether the search widget is open

  void _toggleSearch() {
    setState(() {
      _isSearchOpen = !_isSearchOpen;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'S H O F L Y',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white),
            tooltip: 'Search Contacts',
            onPressed: _toggleSearch,
          ),
        ],
      ),
      body: Stack(
        children: [
          CircleLayout(contacts: widget.contacts ?? []),

          // Floating Search Widget
          if (_isSearchOpen)
            Positioned.fill(
              child: SearchContactsOverlay(
                contacts: widget.contacts ?? [],
                onClose: _toggleSearch,
              ),
            ),
        ],
      ),
    );
  }
}
