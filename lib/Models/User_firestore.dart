// ignore: camel_case_types
class User_firestore{
  final String name;
  final String Uid;
  User_firestore({this.Uid, this.name});

  Map<String,String> toMap(){
    return{
      'name' : name,
      'Uid' : Uid,
    };
  }
}