import 'package:bdti/database/database.dart';
import '../entidades/address.dart';

class AddressRepository {
  final _db = DataBase();

  Future<bool> newAddress(Address obj) async {
    var handleDb = await _db.getDb();
    var lastInsert =
        await handleDb?.rawQuery(' select last_insert_rowid() as costumerId');

    var insertAddress = {
      'costumer_id': lastInsert![0]['costumerId'],
      'public_place': obj.publicPlace,
      'neighborhood': obj.neighborhood,
      'city': obj.city,
      'uf': obj.uf,
      'country': obj.country,
      'zip_code': obj.zipCode,
      'number': obj.number,
    };

    var rows = await handleDb?.insert('costumer_address', insertAddress);

    return rows !> 0;
   }

  Future<bool> updateAddress(Address obj) async {
    var handleDb = await _db.getDb();
    var rows = await handleDb?.update('costumer_address', obj.toMap(),
        where: 'id = ?', whereArgs: [obj.id]);
    return rows !> 0;
  }

  Future<List<Address>> allAdress() async {
    var retorno = <Address>[];
    var handleDb = await _db.getDb();
    var rows = await handleDb?.query('costumer_address');

    if (rows!.isNotEmpty) {
      rows.forEach((element) => retorno.add(Address.fromMap(element)));
      return retorno;
    }
    return retorno;
  }

  Future<List<Address>> getAdress(int id) async {
    var retorno = <Address>[];
    var handleDb = await _db.getDb();
    var rows = await handleDb
        ?.query('costumer_address', where: 'where id = ?', whereArgs: [id]);
    if (rows!.isNotEmpty) {
      rows.forEach((element) => retorno.add(Address.fromMap(element)));
      return retorno;
    }
    return retorno;
  }

  Future<List<Address>> getBy(String? column, int? value) async {
    var retorno = <Address>[];
    var handleDb = await _db.getDb();
    var rows = await handleDb
        ?.query('costumer_address', where: '$column = ?', whereArgs: [value]);
    if (rows!.isNotEmpty) {
      rows.forEach((element) => retorno.add(Address.fromMap(element)));
    }
    return retorno;
  }

  Future<bool> delAll() async {
    var handleDb = await _db.getDb();
    var rows = await handleDb?.delete('costumer_address');
    return rows !> 0;
  }
}
