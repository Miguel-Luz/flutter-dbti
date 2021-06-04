
class Costumer {
  int? id;
  String? name;
  String? email;
  String? cpf;
 
  Costumer({this.id,this.name, this.email, this.cpf});

  Costumer.fromMap(Map<String, dynamic> obj) {
    id = obj['id'];
    name = obj['name'];
    email = obj['email'];
    cpf = obj['cpf'];
  }

  Map<String, dynamic> toMap() {
    return {'id': id,'name': name, 'email': email, 'cpf': cpf};
  }

 @override
  String toString() {
    return 
      this.id.toString() + '\n'
    + this.name.toString() + '\n'
    + this.email.toString() + '\n'
    + this.cpf.toString() + '\n';
  }



}
