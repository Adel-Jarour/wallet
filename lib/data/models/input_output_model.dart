class InputOutputModel {

  late String name;
  String? input;
  String? output;
  late String date;


  InputOutputModel.fromMap(Map<String, dynamic> map) {
    name = map['name'];
    input = map['input'];
    output = map['output'];
    date = map['date'];
  }
}
