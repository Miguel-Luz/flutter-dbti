import 'package:bdti/entidades/costumer.dart';
import 'package:bdti/entidades/address.dart';
import 'package:bdti/repositories/address_repository.dart';
import 'package:bdti/repositories/costumer_repository.dart';
import 'package:mobx/mobx.dart';
part 'costumer_controller.g.dart';

class CostumerController = _CostumerControllerBase with _$CostumerController;

abstract class _CostumerControllerBase with Store {
  CostumerRepository _costumerRepository = CostumerRepository();
  AddressRepository _addressRepository = AddressRepository();

  @observable
  ObservableList<Costumer> costumerList = ObservableList.of([]);

  @action
  void setListCostumer() {
    _costumerRepository
        .allCostumer()
        .then((value) => costumerList = value.asObservable());
  }

  @action
  Future<void> addCostumer(Costumer newCostumer, Address newAddress) async {
    var _storegedCostumer = await _costumerRepository.newCostumer(newCostumer);
    if(_storegedCostumer != null) {
       costumerList.add(_storegedCostumer);
      _addressRepository.newAddress(newAddress);
    }
  }

  Future<Costumer> getCostumer(int? idCostumer) async {
    Costumer _costumer = Costumer();
    _costumer = await _costumerRepository
        .getBy('id', idCostumer.toString())
        .then((value) => value[0]);

    return _costumer;
  }

  Future<Address> getAddressByCostumer(int? idCostumer) async {
    Address _address = Address();
    _address = await _addressRepository
        .getBy('costumer_id', idCostumer)
        .then((value) => value[0]);

    return _address;
  }

  Future<void> updateCostumer(Costumer costumer, Address address) async {
    await _costumerRepository.updateCostumer(costumer);
    await _addressRepository.updateAddress(address);
  }

  void deleteCustomer(Costumer costumer) {
    _costumerRepository.delCostumer(costumer);
    costumerList.remove(costumer);
  }
}
