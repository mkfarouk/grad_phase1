import 'package:flutter/material.dart';

class PermissionDialog extends StatelessWidget {
  final VoidCallback onAccept;
  final VoidCallback onDeny;

  const PermissionDialog({Key? key, required this.onAccept, required this.onDeny}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Permission Request'),
      content: const Text('This app needs access to your contacts to function properly.'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            onDeny();
          },
          child: const Text('Deny'),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            onAccept();
          },
          child: const Text('Accept'),
        ),
      ],
    );
  }

  static void showPermissionDialog({
    required BuildContext context,
    required VoidCallback onAccept,
    required VoidCallback onDeny,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        return PermissionDialog(onAccept: onAccept, onDeny: onDeny);
      },
    );
  }
}
