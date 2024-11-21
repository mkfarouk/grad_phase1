import 'package:flutter/material.dart';
import 'dart:math';
import '../../Controller/fetchContactsHandler.dart';
import '../../Model/Contacts.dart';
import 'CirclePainter.dart';

class CircleLayout extends StatefulWidget {
  final List<ContactModel> contacts;

  const CircleLayout({Key? key, required this.contacts}) : super(key: key);

  @override
  _CircleLayoutState createState() => _CircleLayoutState();
}

class _CircleLayoutState extends State<CircleLayout> {

  final ContactController _controller = ContactController();
  Offset _offset = Offset(0, 0);
  double radius = 178.0;
  double centerX = 200;
  double centerY = 300;
  bool _permissionDenied = false;

  @override
  void initState() {
    super.initState();
    _loadContacts();
  }

  Future<void> _loadContacts() async {
    try {
      await _controller.loadContacts();
      setState(() {});
    } catch (e) {
      setState(() => _permissionDenied = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onPanUpdate: (details) {
          setState(() {
            _offset += details.delta;
          });
        },
        child: CustomPaint(
          size: Size.infinite,
          painter: CircleLayoutPainter(centerX + _offset.dx, centerY + _offset.dy),
          child: Stack(
            children: buildCircleLayout(),
          ),
        ),
      ),
    );
  }

  List<Widget> buildCircleLayout() {
    List<Widget> nodes = [];

    // Add the central "You" node
    nodes.add(Positioned(
      left: centerX + _offset.dx - 20,
      top: centerY + _offset.dy - 20,
      child: _createNode('You'),
    ));

    // Add alphabet nodes around the circle
    for (int i = 0; i < 26; i++) {
      String alphabet = String.fromCharCode(i + 65);
      double angle = (2 * pi / 26) * i;
      double x = centerX + radius * cos(angle) + _offset.dx - 20;
      double y = centerY + radius * sin(angle) + _offset.dy - 20;

      nodes.add(Positioned(
        left: x,
        top: y,
        child: GestureDetector(
          onTap: () => _onNodeTap(alphabet),
          child: _createNode(alphabet),
        ),
      ));
    }

    return nodes;
  }

  Widget _createNode(String text) {
    return Container(
      width: 30,
      height: 30,
      decoration: BoxDecoration(
        color: Colors.grey[800],
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 1),
      ),
      alignment: Alignment.center,
      child: Text(text, style: TextStyle(fontSize: 12, color: Colors.white)),
    );
  }

  void _onNodeTap(String alphabet) {
    // Use the controller to fetch filtered contacts based on the alphabet
    final filteredContacts = _controller.getContactsFilteredByAlphabet(alphabet);

    // Debug: Print the filtered contacts
    print('Filtered Contacts: ${filteredContacts?.map((c) => c.displayName).toList()}');

    // Check if there are filtered contacts
    if (filteredContacts!.isNotEmpty) {
      // Show the filtered contacts in a dialog
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: Colors.black87,  // Darken the dialog background
          title: Text('Contacts with letter $alphabet', style: TextStyle(color: Colors.white, fontSize: 20)),
          content: Container(
            width: double.maxFinite,
            child: ListView.builder(
              itemCount: filteredContacts.length,
              itemBuilder: (context, index) {
                final contact = filteredContacts[index];
                String phoneNumber = contact.phoneNumber.isNotEmpty
                    ? contact.phoneNumber // Get the phone number
                    : 'No phone number'; // Default message if no phone number

                return Card(
                  color: Colors.grey[850],
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: ListTile(
                    leading: Icon(Icons.account_circle, color: Colors.white),
                    title: Text(
                      contact.displayName,
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      phoneNumber,
                      style: TextStyle(color: Colors.white70),
                    ),
                  ),
                );
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Close', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      );
    } else {
      // Show a message if no contacts match the filter
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('No contacts found starting with $alphabet.', style: TextStyle(color: Colors.white))),
      );
    }
  }
}
