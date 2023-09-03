
class AmountModel {
  late int id;
  late int uid;
  String? input;
  String? output;
  String? date;
  String? note;


  AmountModel.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    uid = map['user_id'];
    input = map['input'];
    output = map['output'];
    date = map['date'];
    note = map['note'];
  }

}