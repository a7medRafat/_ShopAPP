// ignore_for_file: camel_case_types, unnecessary_import, prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_null_comparison, sized_box_for_whitespace, non_constant_identifier_names, avoid_print


import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_v2/ShopCubit/ShopApp_Cubit.dart';
import 'package:shop_app_v2/ShopCubit/ShopApp_States.dart';
import 'package:shop_app_v2/components/components.dart';
import 'package:shop_app_v2/constants/constants.dart';
import 'package:shop_app_v2/models/CategoriesModel.dart';
import 'package:shop_app_v2/models/HomeModel.dart';

class Home_Screen extends StatelessWidget {
  const Home_Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopAppCubit, ShopAppStates>(
      listener: (BuildContext context, state) {

        if(state is ShopAppChangeFavouritesSuccessState){
          if(!state.model.status!){
            ShowToast(
                msg: state.model.message!,
                states: ToastStates.ERROR
            );
          }

        }

      },
      builder: (BuildContext context, Object? state) {
        var cubit = ShopAppCubit.get(context);

        return Scaffold(
          body: ConditionalBuilder(
            condition: cubit.homeModel != null && cubit.categoriesModel != null,
            builder: (context) => homeBuilder(cubit.homeModel!,cubit.categoriesModel! ,context),
            fallback: (context) => Center(child: CircularProgressIndicator()),
          ),
        );
      },
    );
  }

  Widget homeBuilder(HomeModel model, CategoriesModel categoriesModel , context) => SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: CarouselSlider(
                    items: model.data!.banners
                        .map(
                          (e) => Image(
                            image: NetworkImage('${e.image}'),
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        )
                        .toList(),
                    options: CarouselOptions(
                      height: 200.0,
                      initialPage: 0,
                      viewportFraction: 1.0,
                      reverse: false,
                      autoPlay: true,
                      autoPlayInterval: Duration(seconds: 3),
                      autoPlayAnimationDuration: Duration(seconds: 1),
                      autoPlayCurve: Curves.fastOutSlowIn,
                      scrollDirection: Axis.horizontal,
                      enableInfiniteScroll: true,
                    )),
              ),
              SizedBox(height: 5,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Categories',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 23.0,
                          color: Colors.red[600]),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      height: 120.0,
                      child: ListView.separated(
                        physics: BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context,index)=>BuildCategories(categoriesModel.data!.data[index]),
                          separatorBuilder: (context,index)=>SizedBox(width: 10.0,),
                          itemCount: categoriesModel.data!.data.length
                      ),
                    ),
                    Text(
                      'New Products',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 23.0,
                          color: Colors.red[600]),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                color: Colors.grey[400],
                child: GridView.count(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  mainAxisSpacing: 1.0,
                  crossAxisSpacing: 1.0,
                  childAspectRatio: 1 / 1.7,
                  children: List.generate(
                      model.data!.products.length,
                      (index) =>
                          buildGridProducts(model.data!.products[index],context),
                  ),
                ),
              )
            ],
          ),
        ),
      );

  Widget buildGridProducts(ProductModel model,context) => Container(
        color: Colors.white,
        child: Column(
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(
                  image: NetworkImage(model.image!),
                  width: double.infinity,
                  height: 200.0,
                ),
                if (model.discount != 0)
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${model.name}',
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
                  Row(
                    children: [
                      Text(
                        '${model.price.round()}\$',
                        style: TextStyle(
                          color: Colors.red[600],
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      if (model.discount != 0)
                        Text(
                          '${model.oldPrice.round()}\$',
                          style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.lineThrough),
                        ),
                      Spacer(),
                      IconButton(
                        onPressed: () {
                          ShopAppCubit.get(context).changeFavourites(model.id);
                          print(model.id);
                        },
                        icon: CircleAvatar(
                            radius: 15.0,
                            backgroundColor: ShopAppCubit.get(context).favourites[model.id] == true ? Colors.red[600] : Colors.grey,
                            child: Icon(
                              Icons.favorite_outline,
                              color: Colors.white,
                              size: 18.0,
                            )
                        ),
                        padding: EdgeInsets.zero,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      );

  Widget BuildCategories(DataModel model)=>Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 100.0,
          child: Stack(
            alignment: AlignmentDirectional.bottomCenter,
            children: [
              Image(
                image: NetworkImage(model.image!),
                height: 100,
                width: 120,
                fit: BoxFit.cover,
              ),
              Container(
                alignment: Alignment.center,
                width: double.infinity,
                color: Colors.black.withOpacity(0.6),
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Text(
                    model.name!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 13.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),

      ],
    ),
  );
}
