
// ignore_for_file: prefer_const_constructors, avoid_print, avoid_function_literals_in_foreach_calls, non_constant_identifier_names, curly_braces_in_flow_control_structures

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_v2/ShopCubit/ShopApp_States.dart';
import 'package:shop_app_v2/constants/constants.dart';
import 'package:shop_app_v2/end%20points/endpoints.dart';
import 'package:shop_app_v2/models/CategoriesModel.dart';
import 'package:shop_app_v2/models/GetFavouritesModel.dart';
import 'package:shop_app_v2/models/HomeModel.dart';
import 'package:shop_app_v2/models/UpdateUserData.dart';
import 'package:shop_app_v2/models/UserModel.dart';
import 'package:shop_app_v2/models/changeFavouritesModel.dart';
import 'package:shop_app_v2/models/searchModel.dart';
import 'package:shop_app_v2/models/shopLoginModel.dart';
import 'package:shop_app_v2/modules/Category_Screen.dart';
import 'package:shop_app_v2/modules/Favourites_Screen.dart';
import 'package:shop_app_v2/modules/Home_Screen.dart';
import 'package:shop_app_v2/modules/Settings_Screen.dart';
import 'package:shop_app_v2/network/remote/dio_helper.dart';

class ShopAppCubit extends Cubit<ShopAppStates>{

  ShopAppCubit() : super(ShopAppInitialState());

  static ShopAppCubit get(context)=> BlocProvider.of(context);

  // ignore: non_constant_identifier_names
  List<Widget> ShopScreens=[
    Home_Screen(),
    Category_Screen(),
    Favourites_Screen(),
    Settings_Screen(),
  ];

  int currentIndex = 0;
  void changeButtonNavBar(int index){
    currentIndex = index;
    emit(ShopAppChangeButtonNavBarState());
  }

  HomeModel? homeModel;
  Map<int,bool> favourites={};
  void getHomeData(){
    emit(ShopAppLoadingState());

    DioHelper.getData(
        url: HOME,
        token: token
    ).then((value) {
      homeModel = HomeModel.FromJson(value.data);
      // printFullText(homeModel!.data!.banners[0].id.toString());

      homeModel!.data!.products.forEach((element) {
        favourites.addAll({
          element.id! : element.inFavorites!,
        });
      });
      print(favourites.toString());

      emit(ShopAppSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(ShopAppErrorState());
    });

  }


  CategoriesModel? categoriesModel;
  void getCategoriesData(){
    DioHelper.getData(
        url: CATEGORIES,
        token: token,
    ).then((value) {
      categoriesModel = CategoriesModel.FromJson(value.data);
      printFullText(categoriesModel!.data!.data.toString());
      emit(ShopAppCategoriesSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(ShopAppCategoriesErrorState());
    });

  }


  ChangeFavouritesModel? changeFavouritesModel;
  int? productId;
  void changeFavourites(productId){

    if(favourites[productId] == true){
      favourites[productId] = false;
    }
    else
      favourites[productId] = true;

    emit(ShopAppChangeFavouritesState());

    DioHelper.PostData(
        url: FAVOURITES,
        data: {'product_id' : productId},
        token: token,
    ).then((value) {

      changeFavouritesModel = ChangeFavouritesModel.FromJson(value.data);
      if(changeFavouritesModel!.status == false){
        if(favourites[productId] == true){
          favourites[productId] = false;
        }
        else
          favourites[productId] = true;
      }
      else{
        getFavourites();
      }

      print(value.data);

      emit(ShopAppChangeFavouritesSuccessState(changeFavouritesModel!));
    }).catchError((error){
      if(favourites[productId] == true){
        favourites[productId] = false;
      }
      else
        favourites[productId] = true;
      emit(ShopAppChangeFavouritesErrorState());
    });
  }

  FavoritesModel? favoritesModel;
  void getFavourites(){
    emit(ShopAppGetFavouritesLoadingState());

    DioHelper.getData(
        url: FAVOURITES,
        token: token
    ).then((value) {
      favoritesModel = FavoritesModel.fromJson(value.data);
      emit(ShopAppGetFavouritesSuccessState());
    }).catchError((error){
      emit(ShopAppGetFavouritesErrorState());
    });

  }

  UserDataModel? userDataModel;
  void getUserData(){
    emit(ShopAppGetUserDataLoadingState());

    DioHelper.getData(
        url: PROFILE,
        token: token
    ).then((value) {
      userDataModel = UserDataModel.FromJson(value.data);
      print(userDataModel!.data!.name);
      emit(ShopAppGetUserDataSuccessState());
    }).catchError((error){
      emit(ShopAppGetUserDataErrorState());
    });

  }


  void UpdateUserData({
    required String name,
    required String email,
    required String phone,
  }){
    emit(ShopAppUpdateUserDataLoadingState());

    DioHelper.putData(
        url: 'update-profile',
        data: {
          'name':name,
          'email':email,
          'phone':phone,
        },
        token: token,
    ).then((value) {
      userDataModel = UserDataModel.FromJson(value.data);
      print(userDataModel!.data!.name);
      emit(ShopAppUpdateUserDataSuccessState(userDataModel));
    }).catchError((error){
      emit(ShopAppUpdateUserDataErrorState(userDataModel!));
    });

  }




  bool isEnable = false;
  void changeEnablity(){
    isEnable =! isEnable;
    emit(ShopAppChangwEnabilityState());
  }

}



