import 'package:keuanganku/database/helper/data_pemasukan.dart';
import 'package:keuanganku/database/model/data_wallet.dart';
import 'package:keuanganku/main.dart';
import 'package:keuanganku/util/vector_operation.dart';
import 'package:sqflite/sqflite.dart';

class SQLHelperWallet {
    Future createTable(Database db) async {
    await db.execute(SQLHelperWallet().sqlCreateQuery);
  }

  final Map<String, Map<String, String>> _table = {
    "id": {
      "name": "id",
      "type": "INTEGER PRIMARY KEY",
    },
    "tipe" : {
      "name" : "tipe",
      "type" : "TEXT",
      "constraint" : "NOT NULL"
    },
    "judul": {
      "name" : "judul",
      "type" : "TEXT",
      "constraint" : "NOT NULL"
    }
  };

  final _tableName = "wallet";
  
  String get sqlCreateQuery {
    String columns = "";
    _table.forEach((key, value) {
      columns += "${value['name']} ${value['type']} ${value['constraint']}, ";
    });

    // Hapus spasi dan koma pada baris terakhir
    columns = columns.substring(0, columns.length - 2);

    return """
      CREATE TABLE IF NOT EXISTS $_tableName (
        $columns
      )
    """;
  }

  // READ METHODS 
  Future<List<SQLModelWallet>> readAll(Database db) async {
    final List<Map<String, dynamic>> maps = await db.query(_tableName);

    return List.generate(maps.length, (i) {
      return SQLModelWallet(
        id: maps[i]['id'],
        tipe: maps[i]['tipe'],
        judul: maps[i]['judul'],
      );
    });
  }

  Future<double> readTotalUang(SQLModelWallet wallet) async{
    final dataPemasukan = await SQLHelperPemasukan().readDataByWalletId(wallet.id, db.database);
    return sumList(dataPemasukan.map((e) => e.nilai).toList());
  }

  // INSERT METHODS
  Future<int> insert(SQLModelWallet wallet, Database db) async {
    return await db.rawInsert(
      "INSERT INTO $_tableName(tipe, judul) VALUES(?, ?)",
      [wallet.tipe, wallet.judul]
    );
  }
}