// ignore_for_file: non_constant_identifier_names, empty_constructor_bodies

class ShopLoginModel{
    bool? status;
    String? message;
    UserData? data;

    ShopLoginModel.FromJson(Map<String,dynamic>json){
      status = json['status'];
      message = json['message'];
      data = json['data'] !=null ? UserData.FromJson(json['data']):null;
    }

}

class UserData{
  int? id;
  String? name;
  String? email;
  String? phone;
  String? image;
  int? points;
  int? credit;
  String? token;

  UserData.FromJson(Map<String,dynamic>json){
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    image = json['image'];
    points = json['points'];
    credit = json['credit'];
    token = json['token'];

  }

}
