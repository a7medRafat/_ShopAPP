
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_v2/Search%20Cubit/search%20states.dart';
import 'package:shop_app_v2/constants/constants.dart';
import 'package:shop_app_v2/end%20points/endpoints.dart';
import 'package:shop_app_v2/models/searchModel.dart';
import 'package:shop_app_v2/network/remote/dio_helper.dart';

class ShopSearchCubit extends Cubit <ShopSearchStates> {

  ShopSearchCubit() : super(ShopAppSearchInitialState());

  static ShopSearchCubit get(context) => BlocProvider.of(context);

  SearchModel? searchModel;
  void Search({
    String? text
  }){
    emit(ShopAppSearchLoadingState());

    DioHelper.PostData(
        url: SEARCH,
        data: {
          'text':text,
        },
        token: token
    ).then((value) {
      searchModel = SearchModel.fromJson(value.data);
      emit(ShopAppSearchSuccessState());
    }).catchError((error){
      emit(ShopAppSearchErrorState());
    });
  }



}