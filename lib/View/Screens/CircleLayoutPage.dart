// import 'package:flutter/material.dart';
// import 'dart:math';
// import '../../Controller/fetchContactsHandler.dart';
// import '../../Model/Contacts.dart';
// import '../Widgets/CirclePainter.dart';
//
//
// class CircleLayoutPage extends StatelessWidget {
//   final ContactController controller;
//
//   const CircleLayoutPage({Key? key, required this.controller}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     final double radius = 178.0;
//     final centerX = MediaQuery.of(context).size.width / 2;
//     final centerY = MediaQuery.of(context).size.height / 2;
//
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: CustomPaint(
//         size: Size.infinite,
//         painter: CircleLayoutPainter(centerX, centerY),
//         child: Stack(
//           children: _buildCircleLayout(centerX, centerY, radius, context),
//         ),
//       ),
//     );
//   }
//
//   List<Widget> _buildCircleLayout(
//       double centerX, double centerY, double radius, BuildContext context) {
//     List<Widget> nodes = [];
//
//     // Add central node ("Me")
//     nodes.add(Positioned(
//       left: centerX - 30,
//       top: centerY - 30,
//       child: _createNode("Me", () {
//         _showContacts(context, "All Contacts", controller.getAllContacts());
//       }),
//     ));
//
//     // Add alphabet nodes
//     const alphabets = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
//     final angleStep = 2 * pi / alphabets.length;
//
//     for (int i = 0; i < alphabets.length; i++) {
//       final angle = i * angleStep;
//       final x = centerX + radius * cos(angle) - 30;
//       final y = centerY + radius * sin(angle) - 30;
//
//       nodes.add(Positioned(
//         left: x,
//         top: y,
//         child: _createNode(alphabets[i], () {
//           _showContacts(
//             context,
//             "Contacts starting with ${alphabets[i]}",
//             controller.getContactsFilteredByAlphabet(alphabets[i]),
//           );
//         }),
//       ));
//     }
//
//     return nodes;
//   }
//
//   Widget _createNode(String text, VoidCallback onTap) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         width: 60,
//         height: 60,
//         decoration: BoxDecoration(
//           color: Colors.grey[800],
//           shape: BoxShape.circle,
//           border: Border.all(color: Colors.white, width: 2),
//         ),
//         alignment: Alignment.center,
//         child: Text(
//           text,
//           style: const TextStyle(fontSize: 16, color: Colors.white),
//         ),
//       ),
//     );
//   }
//
//   void _showContacts(
//       BuildContext context, String title, List<ContactModel> contacts) {
//     if (contacts.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('No contacts found for $title.')),
//       );
//     } else {
//       showDialog(
//         context: context,
//         builder: (context) => AlertDialog(
//           title: Text(title),
//           content: SizedBox(
//             width: double.maxFinite,
//             child: ListView.builder(
//               itemCount: contacts.length,
//               itemBuilder: (context, index) {
//                 final contact = contacts[index];
//                 return ListTile(
//                   title: Text(contact.displayName),
//                   subtitle: Text(
//                     contact.phoneNumber.isNotEmpty
//                         ? contact.phoneNumber
//                         : 'No phone number',
//                   ),
//                 );
//               },
//             ),
//           ),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.of(context).pop(),
//               child: const Text('Close'),
//             ),
//           ],
//         ),
//       );
//     }
//   }
// }
