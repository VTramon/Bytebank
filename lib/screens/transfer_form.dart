// ignore_for_file: prefer_const_constructors

import 'package:bytebank/components/input.dart';
import 'package:bytebank/database/DAO/transfer_dao.dart';
import 'package:bytebank/models/transfer.dart';
import 'package:flutter/material.dart';

class TransferForm extends StatefulWidget {
  final TextEditingController _valueController = TextEditingController();
  final TextEditingController _numberAccountController =
      TextEditingController();
  final TransferDAO _dao = TransferDAO();

  TransferForm({Key? key}) : super(key: key);

  @override
  State<TransferForm> createState() => _TransferFormState();
}

class _TransferFormState extends State<TransferForm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Make a transfer'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Input(
                keyboard: TextInputType.number,
                controller: widget._valueController,
                label: 'Valor',
                hint: '120.0'),
            Input(
                keyboard: TextInputType.number,
                controller: widget._numberAccountController,
                label: 'Conta',
                hint: '546297'),
            SizedBox(
              width: double.maxFinite,
              child: Padding(
                padding: EdgeInsets.only(top: 16.0),
                child: ElevatedButton(
                  onPressed: () {
                    final double? value =
                        double.tryParse(widget._valueController.text);
                    final int? numberAccount =
                        int.tryParse(widget._numberAccountController.text);

                    if (numberAccount != null && value != null) {
                      final newTransfer = Transfer(numberAccount, value, 0);
                      widget._dao
                          .save(newTransfer)
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
