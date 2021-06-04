import 'package:bdti/controller/costumer_controller.dart';
import 'package:bdti/services/cep_service.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';
import '../../entidades/address.dart';
import '../../entidades/costumer.dart';

class FormularioPage extends StatefulWidget {
  static String routeName = '/formulario';

  final int? idCostumer;

  const FormularioPage({this.idCostumer});

  @override
  _FormularioPageState createState() => _FormularioPageState();
}

class _FormularioPageState extends State<FormularioPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  CostumerController _costumerController = CostumerController();

  Costumer _costumer = Costumer();
  Address _addressCostumer = Address();

  final _nomeController = TextEditingController();
  final _emailController = TextEditingController();
  final _cpfController = TextEditingController();
  final _cepController = TextEditingController();
  final _ruaController = TextEditingController();
  final _numeroController = TextEditingController();
  final _bairroController = TextEditingController();
  final _cidadeController = TextEditingController();
  final _ufController = TextEditingController();
  final _paisController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _costumerController = Provider.of<CostumerController>(context);
    if (widget.idCostumer != null) {
      _loadCostumerData(widget.idCostumer);
    }
  }

  Future<void> _loadCostumerData(int? idCostumer) async {
    _costumer = await _costumerController.getCostumer(idCostumer);
    
    _addressCostumer =
        await _costumerController.getAddressByCostumer(idCostumer);

    _nomeController.text = _costumer.name ?? '';
    _emailController.text = _costumer.email ?? '';
    _cpfController.text = _costumer.cpf ?? '';

    _cepController.text = _addressCostumer.zipCode ?? '';
    _ruaController.text = _addressCostumer.publicPlace ?? '';
    _numeroController.text = _addressCostumer.number ?? '';
    _bairroController.text = _addressCostumer.neighborhood ?? '';
    _cidadeController.text = _addressCostumer.city ?? '';
    _ufController.text = _addressCostumer.uf ?? '';
    _paisController.text = _addressCostumer.country ?? '';
  }

  @override
  void dispose() {
    _nomeController.dispose();
    _emailController.dispose();
    _cpfController.dispose();
    _cepController.dispose();
    _ruaController.dispose();
    _numeroController.dispose();
    _bairroController.dispose();
    _cidadeController.dispose();
    _ufController.dispose();
    _paisController.dispose();
    super.dispose();
  }

  void _showSnackBar(String mensagem) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        content: Text(
          mensagem,
          style: TextStyle(
            fontSize: 18,
            color: Colors.white,
          ),
        ),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _buscarCEP(String cep) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return SimpleDialog(
          children: <Widget>[
            Center(
              child: Column(
                children: <Widget>[
                  CircularProgressIndicator(
                    color: Color(0xff006ba1),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    'Buscando cep..',
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
            )
          ],
        );
      },
    );

    try {
      var _endereco = await CepService().obtemCep(cep);
      _ruaController.text = _endereco.publicPlace as String;
      _bairroController.text = _endereco.neighborhood as String;
      _cidadeController.text = _endereco.city as String;
      _ufController.text = _endereco.uf as String;
      _paisController.text = _endereco.country as String;
    } catch (e) {
      _showSnackBar('CEP não encontrado!!');
    } finally {
      Navigator.of(context).pop();
    }
  }

  void _sendData() async {
    if (!_formKey.currentState!.validate()) {
      _showSnackBar('Informações inválidas');
      return;
    }

    _formKey.currentState!.save();

    if (widget.idCostumer == null) {
          
          try{
              await _costumerController.addCostumer(_costumer, _addressCostumer);
              _showSnackBar('Cliente cadastrado!');
              Navigator.pop(context);
             }on DatabaseException catch(e) { 
              if(e.isUniqueConstraintError()){
              _showSnackBar('Email já cadastrado'); 
              return;
             } 
           }
    
    } else {
       
       try{
           await _costumerController.updateCostumer(_costumer, _addressCostumer);
            _costumerController.setListCostumer();
            _showSnackBar('Dados atualizados');
            Navigator.pop(context);
          }on DatabaseException catch(e){
            if(e.isUniqueConstraintError()){
              _showSnackBar('Email já cadastrado'); 
              return;
              }
          }
        
        }
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Color(0xff006ba1),
        title: Text('Formulário de cadastro'),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            Expanded(
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      buildTextFormField(
                        label: 'Nome completo',
                        controller: _nomeController,
                        onSaved: (valor) {
                          _costumer.name = valor;
                        },
                        validator: (valor) =>
                            (valor!.length < 3) ? 'Nome muito curto' : null,
                      ),
                      SizedBox(height: 15),
                      buildTextFormField(
                        controller: _emailController,
                        label: 'Email',
                        validator: (valor) =>
                            (!EmailValidator.validate(valor ?? ''))
                                ? 'E-mail inválido'
                                : null,
                        onSaved: (valor) => _costumer.email = valor,
                        keyboardType: TextInputType.emailAddress,
                      ),
                      SizedBox(height: 15),
                      buildTextFormField(
                        controller: _cpfController,
                        label: 'CPF',
                        validator: (valor) =>
                            (!UtilBrasilFields.isCPFValido(valor))
                                ? 'CPF inválido'
                                : null,
                        onSaved: (valor) => _costumer.cpf = valor,
                        formatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          CpfInputFormatter(),
                        ],
                        keyboardType: TextInputType.number,
                      ),
                      SizedBox(height: 15),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: buildTextFormField(
                              controller: _cepController,
                              label: 'CEP',
                              onSaved: (valor) =>
                                  _addressCostumer.zipCode = valor,
                              validator: (valor) {
                                var cep = valor?.replaceAll(
                                    new RegExp(r'[^0-9]'), '');
                                return (cep?.length != 8)
                                    ? 'CEP Inválido'
                                    : null;
                              },
                              formatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                CepInputFormatter(),
                              ],
                              keyboardType: TextInputType.number,
                            ),
                          ),
                          SizedBox(width: 10),
                          TextButton.icon(
                            icon: Icon(
                              Icons.search,
                            ),
                            onPressed: () {
                              if (_cepController.text.isNotEmpty) {
                                _buscarCEP(_cepController.text);
                              }
                            },
                            label: Text('Buscar CEP'),
                          ),
                        ],
                      ),
                      SizedBox(height: 15),
                      Row(
                        children: <Widget>[
                          Expanded(
                            flex: 2,
                            child: buildTextFormField(
                              controller: _ruaController,
                              label: 'Rua',
                              validator: (valor) =>
                                  (valor!.length < 3) ? 'Rua inválida' : null,
                              onSaved: (valor) =>
                                  _addressCostumer.publicPlace = valor,
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: buildTextFormField(
                              label: 'Número',
                              controller: _numeroController,
                              validator: (valor) =>
                                  (int.tryParse(valor!) == null)
                                      ? 'Número inválido'
                                      : null,
                              onSaved: (valor) =>
                                  _addressCostumer.number = valor,
                              formatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              keyboardType: TextInputType.number,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 15),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: buildTextFormField(
                              controller: _bairroController,
                              label: 'Bairro',
                              validator: (value) => (value!.length < 3)
                                  ? 'Bairro inválida'
                                  : null,
                              onSaved: (value) =>
                                  _addressCostumer.neighborhood = value,
                            ),
                          ),
                          SizedBox(width: 15),
                          Expanded(
                            child: buildTextFormField(
                              controller: _cidadeController,
                              label: 'Cidade',
                              onSaved: (value) => _addressCostumer.city = value,
                              validator: (value) => (value!.length < 3)
                                  ? 'Bairro inválida'
                                  : null,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 15),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: buildTextFormField(
                              controller: _ufController,
                              label: 'UF',
                              validator: (valor) =>
                                  (valor!.length != 2) ? 'UF inválido' : null,
                              onSaved: (value) => _addressCostumer.uf = value,
                            ),
                          ),
                          SizedBox(width: 15),
                          Expanded(
                            child: buildTextFormField(
                              controller: _paisController,
                              label: 'Pais',
                              validator: (valor) =>
                                  (valor!.toUpperCase() != 'BRASIL')
                                      ? 'País inválido'
                                      : null,
                              onSaved: (valor) =>
                                  _addressCostumer.country = valor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              width: double.maxFinite,
              child: OutlinedButton(
                onPressed: () => _sendData(),
                child: Text('Cadastrar'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  TextFormField buildTextFormField(
      {String? label,
      TextEditingController? controller,
      String? Function(String?)? validator,
      void Function(String?)? onSaved,
      List<TextInputFormatter>? formatters,
      TextInputType? keyboardType}) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
      ),
      validator: validator,
      onSaved: onSaved,
      inputFormatters: formatters,
      keyboardType: keyboardType,
    );
  }

  void registerCostumer() {
    _costumerController.addCostumer(_costumer, _addressCostumer);
  }

  void updateCostumer() {
    _costumerController.updateCostumer(_costumer, _addressCostumer);
  }
}
