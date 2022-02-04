// ignore_for_file: file_names, non_constant_identifier_names, curly_braces_in_flow_control_structures, avoid_print, prefer_const_constructors


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_v2/cubit/LoginStates.dart';
import 'package:shop_app_v2/end%20points/endpoints.dart';
import 'package:shop_app_v2/models/shopLoginModel.dart';
import 'package:shop_app_v2/network/remote/dio_helper.dart';

class ShopLoginCubit extends Cubit <ShopLoginStates> {
  ShopLoginCubit() : super(ShopLoginInitialState());

  static ShopLoginCubit get(context) => BlocProvider.of(context);

  bool IsVisible = true;
  IconData SUffix = Icons.visibility;
  ShopLoginModel? shopLoginModel;

  void ChangeVisibility(){
    IsVisible = !IsVisible;
    emit(ShopChangeVisibilityState());
  }

  void UserLogin({
    required String email,
    required String password
}){

    emit(ShopLoginLoadingState());
    DioHelper.PostData(
        url: LOGIN,
        data: {
          'email':email,
          'password':password,
        }
    ).then((value) {
      print(value.data);
      shopLoginModel = ShopLoginModel.FromJson(value.data);
      print(shopLoginModel!.data!.token);
      print(shopLoginModel!.message);

      emit(ShopLoginSuccessState(shopLoginModel!));
    }).catchError((error){
      print(error.toString());
      emit(ShopLoginErrorState());
    });
  }




}