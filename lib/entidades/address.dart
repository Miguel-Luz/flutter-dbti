class Address {
  int? id;
  int? costumerId;
  String? zipCode;
  String? publicPlace;
  String? number;
  String? neighborhood;
  String? city;
  String? uf;
  String? country;

  Address({
    this.id,
    this.costumerId,
    this.zipCode,
    this.publicPlace,
    this.number,
    this.neighborhood,
    this.city,
    this.uf,
    this.country,
  });

  Address.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    costumerId = map['costumer_id'];
    publicPlace = map['public_place'];
    neighborhood = map['neighborhood'];
    city = map['city'];
    uf = map['uf'];
    country = 'Brasil';
    number = map['number'];
    zipCode = map['zip_code'];
  }

  Address.fromCep(Map<String, dynamic> map) {
    publicPlace = map['logradouro'];
    neighborhood = map['bairro'];
    city = map['localidade'];
    uf = map['uf'];
    country = 'Brasil';
  }

  Map<String, dynamic> toMap() {
    return {
      'public_place': publicPlace,
      'costumer_id': costumerId,
      'neighborhood': neighborhood,
      'city': city,
      'uf': uf,
      'country': country,
      'zip_code': zipCode,
      'number': number,
    };
  }
}
