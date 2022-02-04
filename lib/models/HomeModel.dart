// ignore_for_file: file_names, non_constant_identifier_names, empty_constructor_bodies

class HomeModel{
   bool? status;
   HomeData? data;

  HomeModel.FromJson(Map <String , dynamic> json){
    status = json['status'];
    data = HomeData.FromJson(json['data']);
  }

}
class HomeData{

  List<BannersModel> banners = [];
  List<ProductModel> products = [];

  HomeData.FromJson(Map <String , dynamic> json){
    json['banners'].forEach((element) {
      banners.add(BannersModel.FromJson(element));
    });

    json['products'].forEach((element) {
      products.add(ProductModel.FromJson(element));
    });
  }

}

class BannersModel{
   int? id;
   String? image;

  BannersModel.FromJson(Map <String , dynamic> json){
    id = json['id'];
    image = json['image'];
  }

}

class ProductModel{
   int? id;
   dynamic price;
   dynamic oldPrice;
   dynamic discount;
   String? image;
   String? name;
   bool? inFavorites;
   bool? inCart;

  ProductModel.FromJson(Map <String , dynamic> json){
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    inFavorites = json['in_favorites'];
    inCart = json['in_cart'];


  }
}