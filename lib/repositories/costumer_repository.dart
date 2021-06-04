
import 'package:bdti/database/database.dart';
import 'package:bdti/entidades/costumer.dart';

class CostumerRepository {
  final _db = DataBase();

  Future<Costumer?> newCostumer(Costumer obj) async {
    
    Costumer? newCostumer = Costumer();
 
    var handleDb = await _db.getDb();
    var id = await handleDb!.insert('costumers', obj.toMap()) ;
    var rows = await handleDb.query('costumers', where: 'id = ?', whereArgs: [id]);
        
    rows.forEach((element) => newCostumer  = Costumer.fromMap(element));
    return newCostumer;
  }

  Future<bool> updateCostumer(Costumer obj) async {
    var handleDb = await _db.getDb();
    var rows = await handleDb
        ?.update('costumers', obj.toMap(), where: 'id = ?', whereArgs: [obj.id]);
    return rows !> 0;
  }

  Future<bool> delCostumer(Costumer obj) async {
    var handleDb = await _db.getDb();
    var rows =
        await handleDb?.delete('costumers', where: 'id = ?', whereArgs: [obj.id]);
    return rows !> 0;
  }

  Future<bool> delAll() async {
    var handleDb = await _db.getDb();
    var rows = await handleDb?.delete('costumers');
    return rows !> 0;
  }

  Future<List<Costumer>> getCostumer(int id) async {
    var retorno = <Costumer>[];
    var handleDb = await _db.getDb();
    var rows =
        await handleDb?.query('costumers', where: 'where id = ?', whereArgs: [id]);
    if (rows!.isNotEmpty) {
      rows.forEach((element) => retorno.add(Costumer.fromMap(element)));
      return retorno;
    }
    return retorno;
  }

  Future<List<Costumer>> getBy(String colunm, String value) async {
    var retorno = <Costumer>[];
    var handleDb = await _db.getDb();
    var rows =
        await handleDb?.query('costumers', where: '$colunm = ?', whereArgs: [value]);
    if (rows!.isNotEmpty) {
      rows.forEach((element) => retorno.add(Costumer.fromMap(element)));
      return retorno;
    }
    return retorno;
  }

  Future<List<Costumer>> allCostumer() async {
    var retorno = <Costumer>[];
    var handleDb = await _db.getDb();
    var rows = await handleDb?.query('costumers');
    if (rows!.isNotEmpty) {
      rows.forEach((element) => retorno.add(Costumer.fromMap(element)));
      return retorno;
    }
    return retorno;
  }
}
