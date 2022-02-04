// ignore_for_file: empty_constructor_bodies, non_constant_identifier_names

class CategoriesModel{
  bool? status;
  CategoriesDataModel? data;

  CategoriesModel.FromJson(Map<String,dynamic>json){
    status = json['status'];
    data = CategoriesDataModel.FromJson(json['data']);

  }
}

class CategoriesDataModel{
  int? currentPage;
  List<DataModel>data=[];

  CategoriesDataModel.FromJson(Map<String,dynamic>json){

    currentPage = json['current_page'];
    json['data'].forEach((elements){
      data.add(DataModel.FromJson(elements));
    });

  }

}

class DataModel{
  int? id;
  String? name;
  String? image;

  DataModel.FromJson(Map<String,dynamic>json){

    id = json['id'];
    name = json['name'];
    image = json['image'];

  }
}