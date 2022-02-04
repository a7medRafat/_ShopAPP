import 'package:shop_app_v2/ShopCubit/ShopApp_Cubit.dart';
import 'package:shop_app_v2/models/UserModel.dart';
import 'package:shop_app_v2/models/changeFavouritesModel.dart';

abstract class ShopAppStates{}

class ShopAppInitialState extends ShopAppStates{}

class ShopAppChangeButtonNavBarState extends ShopAppStates{}
class ShopAppLoadingState extends ShopAppStates{}
class ShopAppSuccessState extends ShopAppStates{
}
class ShopAppErrorState extends ShopAppStates{}


class ShopAppCategoriesSuccessState extends ShopAppStates{}
class ShopAppCategoriesErrorState extends ShopAppStates{}

class ShopAppChangeFavouritesSuccessState extends ShopAppStates{
   final ChangeFavouritesModel model;

  ShopAppChangeFavouritesSuccessState(this.model);
}
class ShopAppChangeFavouritesErrorState extends ShopAppStates{}
class ShopAppChangeFavouritesState extends ShopAppStates{}

class ShopAppGetFavouritesLoadingState extends ShopAppStates{}
class ShopAppGetFavouritesSuccessState extends ShopAppStates{}
class ShopAppGetFavouritesErrorState extends ShopAppStates{}

class ShopAppGetUserDataLoadingState extends ShopAppStates{}
class ShopAppGetUserDataSuccessState extends ShopAppStates{}
class ShopAppGetUserDataErrorState extends ShopAppStates{}

class ShopAppUpdateUserDataLoadingState extends ShopAppStates{}
class ShopAppUpdateUserDataSuccessState extends ShopAppStates{
  final UserDataModel? model;

  ShopAppUpdateUserDataSuccessState(this.model);
}
class ShopAppUpdateUserDataErrorState extends ShopAppStates{
  final UserDataModel model;

  ShopAppUpdateUserDataErrorState(this.model);

}

class ShopAppChangwEnabilityState extends ShopAppStates{}
