// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'costumer_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$CostumerController on _CostumerControllerBase, Store {
  final _$costumerListAtom = Atom(name: '_CostumerControllerBase.costumerList');

  @override
  ObservableList<Costumer> get costumerList {
    _$costumerListAtom.reportRead();
    return super.costumerList;
  }

  @override
  set costumerList(ObservableList<Costumer> value) {
    _$costumerListAtom.reportWrite(value, super.costumerList, () {
      super.costumerList = value;
    });
  }

  final _$addCostumerAsyncAction =
      AsyncAction('_CostumerControllerBase.addCostumer');

  @override
  Future<void> addCostumer(Costumer newCostumer, Address newAddress) {
    return _$addCostumerAsyncAction
        .run(() => super.addCostumer(newCostumer, newAddress));
  }

  final _$_CostumerControllerBaseActionController =
      ActionController(name: '_CostumerControllerBase');

  @override
  void setListCostumer() {
    final _$actionInfo = _$_CostumerControllerBaseActionController.startAction(
        name: '_CostumerControllerBase.setListCostumer');
    try {
      return super.setListCostumer();
    } finally {
      _$_CostumerControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
costumerList: ${costumerList}
    ''';
  }
}
