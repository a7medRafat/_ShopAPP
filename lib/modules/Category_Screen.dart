// ignore_for_file: camel_case_types, prefer_const_literals_to_create_immutables, prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:shop_app_v2/ShopCubit/ShopApp_Cubit.dart';
import 'package:shop_app_v2/models/CategoriesModel.dart';

class Category_Screen extends StatelessWidget {

  const Category_Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.separated(
        physics: BouncingScrollPhysics(),
          itemBuilder: (context,index)=>buildCategoryItems(ShopAppCubit.get(context).categoriesModel!.data!.data[index]),
          separatorBuilder: (context,index)=> SizedBox(height: 10,),
          itemCount: ShopAppCubit.get(context).categoriesModel!.data!.data.length,
      ),

    );
  }

  Widget buildCategoryItems(DataModel model)=>Padding(
    padding: const EdgeInsets.all(10.0),
    child: SingleChildScrollView(
      child: Row(
        children: [
          Image(image: NetworkImage(model.image!),
            height: 100,
            width: 130,
            // fit: BoxFit.cover,
          ),
          SizedBox(width: 10,),
          Text(
            model.name!,
            style: TextStyle(
                fontSize: 17.0,
                fontWeight: FontWeight.bold,
                color: Colors.black
            ),
          ),
          Spacer(),
          IconButton(
              onPressed: (){},
              icon: Icon(Icons.double_arrow_outlined)
          )
        ],
      ),
    ),
  );
}
