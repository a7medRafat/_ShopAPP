// ignore_for_file: empty_constructor_bodies, non_constant_identifier_names

class ChangeFavouritesModel{

  bool? status;
  String? message;

  ChangeFavouritesModel.FromJson(Map <String,dynamic>json){
    status = json['status'];
    message = json['message'];
  }

}