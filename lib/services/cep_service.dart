import '../entidades/address.dart';
import 'package:dio/dio.dart';

class CepService {
  Future<Address> obtemCep(String cep) async {
    
    cep = cep.replaceAll(new RegExp(r'[^0-9]'),'');
    
    try {
      var _response = await Dio().get('https://viacep.com.br/ws/$cep/json/');
      var retorno = Address.fromCep(_response.data);
      return retorno;
    } on DioError catch (e) {
      throw Exception(e.message);
    }
  }
}
