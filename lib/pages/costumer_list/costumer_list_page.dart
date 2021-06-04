import 'package:bdti/controller/costumer_controller.dart';
import 'package:bdti/pages/costumer_list/slide_dismissible.dart';
import 'package:bdti/pages/form_costumer/formulario.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class CostumerList extends StatefulWidget {
  static String routeName = '/costumerList';

  @override
  _CostumerListState createState() => _CostumerListState();
}

class _CostumerListState extends State<CostumerList> {
  CostumerController _handleCostumer = CostumerController();

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    _handleCostumer = Provider.of<CostumerController>(context);
    _handleCostumer.setListCostumer();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    

    void _callFormCostumer([int? idUser]) async {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return FormularioPage(idCostumer: idUser);
        },
      );
    }

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            leading:
                Image.asset('assets/images/bdti/icon_bdti.png', width: 100.0),
            backgroundColor: Color(0xff006ba1),
            title: Text('Clientes')),
        body: Column(
          children: <Widget>[
            Expanded(
              child: Observer(builder: (_) {
                return ListView.builder(
                  itemCount: _handleCostumer.costumerList.length,
                  itemBuilder: (_, index) {
                    return Dismissible(
                      key: UniqueKey(),
                      background: slidDimissibleLeft(),
                      secondaryBackground: slidDimissibleRight(),
                      confirmDismiss: (direction) async {
                        if(DismissDirection.endToStart == direction){
                            _callFormCostumer(
                              _handleCostumer.costumerList[index].id);
                           return false;
                        }else{
                          _handleCostumer.deleteCustomer(
                            _handleCostumer.costumerList[index]);
                         return  true;
                        }
                      }, 
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(
                              'https://www.gravatar.com/avatar/$index?d=robohash'),
                        ),
                        title: Text(
                            _handleCostumer.costumerList[index].name ?? ''),
                        subtitle: Text(
                            _handleCostumer.costumerList[index].email ?? ''),
                        ),
                    );
                  },
                );
              }),
            ),
          ],
        ),
        floatingActionButton: new FloatingActionButton(
          onPressed: () {
            _callFormCostumer();
          },
          mini: false,
          child: new Icon(Icons.add),
        ),
      ),
    );
  }
}
