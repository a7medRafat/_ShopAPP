// ignore_for_file: camel_case_types, file_names
import 'package:shop_app_v2/models/shopLoginModel.dart';

abstract class ShopLoginStates {}
class ShopLoginInitialState extends ShopLoginStates{}
class ShopChangeVisibilityState extends ShopLoginStates{}

class ShopLoginLoadingState extends ShopLoginStates{}
class ShopLoginSuccessState extends ShopLoginStates{
  final ShopLoginModel shopLoginModel;

  ShopLoginSuccessState(this.shopLoginModel);

}
class ShopLoginErrorState extends ShopLoginStates{}


