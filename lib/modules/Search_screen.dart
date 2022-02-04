// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_v2/Search%20Cubit/Search%20cubit.dart';
import 'package:shop_app_v2/Search%20Cubit/search%20states.dart';
import 'package:shop_app_v2/ShopCubit/ShopApp_Cubit.dart';
import 'package:shop_app_v2/components/components.dart';
import 'package:shop_app_v2/models/searchModel.dart';

class Search_Screen extends StatelessWidget {


  var searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>ShopSearchCubit(),
      child: BlocConsumer<ShopSearchCubit,ShopSearchStates>(
        listener: (BuildContext context, state) {  },
        builder: (BuildContext context, Object? state) {
          return  Scaffold(
            appBar: AppBar(),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          coloredTextFiled(
                            MyController: searchController,
                            myPrefixIcon: Icons.search,
                            validation: (Value){
                              if(Value.isEmpty){
                                return 'Search Must Not Be Empty';
                              }
                              return null;
                            },
                            labelTxt: 'Search',
                            radius: BorderRadius.circular(0),
                            txtType: TextInputType.text,
                            mySuffixIconBtn: Icons.arrow_forward_outlined,
                            suffixPressed: (){
                              ShopSearchCubit.get(context).Search();
                            }
                          ),
                          if(state is ShopAppSearchLoadingState)
                            LinearProgressIndicator(),
                          SizedBox(height: 10),

                          Expanded(
                            child: ListView.separated(
                                itemBuilder: (context,index)=>buildSearchItem(ShopSearchCubit.get(context).searchModel!.data!.data[index],context) ,
                                separatorBuilder: (context,index)=>SizedBox(height: 10),
                                itemCount: ShopSearchCubit.get(context).searchModel!.data!.data.length
                            ),
                          )
                        ],
                      )
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }


  Widget buildSearchItem( Product model,context)=>Container(
    height: 140.0,
    child: Padding(
      padding: const EdgeInsets.all(17.0),
      child: Row(
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Image(
                image: NetworkImage('${model.image}'),
                width: 120.0,
                height: 120.0,
              ),
                Container(
                  padding: EdgeInsets.all(3),
                  color: Colors.green[600],
                  child: Text(
                    'DISCOUNT',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12.0,
                        color: Colors.white),
                  ),
                ),
            ],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.name.toString(),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Spacer(),
                  Row(
                    children: [
                      Text(
                        model.price.toString(),
                        style: TextStyle(
                          color: Colors.red[700],
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Spacer(),
                      IconButton(
                        onPressed: () {
                          ShopAppCubit.get(context).changeFavourites(model.id);
                        },
                        icon: CircleAvatar(
                            radius: 15.0,
                            backgroundColor: ShopAppCubit.get(context).favourites[model.id] == true ? Colors.red[600] : Colors.grey,
                            child: Icon(
                              Icons.favorite_border,
                              color: Colors.white,
                              size: 16.0,
                            )
                        ),
                        padding: EdgeInsets.zero,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );

}
