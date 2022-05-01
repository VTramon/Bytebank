import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'DAO/contact_dao.dart';
import 'DAO/transfer_dao.dart';

Future<Database> createDatabase() async {
  // WidgetsFlutterBinding.ensureInitialized();
  final String path = join(await getDatabasesPath(), 'teste.db');

  return await openDatabase(
    path,
    onCreate: (db, version) async {
      await db.execute(ContactDAO.tableSQL);
      await db.execute(TransferDAO.tableSQL);
    },
    onDowngrade: onDatabaseDowngradeDelete,
    onUpgrade: onDatabaseDowngradeDelete,
    version: 1,
  );
}

// Future<int> save(Transfer transfer) async {
//   final Database db = await createDatabase();
//   final Map<String, dynamic> contactMap = {};

//   contactMap['name'] = transfer.name;
//   contactMap['numberAccount'] = transfer.numberAccount;
//   contactMap['transferValue'] = transfer.transferValue;

//   return db.insert('transfers', contactMap);
// }

// Future<List<Transfer>> findAll() async {
//   final Database db = await createDatabase();
//   final List<Map<String, Object?>> result = await db.query('transfers');
//   final List<Transfer> transferList = List.empty(growable: true);

//   for (Map<String, dynamic> map in result) {
//     final Transfer transfer =
//         Transfer(map['name'], map['numberAccount'], map['value'], map['id']);
//     transferList.add(transfer);
//   }
//   return transferList;
// }
