// controller/contact_controller.dart

import '../Model/Contacts.dart';
import '../Repository/ContactRepository.dart';

class ContactController {
  final ContactRepository _repository = ContactRepository();
  List<ContactModel>? contacts;

  Future<void> loadContacts() async {
    try {
      contacts = await _repository.fetchContacts();
    } catch (e) {
      throw Exception('Failed to load contacts: $e');
    }
  }
/*returns the contacts with the specified alphabet and may return none if you don't have a
  contact with that alphabet*/
  List<ContactModel>? getContactsFilteredByAlphabet(String alphabet) {
    if (contacts == null || contacts!.isEmpty) return [];
    //print("Contacts loaded: ${contacts!.length}");
    return contacts!
        .where((contact) => contact.displayName.toUpperCase().startsWith(alphabet.toUpperCase()))
        .toList();
  }
}
