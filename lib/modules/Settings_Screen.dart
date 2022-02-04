// ignore_for_file: camel_case_types, prefer_const_literals_to_create_immutables, prefer_const_constructors, unnecessary_string_interpolations, unrelated_type_equality_checks
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_v2/ShopCubit/ShopApp_Cubit.dart';
import 'package:shop_app_v2/ShopCubit/ShopApp_States.dart';
import 'package:shop_app_v2/components/components.dart';

class Settings_Screen extends StatelessWidget {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var Formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopAppCubit, ShopAppStates>(
      listener: (BuildContext context, state) {
        if (state is ShopAppUpdateUserDataSuccessState) {

          ShowToast(msg: 'Updated Successfully', states: ToastStates.SUCCESS);

        }
      },
      builder: (BuildContext context, Object? state) {
        var model = ShopAppCubit.get(context).userDataModel;
        nameController.text = '${model!.data!.name!}';
        emailController.text = '${model.data!.email!}';
        phoneController.text = '${model.data!.phone!}';

        return ConditionalBuilder(
          condition: ShopAppCubit.get(context).userDataModel != null,
          builder: (context) => SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Form(
                key: Formkey,
                child: Column(
                  children: [
                    if (state is ShopAppUpdateUserDataLoadingState)
                      LinearProgressIndicator(),
                    SizedBox(height: 30),
                    coloredTextFiled(
                        MyController: nameController,
                        myPrefixIcon: Icons.person,
                        validation: (value) {
                          if (value.isEmpty) {
                            return 'filed must not be empty';
                          }
                          return null;
                        },
                        labelTxt: 'Name',
                        radius: BorderRadius.circular(0),
                        txtType: TextInputType.text,
                        isPassword: false,
                        isEnabled: ShopAppCubit.get(context).isEnable),
                    SizedBox(height: 25),
                    coloredTextFiled(
                        MyController: emailController,
                        myPrefixIcon: Icons.email,
                        validation: (value) {
                          if (value.isEmpty) {
                            return 'filed must not be empty';
                          }
                          return null;
                        },
                        labelTxt: 'Email address',
                        radius: BorderRadius.circular(0),
                        txtType: TextInputType.emailAddress,
                        isPassword: false,
                        isEnabled: ShopAppCubit.get(context).isEnable),
                    SizedBox(height: 25),
                    coloredTextFiled(
                        MyController: phoneController,
                        myPrefixIcon: Icons.phone_android_outlined,
                        validation: (value) {
                          if (value.isEmpty) {
                            return 'filed must not be empty';
                          }
                          return null;
                        },
                        labelTxt: 'Phone',
                        radius: BorderRadius.circular(0),
                        txtType: TextInputType.phone,
                        isPassword: false,
                        isEnabled: ShopAppCubit.get(context).isEnable),
                    SizedBox(height: 60),
                    ConditionalBuilder(
                      condition: state is! ShopAppUpdateUserDataLoadingState ,
                      builder: (context)=> defaultButton(
                          fun: () {
                            if (Formkey.currentState!.validate()) {
                              ShopAppCubit.get(context).UpdateUserData(
                                  name: nameController.text,
                                  email: emailController.text,
                                  phone: phoneController.text
                              );
                            }
                          },
                          color: Colors.red[600],
                          Txt: 'UPDATE'),
                        fallback: (context)=> Center(child: CircularProgressIndicator())
                        ,
                    ),
                    SizedBox(height: 15),
                          defaultButton(
                          fun: () {
                            SignOut(context);
                          },
                          color: Colors.red[600],
                          Txt: 'LOG OUT'),
                    SizedBox(height: 20),
                    IconButton(
                        onPressed: () {
                          ShopAppCubit.get(context).changeEnablity();
                        },
                        icon: CircleAvatar(
                          radius: 70.0,
                          backgroundColor: Colors.grey[200],
                          child: Icon(
                            Icons.edit,
                            color: ShopAppCubit.get(context).isEnable
                                ? Colors.blue[500]
                                : Colors.white,
                            size: 25,
                          ),
                        )),
                  ],
                ),
              ),
            ),
          ),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
