import 'package:flutter/material.dart';
import '../../Model/Contacts.dart';

class GroupDialog extends StatelessWidget {
  final List<String> detectedGroups; // List of detected group names
  final List<ContactModel> contacts;

  const GroupDialog({Key? key, required this.detectedGroups, required this.contacts}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.black87,
      title: const Text('Detected Groups', style: TextStyle(color: Colors.white, fontSize: 20)),
      content: Container(
        width: double.maxFinite,
        child: ListView.builder(
          itemCount: detectedGroups.length, // Use dynamic group length
          itemBuilder: (context, index) {
            String groupName = detectedGroups[index];

            return GestureDetector(
              onTap: () => _showGroupContacts(context, groupName),
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 8.0),
                padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0),
                decoration: BoxDecoration(
                  color: Colors.grey[850],
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Text(
                  groupName,
                  style: const TextStyle(color: Colors.white, fontSize: 18),
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
    );
  }

  // Function to show contacts for a selected group
  void _showGroupContacts(BuildContext context, String groupName) {
    List<ContactModel> groupContacts = contacts
        .where((contact) => contact.displayName.toLowerCase().contains(groupName.toLowerCase()))
        .toList();

    if (groupContacts.isNotEmpty) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: Colors.black87,
          title: Text('Contacts in $groupName Group', style: const TextStyle(color: Colors.white, fontSize: 20)),
          content: Container(
            width: double.maxFinite,
            child: ListView.builder(
              itemCount: groupContacts.length,
              itemBuilder: (context, index) {
                final contact = groupContacts[index];
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
