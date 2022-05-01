// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, prefer_const_constructors_in_immutables, use_key_in_widget_constructors, non_constant_identifier_names, avoid_types_as_parameter_names

import 'package:bytebank/database/DAO/transfer_dao.dart';
import 'package:bytebank/screens/transfer_form.dart';
import 'package:flutter/material.dart';

import '../models/transfer.dart';

class Transfers extends StatefulWidget {
  final TransferDAO _dao = TransferDAO();

  Transfers({Key? key}) : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  State<Transfers> createState() {
    // _dao.findAll().then(((value) => debugPrint(value.toString())));
    return _TransfersState();
  }
}

class _TransfersState extends State<Transfers> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transfers'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: FutureBuilder<List<Transfer>>(
        initialData: [],
        future: widget._dao.findAll(),
        builder:
            (BuildContext context, AsyncSnapshot<List<Transfer>> snapshot) {
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
              final List<Transfer>? data = snapshot.data;
              return ListView.builder(
                itemCount: data!.length,
                itemBuilder: (BuildContext, index) {
                  final result = data[index];
                  return TransferCard(result);
                },
              );
          }
          return Text('Unknown error');
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final pop = await Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => TransferForm()));
          if (pop == true) {
            setState(() {});
          }
        },
        child: Icon(Icons.add),
      ),
    );
    // )
  }
}

class TransferCard extends StatelessWidget {
  final Transfer transfer;
  const TransferCard(this.transfer);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
          child: ListTile(
        leading: Icon(Icons.monetization_on),
        title: Text(
          transfer.transferValue.toString(),
          style: TextStyle(fontSize: 24.0),
        ),
        subtitle: Text(transfer.numberAccount.toString(),
            style: TextStyle(fontSize: 16.0, color: Colors.black38)),
      )),
    );
  }
}
