// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:bytebank/database/DAO/contact_dao.dart';
import 'package:bytebank/models/contact.dart';
import 'package:flutter/material.dart';

import '../components/input.dart';

class ContactForm extends StatefulWidget {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _numberAccountController =
      TextEditingController();
  final ContactDAO _dao = ContactDAO();
  ContactForm({Key? key}) : super(key: key);

  @override
  State<ContactForm> createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text('Create new contact'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Input(
              keyboard: TextInputType.text,
              controller: widget._fullNameController,
              hint: 'Full name',
              label: 'John Doe Stewart',
            ),
            Input(
              controller: widget._numberAccountController,
              hint: 'Account number',
              label: '1234',
              keyboard: TextInputType.number,
            ),
            SizedBox(
              width: double.maxFinite,
              child: Padding(
                padding: EdgeInsets.only(top: 16.0),
                child: ElevatedButton(
                  onPressed: () {
                    final String fullName = widget._fullNameController.text;
                    final int? numberAccount =
                        int.tryParse(widget._numberAccountController.text);

                    if (numberAccount != null) {
                      final newContact = Contact(fullName, numberAccount, 0);
                      widget._dao
                          .save(newContact)
                          .then((id) => Navigator.pop(context, true));
                    }
                  },
                  child: Text('Create'),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
