// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_field, avoid_types_as_parameter_names, non_constant_identifier_names, no_logic_in_create_state

import 'package:bytebank/screens/contact_form.dart';
import 'package:flutter/material.dart';

import '../database/DAO/contact_dao.dart';
import '../models/contact.dart';

class Contacts extends StatefulWidget {
  final ContactDAO _dao = ContactDAO();

  Contacts({Key? key}) : super(key: key);

  @override
  State<Contacts> createState() {
    _dao.findAll().then(((value) => debugPrint(value.toString())));
    return _ContactsState();
  }
}

class _ContactsState extends State<Contacts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Contacts'),
          backgroundColor: Theme.of(context).primaryColor,
        ),
        body: FutureBuilder<List<Contact>>(
          initialData: [],
          future: widget._dao.findAll(),
          builder:
              (BuildContext context, AsyncSnapshot<List<Contact>> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                break;

              case ConnectionState.waiting:
                return Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Loading'),
                    )
                  ],
                ));

              case ConnectionState.active:
                break;

              case ConnectionState.done:
                final List<Contact>? data = snapshot.data;
                return ListView.builder(
                    itemCount: data?.length,
                    itemBuilder: (BuildContext, index) {
                      final Contact result = data![index];
                      return _ContactCard(
                        contact: result,
                        onPress: widget._dao.delete(result.id.toString()),
                      );
                    });
            }

            return Text('Unknown error');
          },
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () async {
            final pop = await Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => ContactForm()));
            if (pop == true) {
              setState(() {});
            }
          },
        ));
  }
}

class _ContactCard extends StatelessWidget {
  final Contact contact;
  // ignore: prefer_typing_uninitialized_variables
  final Future<int> onPress;
  const _ContactCard({
    required this.contact,
    required this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        trailing:
            IconButton(onPressed: () => onPress, icon: Icon(Icons.delete)),
        title: Text(contact.name, style: TextStyle(fontSize: 24.0)),
        subtitle: Text(contact.numberAccount.toString(),
            style: TextStyle(fontSize: 16.0, color: Colors.black38)),
      ),
    );
  }
}
