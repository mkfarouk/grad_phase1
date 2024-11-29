import 'package:flutter/material.dart';
import '../../Model/Contacts.dart';

class SearchContactsOverlay extends StatefulWidget {
  final List<ContactModel> contacts;
  final VoidCallback onClose;

  const SearchContactsOverlay({
    Key? key,
    required this.contacts,
    required this.onClose,
  }) : super(key: key);

  @override
  _SearchContactsOverlayState createState() => _SearchContactsOverlayState();
}

class _SearchContactsOverlayState extends State<SearchContactsOverlay> {
  String _searchQuery = '';
  late List<ContactModel> _filteredContacts;
  String _searchBy = 'Name'; // Default search type is "Name"

  @override
  void initState() {
    super.initState();
    _filteredContacts = widget.contacts;
  }

  void _updateSearchQuery(String query) {
    setState(() {
      _searchQuery = query;
      if (_searchBy == 'Name') {
        _filteredContacts = widget.contacts
            .where((contact) =>
            contact.displayName.toLowerCase().contains(query.toLowerCase()))
            .toList();
      } else if (_searchBy == 'Profession') {
        // Leave the implementation for "Profession" empty
        _filteredContacts = []; // Placeholder, to be implemented later
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black.withOpacity(0.8),
      child: Column(
        children: [
          // Search Options and Bar
          Container(
            color: Colors.black,
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                // Dropdown Menu for Search Type
                DropdownButton<String>(
                  value: _searchBy,
                  dropdownColor: Colors.black87,
                  icon: const Icon(Icons.arrow_drop_down, color: Colors.white),
                  style: const TextStyle(color: Colors.white),
                  underline: Container(
                    height: 1,
                    color: Colors.white,
                  ),
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      setState(() {
                        _searchBy = newValue;
                        _updateSearchQuery(_searchQuery); // Re-filter on change
                      });
                    }
                  },
                  items: <String>['Name', 'Profession']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                const SizedBox(width: 8.0),

                // Search Bar
                Expanded(
                  child: TextField(
                    autofocus: true,
                    onChanged: _updateSearchQuery,
                    decoration: const InputDecoration(
                      hintText: 'Search...',
                      hintStyle: TextStyle(color: Colors.white70),
                      border: InputBorder.none,
                    ),
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close, color: Colors.white),
                  onPressed: widget.onClose,
                ),
              ],
            ),
          ),

          // Filtered Contact List
          Expanded(
            child: _filteredContacts.isEmpty
                ? const Center(
              child: Text(
                'No contacts found',
                style: TextStyle(color: Colors.white70),
              ),
            )
                : ListView.builder(
              itemCount: _filteredContacts.length,
              itemBuilder: (context, index) {
                final contact = _filteredContacts[index];
                return ListTile(
                  leading: const Icon(Icons.account_circle, color: Colors.white),
                  title: Text(
                    contact.displayName,
                    style: const TextStyle(color: Colors.white),
                  ),
                  subtitle: Text(
                    contact.phoneNumber,
                    style: const TextStyle(color: Colors.white70),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
