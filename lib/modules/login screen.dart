// ignore_for_file: file_names, prefer_const_constructors, prefer_const_literals_to_create_immutables, curly_braces_in_flow_control_structures, avoid_print
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_v2/ShopCubit/ShopApp_Cubit.dart';
import 'package:shop_app_v2/components/components.dart';
import 'package:shop_app_v2/constants/constants.dart';
import 'package:shop_app_v2/cubit/LoginCubit.dart';
import 'package:shop_app_v2/cubit/LoginStates.dart';
import 'package:shop_app_v2/modules/Home_Screen.dart';
import 'package:shop_app_v2/modules/ShopLayout.dart';
import 'package:shop_app_v2/modules/register%20screen.dart';
import 'package:shop_app_v2/network/local/cash_helper.dart';


var emailController = TextEditingController();
var passwordController = TextEditingController();
var fomKey = GlobalKey<FormState>();




class Login_Screen extends StatelessWidget {

  const Login_Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (BuildContext context)=> ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit , ShopLoginStates>(
        listener: (BuildContext context, state) {
          if(state is ShopLoginSuccessState){
            if(state.shopLoginModel.status == true){
              print(state.shopLoginModel.data!.token);
              CashHelper.saveData(key: 'token', value: state.shopLoginModel.data!.token).then((value) {
                  token = state.shopLoginModel.data!.token;
                navigateAndFinish(context, Home_Screen());
                 ShowToast(
                     msg:'${state.shopLoginModel.message}',
                     states: ToastStates.SUCCESS
                 );
              });
              ShopAppCubit.get(context).getCategoriesData();
              ShopAppCubit.get(context).getFavourites();
              ShopAppCubit.get(context).getUserData();
            }
            else{
              ShowToast(
                  msg:'${state.shopLoginModel.message}',
                  states: ToastStates.ERROR
              );
            }

            //     ShowToast(
            //         msg: '${state.shopLoginModel.message}',
            //         states: ToastStates.SUCCESS
            //     );
            // }
            // else{
            //   ShowToast(
            //       msg: '${state.shopLoginModel.message}',
            //       states: ToastStates.ERROR
            //   );
            // }
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
                        Text('LOGIN',
                          style: Theme.of(context).textTheme.headline4!.copyWith(
                              color: Colors.red
                          ),
                        ),
                        SizedBox(height: 5,),
                        Text('login now to browse our hot offers',
                            style:Theme.of(context).textTheme.headline6!.copyWith(
                                color: Colors.black54
                            )

                        ),
                        SizedBox(height: 40,),
                        defaultTextFiled(
                          MyController: emailController,
                          myPrefixIcon: Icons.email,
                          validation: (value){
                            if(value.isEmpty){
                              return 'field must not be empty';
                            }
                            return null;
                          },
                          labelTxt: 'E-mail',
                          radius: BorderRadius.circular(0),
                          txtType: TextInputType.emailAddress,
                          isPassword: false
                        ),
                        SizedBox(height: 15,),
                        defaultTextFiled(
                            MyController: passwordController,
                            myPrefixIcon: Icons.lock,
                            validation: (value){
                              if(value.isEmpty){
                                return 'password is too short!';
                              }
                              return null;
                            },
                            labelTxt: 'Password',
                            radius: BorderRadius.circular(0),
                            txtType: TextInputType.visiblePassword,
                            mySuffixIconBtn: ShopLoginCubit.get(context).IsVisible? Icons.visibility_off : Icons.visibility,
                            isPassword: ShopLoginCubit.get(context).IsVisible,
                            suffixPressed: (){
                              ShopLoginCubit.get(context).ChangeVisibility();
                            },

                        ),
                        SizedBox(height: 30,),
                        ConditionalBuilder(
                          condition: state is !ShopLoginLoadingState,
                          builder: (context)=>defaultButton(
                              fun: (){
                                if(fomKey.currentState!.validate()){
                                  ShopLoginCubit.get(context).UserLogin(
                                      email: emailController.text,
                                      password: passwordController.text
                                  );
                                }
                              },
                              color: Colors.red,
                              Txt: 'login'
                          ),
                          fallback: (context)=>Center(child: CircularProgressIndicator()),
                        ),
                        SizedBox(height: 5,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Don\'t have an account?',
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black
                              ),
                            ),
                            TextButton(
                                onPressed: (){
                                  navigateTo(
                                      context,
                                      Register_Screen());
                                },
                                child: Text(
                                    'Register Now'
                                )
                            ),
                          ],
                        )


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
