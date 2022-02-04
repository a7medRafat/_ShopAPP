// ignore_for_file: file_names, non_constant_identifier_names, curly_braces_in_flow_control_structures, avoid_print, prefer_const_constructors


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_v2/end%20points/endpoints.dart';
import 'package:shop_app_v2/models/shopLoginModel.dart';
import 'package:shop_app_v2/network/remote/dio_helper.dart';
import 'package:shop_app_v2/register%20cubit/register_states.dart';

class ShopRegisterCubit extends Cubit <ShopRegisterStates> {
  ShopRegisterCubit() : super(ShopRegisterInitialState());

  static ShopRegisterCubit get(context) => BlocProvider.of(context);

  bool IsVisible = true;
  IconData SUffix = Icons.visibility;
  ShopLoginModel? shopLoginModel;

  void ChangeVisibility(){
    IsVisible = !IsVisible;
    emit(ShopRegisterChangeVisibilityState());
  }

  ShopLoginModel? loginModel;

  void UserRegister({
    required String name,
    required String password,
    required String email,
    required String phone,
  }){
    emit(ShopRegisterLoadingState());
    DioHelper.PostData(
        url: REGISTER,
        data: {
          'name':name,
          'email':email,
          'password':password,
          'phone':phone,
        },
    ).then((value) {
      print(value.data);
      loginModel = ShopLoginModel.FromJson(value.data);
      print(loginModel!.message);

      emit(ShopRegisterSuccessState(loginModel!));
    }).catchError((error){
      print(error.toString());
      emit(ShopRegisterErrorState());
    });
  }




}