// ignore_for_file: camel_case_types, prefer_const_constructors, sized_box_for_whitespace
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_v2/ShopCubit/ShopApp_Cubit.dart';
import 'package:shop_app_v2/ShopCubit/ShopApp_States.dart';
import 'package:shop_app_v2/constants/constants.dart';
import 'package:shop_app_v2/models/GetFavouritesModel.dart';

class Favourites_Screen extends StatelessWidget {

  const Favourites_Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopAppCubit,ShopAppStates>(
      listener: (BuildContext context, state) {  },
      builder: (BuildContext context, Object? state) {
        return Scaffold(
          body: ConditionalBuilder(
            condition: state is! ShopAppGetFavouritesLoadingState,
            builder: (context)=>ListView.separated(
              physics: BouncingScrollPhysics(),
              itemBuilder: (context,index)=>buildFavouritesItem(ShopAppCubit.get(context).favoritesModel!.data!.data[index],context),
              separatorBuilder: (context,index)=>SizedBox(height: 5),
              itemCount: ShopAppCubit.get(context).favoritesModel!.data!.data.length,
            ),
            fallback: (context)=>Center(child: CircularProgressIndicator()),
          ),
        );
      },
    );
  }

  Widget buildFavouritesItem(ProductData model,context)=>Container(
    height: 150.0,
    child: Padding(
      padding: const EdgeInsets.all(17.0),
      child: Row(
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Image(
                image: NetworkImage('${model.product!.image}'),
                width: 120.0,
                height: 120.0,
              ),
              if (model.product!.discount != 0 )
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
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.product!.name.toString(),
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
                        model.product!.price.toString(),
                        style: TextStyle(
                          color: Colors.red[700],
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      if (model.product!.discount != 0)
                        Text(
                          model.product!.discount.toString(),
                          style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.lineThrough),
                        ),
                      Spacer(),
                      IconButton(
                        onPressed: () {
                          ShopAppCubit.get(context).changeFavourites(model.product!.id);
                        },
                        icon: CircleAvatar(
                            radius: 15.0,

                            backgroundColor: ShopAppCubit.get(context).favourites[model.product!.id] == true ? Colors.red[600] : Colors.grey,
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
