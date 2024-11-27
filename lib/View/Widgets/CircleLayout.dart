import 'package:flutter/material.dart';
import 'dart:math';
import '../../Controller/fetchContactsHandler.dart';
import '../../Model/Contacts.dart';
import '../Widgets/StatisticsSection.dart';
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
      body: Stack(
        children: [
          GestureDetector(
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

          // The statistics section which includes the contacts group button
          StatisticsSection(contacts: widget.contacts),
        ],
      ),
    );
  }

  List<Widget> buildCircleLayout() {
    List<Widget> nodes = [];
    nodes.add(Positioned(
      left: centerX + _offset.dx - 20,
      top: centerY + _offset.dy - 20,
      child: _createNode('You'),
    ));
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
    final filteredContacts = _controller.getContactsFilteredByAlphabet(alphabet);
    if (filteredContacts!.isNotEmpty) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: Colors.black87,
          title: Text('Contacts with letter $alphabet', style: const TextStyle(color: Colors.white, fontSize: 20)),
          content: Container(
            width: double.maxFinite,
            child: ListView.builder(
              itemCount: filteredContacts.length,
              itemBuilder: (context, index) {
                final contact = filteredContacts[index];
                String phoneNumber = contact.phoneNumber.isNotEmpty
                    ? contact.phoneNumber
                    : 'No phone number';
                return Card(
                  color: Colors.grey[850],
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: ListTile(
                    leading: const Icon(Icons.account_circle, color: Colors.white),
                    title: Text(
                      contact.displayName,
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      phoneNumber,
                      style: const TextStyle(color: Colors.white70),
                    ),
                  ),
                );
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Close', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      );
    }
  }
}
