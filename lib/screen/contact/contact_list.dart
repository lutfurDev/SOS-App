import 'package:flutter/material.dart';
import 'package:barcode_scan2/barcode_scan2.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({super.key});

  @override
  _ContactScreenState createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  final List<Contact> contacts = [
    Contact(name: 'John Doe', phone: '123-456-7890', token: 'abc123', image: 'https://via.placeholder.com/150'),
    Contact(name: 'Jane Smith', phone: '098-765-4321', token: 'xyz456', image: 'https://via.placeholder.com/150'),
  ];

  String _scanResult = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () => _showContactDialog(context),
            icon: const Icon(Icons.add),
          ),
        ],
        title: const Text('Contacts'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: contacts.length,
        itemBuilder: (context, index) {
          return _buildContactCard(contacts[index]);
        },
      ),
    );
  }

  Widget _buildContactCard(Contact contact) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16.0),
        leading: CircleAvatar(
          backgroundImage: NetworkImage(contact.image),
        ),
        title: Text(contact.name),
        subtitle: Text(contact.phone),
        trailing: const Icon(Icons.arrow_forward),
        onTap: () {
          // Action when tapping the contact
        },
      ),
    );
  }

  void _showContactDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Container(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildRow(
                  text: "Contact with Email",
                  icon: Icons.email_outlined,
                  onClick: () => print("Contact with Email selected"),
                ),
                _buildRow(
                  text: "Contact with Scanner",
                  icon: Icons.document_scanner_outlined,
                  onClick: () async {
                    var scanResult = await BarcodeScanner.scan();

                    if (scanResult.rawContent.isNotEmpty) {
                      setState(() {
                        _scanResult = _handleScanResult(scanResult.rawContent);
                        print("full_response :::$_scanResult");

                        print("_scanResult_formatNote_::: ${scanResult.formatNote.toString()}");
                        print("_scanResult_format_::: ${scanResult.format.toString()}");
                        print("_scanResult_type_::: ${scanResult.type.toString()}");


                      });

                      // Assuming the scanned result is a phone number or token,
                      // create a new contact and add it to the list
                      setState(() {
                        contacts.add(
                          Contact(
                            name: 'New Contact', // Set a default or derived name
                            phone: _scanResult.contains('TEL:')
                                ? _scanResult.replaceFirst('TEL;TYPE=CELL:: ', '')
                                : 'Unknown',
                            token:  'Unknown',
                            image: 'https://via.placeholder.com/150', // Default image
                          ),
                        );
                      });

                      // Close the dialog after adding the contact
                      Navigator.of(context).pop();
                    }
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  String _handleScanResult(String result) {
    if (RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$').hasMatch(result)) {
      return 'Email: $result';
    } else if (RegExp(r'^\+?[1-9]\d{1,14}$').hasMatch(result)) {

      return 'Phone Number: $result';
    } else {
      return 'Scanned data: $result';
    }
  }



  Widget _buildRow({required String text, IconData? icon, Function? onClick}) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: InkWell(
        onTap: () {
          if (onClick != null) {
            onClick();
          }
        },
        child: Row(
          children: [
            if (icon != null) Icon(icon, size: 18, color: Colors.grey),
            const SizedBox(width: 12),
            Text(text, style: const TextStyle(fontSize: 15, letterSpacing: 3)),
          ],
        ),
      ),
    );
  }
}

class Contact {
  final String name;
  final String phone;
  final String token;
  final String image;

  Contact({
    required this.name,
    required this.phone,
    required this.token,
    required this.image,
  });
}
