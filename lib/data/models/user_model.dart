
class UserModel {
  late int id;
  String? name;
  String? note;


  UserModel.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    name = map['name'];
    note = map['note'];
  }

  UserModel.clear() {
    id = 0;
    name = '';
    note = '';
  }
}