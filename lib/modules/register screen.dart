// ignore_for_file: camel_case_types, prefer_const_constructors, unnecessary_string_interpolations
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_v2/components/components.dart';
import 'package:shop_app_v2/constants/constants.dart';
import 'package:shop_app_v2/modules/Home_Screen.dart';
import 'package:shop_app_v2/modules/ShopLayout.dart';
import 'package:shop_app_v2/modules/login%20screen.dart';
import 'package:shop_app_v2/network/local/cash_helper.dart';
import 'package:shop_app_v2/register%20cubit/register_cubit.dart';
import 'package:shop_app_v2/register%20cubit/register_states.dart';


class Register_Screen extends StatelessWidget {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();

  var fomKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ShopRegisterCubit(),
      child: BlocConsumer<ShopRegisterCubit, ShopRegisterStates>(
        listener: (BuildContext context, state) {
          if(state is ShopRegisterSuccessState){
            if(state.model.status == true){
              print(state.model.data!.token);
              ShowToast(
                  msg:'${state.model.message}',
                  states: ToastStates.SUCCESS
              );
              CashHelper.saveData(key: 'token', value: state.model.data!.token).then((value) {
                token = state.model.data!.token!;
                navigateAndFinish(context, Shop_Layout());
              });
            }
            else{
              ShowToast(
                  msg:'${state.model.message}',
                  states: ToastStates.ERROR
              );
            }
          }
        },
        builder: (BuildContext context, Object? state) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Form(
                    key: fomKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'REGISTER',
                          style: Theme.of(context)
                              .textTheme
                              .headline4!
                              .copyWith(color: Colors.red),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text('Register now to browse our hot offers',
                            style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.black
                            ),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        coloredTextFiled(
                            MyController: nameController,
                            myPrefixIcon: Icons.person,
                            validation: (value) {
                              if (value.isEmpty) {
                                return 'Name must not be empty';
                              }
                              return null;
                            },
                            labelTxt: 'Name',
                            radius: BorderRadius.circular(0),
                            txtType: TextInputType.name,
                            isPassword: false),
                        SizedBox(
                          height: 25,
                        ),
                        coloredTextFiled(
                          MyController: emailController,
                          myPrefixIcon: Icons.email,
                          validation: (value) {
                            if (value.isEmpty) {
                              return 'email is too short!';
                            }
                            return null;
                          },
                          labelTxt: 'Email address',
                          radius: BorderRadius.circular(0),
                          txtType: TextInputType.emailAddress,
                          isPassword: false,
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        coloredTextFiled(
                          MyController: passwordController,
                          myPrefixIcon: Icons.lock,
                          validation: (value) {
                            if (value.isEmpty) {
                              return 'password is too short!';
                            }
                            return null;
                          },
                          labelTxt: 'Password',
                          radius: BorderRadius.circular(0),
                          txtType: TextInputType.visiblePassword,
                          mySuffixIconBtn:
                              ShopRegisterCubit.get(context).IsVisible
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                          isPassword: ShopRegisterCubit.get(context).IsVisible,
                          suffixPressed: () {
                            ShopRegisterCubit.get(context).ChangeVisibility();
                          },
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        coloredTextFiled(
                          MyController: phoneController,
                          myPrefixIcon: Icons.phone_android_outlined,
                          validation: (value) {
                            if (value.isEmpty) {
                              return 'Phone is too short!';
                            }
                            return null;
                          },
                          labelTxt: 'Phone',
                          radius: BorderRadius.circular(0),
                          txtType: TextInputType.phone,
                          isPassword: false,
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        ConditionalBuilder(
                          condition: state is! ShopRegisterLoadingState,
                          builder: (context) => defaultButton(
                              fun: () {
                                if (fomKey.currentState!.validate()) {
                                  ShopRegisterCubit.get(context).UserRegister(
                                      name: '${nameController.text}',
                                      email: '${emailController.text}',
                                      password: '${passwordController.text}',
                                      phone: '${phoneController.text}');
                                }
                              },
                              color: Colors.red,
                              Txt: 'login'
                          ),
                          fallback: (context) =>
                              Center(child: CircularProgressIndicator()),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
