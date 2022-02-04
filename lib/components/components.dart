// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_string_interpolations, non_constant_identifier_names, avoid_types_as_parameter_names, no_duplicate_case_values, constant_identifier_names
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app_v2/modules/login%20screen.dart';
import 'package:shop_app_v2/network/local/cash_helper.dart';


Widget defaultTextFiled({
  required TextEditingController MyController,
  required IconData myPrefixIcon,
  IconData? mySuffixIconBtn,
  IconData? mySuffixIcon,
  required final validation,
  required String labelTxt,
  required BorderRadius radius,
  required TextInputType txtType,
  final ontap,
  final  String? suftxt,
  final onChange,
  bool isPassword = true,
  final suffixPressed



}) =>
    TextFormField(
      obscureText: isPassword,
      onChanged: onChange,
      keyboardType: txtType,
      onTap: ontap,
      validator: validation,
      controller: MyController,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: radius,
        ),
        prefixIcon: Icon(
          myPrefixIcon,
          color: Colors.black,
        ),
        suffixIcon: IconButton(onPressed: suffixPressed ,
          icon:Icon(mySuffixIconBtn),

        ),
        suffixText: suftxt,
        labelText: labelTxt,
        labelStyle: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
    );

Widget defaultButton({
  required final fun,
  String? Txt,
  Color? color,



})=> MaterialButton(
  disabledColor: Colors.grey,
  minWidth: double.infinity,
  padding: EdgeInsets.all(10.0),
  height: 45,
  onPressed: fun,
  color: color,
  child: Text(Txt!.toUpperCase(),
  style: TextStyle(
    fontWeight: FontWeight.bold,
  ),
  ),
  textColor: Colors.white,
);



void navigateTo(context, widget) => Navigator.push(
  context,
  MaterialPageRoute(builder: (context) => widget),
);

void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (context) => widget),
        (Route)=>false
);

Widget myDivider() => Container(
  height: 1,
);


void ShowToast({
  required String msg,
  required ToastStates states
})=>Fluttertoast.showToast(

    msg: msg,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 5,
    backgroundColor: ChooseToastState(states),
    textColor: Colors.white,
    fontSize: 16.0
);

enum ToastStates {SUCCESS ,ERROR , WARNING}

Color? ChooseToastState(ToastStates states){

  Color color;

  switch(states){
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;

    case ToastStates.ERROR:
      color = Colors.red;
      break;

    case ToastStates.WARNING:
      color = Colors.deepOrangeAccent;
      break;
  }
  return color;
}

void SignOut(context){
  CashHelper.removeData(key: 'token');
  navigateAndFinish(context, Login_Screen());
}

Widget coloredTextFiled({
  required TextEditingController MyController,
  required IconData myPrefixIcon,
  IconData? mySuffixIconBtn,
  IconData? mySuffixIcon,
  required final validation,
  required String labelTxt,
  required BorderRadius radius,
  required TextInputType txtType,
  final ontap,
  final  String? suftxt,
  final onChange,
  bool isPassword = true,
  final suffixPressed,
  bool? isEnabled,



}) =>
    TextFormField(
      enabled: isEnabled,
      obscureText: isPassword,
      onChanged: onChange,
      keyboardType: txtType,
      onTap: ontap,
      validator: validation,
      controller: MyController,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: radius,
        ),
        prefixIcon: Icon(
          myPrefixIcon,
          color: Colors.red[600],
        ),
        suffixIcon: IconButton(onPressed: suffixPressed ,
          icon:Icon(mySuffixIconBtn),

        ),
        suffixText: suftxt,
        labelText: labelTxt,
        labelStyle: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
    );

