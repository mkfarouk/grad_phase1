// repository/contact_repository.dart
import 'package:flutter_contacts/flutter_contacts.dart';
import '../Model/Contacts.dart';

class ContactRepository {
  get contacts => contacts;

  Future<List<ContactModel>> fetchContacts() async {
    if (!await FlutterContacts.requestPermission(readonly: true)) {
      throw Exception('Permission denied');
    }

    final contacts = await FlutterContacts.getContacts(withProperties: true);
    return contacts.map((contact) {
      return ContactModel(
        displayName: contact.displayName,
        phoneNumber: contact.phones.isNotEmpty
            ? contact.phones.first.number
            : 'No phone number',
      );
    }).toList();
  }
}