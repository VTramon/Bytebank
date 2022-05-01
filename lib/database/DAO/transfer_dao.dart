import 'package:bytebank/models/transfer.dart';
import 'package:sqflite/sqflite.dart';

import '../app_database.dart';

class TransferDAO {
  static const String _tableName = 'transfers';
  static const String _numberAccount = 'numberAccount';
  static const String _value = 'transferValue';
  static const String _id = 'id';

  static const String tableSQL =
      'CREATE TABLE IF NOT EXISTS $_tableName($_id INTEGER PRIMARY KEY, $_numberAccount INTEGER, $_value DOUBLE);';

  Future<int> save(Transfer transfer) async {
    final Database db = await createDatabase();
    final Map<String, dynamic> transferMap = {};

    transferMap[_numberAccount] = transfer.numberAccount;
    transferMap[_value] = transfer.transferValue;

    return db.insert(_tableName, transferMap);
  }

  Future<List<Transfer>> findAll() async {
    final List<Map<String, Object?>> result =
        await createDatabase().then((value) => value.query(_tableName));
    final List<Transfer> transferList = List.empty(growable: true);

    for (Map<String, dynamic> map in result) {
      final Transfer transfer =
          Transfer(map[_numberAccount], map[_value], map[_id]);
      transferList.add(transfer);
    }
    return transferList;
  }
}
