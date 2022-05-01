import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import '../../models/contact.dart';
import '../app_database.dart';

class ContactDAO {
  static const String _tableName = 'contacts';
  static const String _id = 'id';
  static const String _name = 'name';
  static const String _numberAccount = 'numberAccount';

  static const String tableSQL =
      'CREATE TABLE IF NOT EXISTS $_tableName($_id INTEGER PRIMARY KEY, $_name TEXT, $_numberAccount INTEGER);';

  Future<int> save(Contact contacts) async {
    final Database db = await createDatabase();
    final Map<String, dynamic> contactMap = {};

    contactMap[_name] = contacts.name;
    contactMap[_numberAccount] = contacts.numberAccount;
    debugPrint(db.toString());
    // return db.insert(_tableName, contactMap);
    return db.insert(_tableName, contactMap,
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Contact>> findAll() async {
    final List<Map<String, Object?>> result =
        await createDatabase().then((value) {
      return value.query(_tableName);
    });
    final List<Contact> contactsList = List.empty(growable: true);

    for (Map<String, dynamic> map in result) {
      final Contact contact =
          Contact(map[_name], map[_numberAccount], map[_id]);
      contactsList.add(contact);
    }
    return contactsList;
  }

  Future<int> delete(String id) async {
    final Database db = await createDatabase();
    return await db.delete(_tableName, where: 'id=$id');
  }
}
