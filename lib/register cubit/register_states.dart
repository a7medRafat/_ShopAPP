// ignore_for_file: camel_case_types, file_names
import 'package:shop_app_v2/models/shopLoginModel.dart';

abstract class ShopRegisterStates {}
class ShopRegisterInitialState extends ShopRegisterStates{}
class ShopRegisterChangeVisibilityState extends ShopRegisterStates{}

class ShopRegisterLoadingState extends ShopRegisterStates{}
class ShopRegisterSuccessState extends ShopRegisterStates{
  final ShopLoginModel model;

  ShopRegisterSuccessState(this.model);

}
class ShopRegisterErrorState extends ShopRegisterStates{}


