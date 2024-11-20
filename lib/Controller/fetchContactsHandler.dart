
import '../Model/Contacts.dart';
import '../Repository/ContactRepository.dart';

class ContactController {
  final ContactRepository _repository = ContactRepository();
  List<ContactModel>? contacts;

  Future<void> loadContacts() async {
    if (contacts != null) return; // Prevent reloading if already loaded

    try {
      contacts = await _repository.fetchContacts();
      print("Contacts loaded: ${contacts?.map((c) => c.displayName).toList()}");
    } catch (e) {
      print("Error loading contacts: $e");
      rethrow;
    }
  }

  List<ContactModel> getAllContacts() {
    return contacts ?? [];
  }

  List<ContactModel> getContactsFilteredByAlphabet(String alphabet) {
    if (contacts == null || contacts!.isEmpty) return [];

    return contacts!
        .where((contact) => contact.displayName.toUpperCase().startsWith(alphabet))
        .toList();
  }
}
