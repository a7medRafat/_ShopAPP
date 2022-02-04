// ignore_for_file: prefer_const_constructors, unnecessary_null_comparison, curly_braces_in_flow_control_structures, empty_constructor_bodies, use_key_in_widget_constructors, prefer_const_constructors_in_immutables, avoid_print

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_v2/ShopCubit/ShopApp_Cubit.dart';
import 'package:shop_app_v2/ShopCubit/ShopApp_States.dart';
import 'package:shop_app_v2/constants/constants.dart';
import 'package:shop_app_v2/modules/ShopLayout.dart';
import 'package:shop_app_v2/modules/login%20screen.dart';
import 'package:shop_app_v2/network/local/cash_helper.dart';
import 'package:shop_app_v2/network/remote/dio_helper.dart';
import 'package:shop_app_v2/onBoarding/OnBoarding_screen.dart';
import 'package:shop_app_v2/shared/block_observer.dart';
import 'package:shop_app_v2/styles/styles.dart';


void main()async {
  WidgetsFlutterBinding.ensureInitialized();

  DioHelper.init();
  await CashHelper.init();
  Bloc.observer = MyBlocObserver();

  final bool? onBoarding = CashHelper.getData(key: 'onBoarding');
   token = CashHelper.getData(key: 'token');


  final Widget widget;

  if(onBoarding != null)
    if(token != null)
      widget = Shop_Layout();
    else{
      widget = Login_Screen();
    }
  else{
    widget = OnBoardingScreen();
  }
  runApp( MyApp(
    startWidget: widget,
  ));

}

class MyApp extends StatelessWidget {

  // const MyApp({Key? key}) : super(key: key);
  final Widget? startWidget;

  MyApp({this.startWidget});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (BuildContext context) =>ShopAppCubit()..getHomeData()..getCategoriesData()..getFavourites()..getUserData(),
      child: BlocConsumer<ShopAppCubit,ShopAppStates>(
        listener: (BuildContext context, state) { },
        builder: (BuildContext context, Object? state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: LightTheme,
            darkTheme: DarkTheme,
            themeMode:ThemeMode.light,
            home: startWidget,
          );
        },
      ),
    );
  }
}

