// widgets/permission_dialog.dart
import 'package:flutter/material.dart';
import '../Screens/landing.dart';
import '../Screens/home.dart';

class PermissionDialog extends StatelessWidget {
  final VoidCallback onAccept; // Callback function for when "Accept" is chosen

  const PermissionDialog({super.key, required this.onAccept});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Permission Request'),
      content: const Text('This app needs access to your contacts in order to work. Do you accept?'),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const LandingScreen()));
            // Show a snackbar if permission is denied

            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('You need to accept to proceed.'),
                duration: Duration(seconds: 4),
              ),

            );
          },
          child: const Text('Deny'),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog
            onAccept(); // Call
            // the onAccept callback to navigate
          },
          child: const Text('Accept'),
        ),
      ],
    );
  }
  static void showPermissionDialog(BuildContext context, void Function() onDeny) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return PermissionDialog(
          onAccept: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const HomeScreen()),
            );
          },
        );
      },
    );
  }
}
