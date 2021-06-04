
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DataBase {
  Database? _db;
  final int _versao = 4;
  final String _nomeDB = 'user.db';

  static DataBase _instancia = DataBase._interno();
  factory DataBase() => _instancia;
  DataBase._interno();

  Future<Database?> getDb() async {
     if (_db == null) {
      var _directory = await getApplicationDocumentsDirectory();
      var _path = join(_directory.path, _nomeDB);
      _db = await openDatabase(_path, version: _versao, onCreate: _onCreate);
    }
  
    return _db; 
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      create table costumers (
      id integer primary key autoincrement,
      name text not null,
      email text UNIQUE not null,
      cpf text not null
      );
    ''');

    await db.execute('''
      create table costumer_address (
      id integer primary key autoincrement,
      costumer_id integer not null,
      public_place text not null,
      neighborhood text not null,
      uf text not null,
      country text not null,
      city text not null,
      zip_code text not null,
      number text not null,
      CONSTRAINT fk_costumers
        FOREIGN KEY (costumer_id)
        REFERENCES costumers(id)
        ON DELETE CASCADE
     );
    ''');
  }
}
