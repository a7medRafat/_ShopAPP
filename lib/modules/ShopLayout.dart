// ignore_for_file: camel_case_types, prefer_const_literals_to_create_immutables, prefer_const_constructors
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_v2/ShopCubit/ShopApp_Cubit.dart';
import 'package:shop_app_v2/ShopCubit/ShopApp_States.dart';
import 'package:shop_app_v2/components/components.dart';
import 'package:shop_app_v2/modules/Search_screen.dart';


class Shop_Layout extends StatelessWidget {

  const Shop_Layout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopAppCubit,ShopAppStates>(
      listener: (BuildContext context, state) {
      },
      builder: (BuildContext context, Object? state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Salla.'
            ),
            actions: [
              IconButton(
                  onPressed: (){
                    navigateTo(context, Search_Screen());
                  },
                  icon: Icon(Icons.search)
              ),
              IconButton(
                  onPressed: (){
                  },
                  icon: Icon(Icons.brightness_4_outlined)
              ),

            ],
          ),
          body: ShopAppCubit.get(context).ShopScreens[ShopAppCubit.get(context).currentIndex]  ,
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: ShopAppCubit.get(context).currentIndex,
            onTap: (int index){
              ShopAppCubit.get(context).changeButtonNavBar(index);
            },
              selectedLabelStyle: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.bold
              ),
              items: [
                      BottomNavigationBarItem(
                          icon: Icon(Icons.home),
                          label: 'Home'
                      ),
                      BottomNavigationBarItem(
                          icon: Icon(Icons.workspaces_outline),
                          label: 'Category'
                      ),
                      BottomNavigationBarItem(
                          icon: Icon(Icons.favorite),
                          label: 'Favourites',
                      ),
                      BottomNavigationBarItem(
                          icon: Icon(Icons.settings),
                          label: 'Settings'
                      ),
                    ]
          ),


        );
      },
    );
  }
}
