import 'package:flutter/material.dart';
import '../../Controller/fetchContactsHandler.dart';
import '../../Model/Contacts.dart';
import 'GroupDialog.dart';

class StatisticsSection extends StatelessWidget {
  final List<ContactModel> contacts;

  const StatisticsSection({Key? key, required this.contacts}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 30, // Set a smaller left value to ensure it stays within bounds
      top: 500, // Adjusted position based on layout
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10), // Add padding to container
        child: Row(
          mainAxisSize: MainAxisSize.min, // Prevent Row from expanding beyond its contents
          children: [
            // Total Contacts Button
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 18.0),
              decoration: BoxDecoration(
                color: Colors.grey[850],
                borderRadius: BorderRadius.circular(12.0),
                border: Border.all(color: Colors.white, width: 1),
              ),
              child: Text(
                'Total Contacts: ${contacts.length}',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,  // Adjusted size
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(width: 20), // Space between the two buttons

            // Contacts Groups Button
            GestureDetector(
              onTap: () => _showGroupDialog(context),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 18.0),
                decoration: BoxDecoration(
                  color: Colors.grey[850],
                  borderRadius: BorderRadius.circular(12.0),
                  border: Border.all(color: Colors.white, width: 1),
                ),
                child: Text(
                  'Contacts Groups',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showGroupDialog(BuildContext context) {
    // Detect groups based on contact names or other logic
    List<String> detectedGroups = _detectGroups();

    // Show the GroupDialog with the detected groups
    showDialog(
      context: context,
      builder: (context) => GroupDialog(
        contacts: contacts,
        detectedGroups: detectedGroups,
      ),
    );
  }

  List<String> _detectGroups() {
    Map<String, List<ContactModel>> groups = {};

    for (var contact in contacts) {
      var words = contact.displayName.split(' ');

      for (var word in words) {
        word = word.toLowerCase(); // Normalize to lowercase

        if (word.length > 2) {
          if (groups.containsKey(word)) {
            groups[word]?.add(contact);
          } else {
            groups[word] = [contact];
          }
        }
      }
    }

    // Only add groups with more than 2 members
    List<String> detectedGroups = [];
    groups.forEach((key, value) {
      if (value.length > 2) {
        detectedGroups.add(key);
      }
    });

    return detectedGroups;
  }
}
