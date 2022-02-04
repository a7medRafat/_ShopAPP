// ignore_for_file: file_names, prefer_const_constructors, prefer_const_literals_to_create_immutables, non_constant_identifier_names, curly_braces_in_flow_control_structures, avoid_print, deprecated_member_use, unnecessary_import
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_app_v2/components/components.dart';
import 'package:shop_app_v2/constants/constants.dart';
import 'package:shop_app_v2/modules/login%20screen.dart';
import 'package:shop_app_v2/network/local/cash_helper.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingModel{
  String? image;
  String? title;
  String? body;

  OnBoardingModel({
    required this.image,
    required this.title,
    required this.body
});
}
  List<OnBoardingModel>Boarding=[
    OnBoardingModel(
        image: 'images/board_one.jpg',
        title: 'Browse For Your Favourites ',
        body: 'There are more than 1,000 brands of men and woman shoes and clothing in the catalog ',
    ),
    OnBoardingModel(
      image: 'images/board_two.jpg',
      title: 'Choose Your Item',
      body: 'Just two clicks and you can buy all the fashion or others with home delivery ',
    ),
    OnBoardingModel(
      image: 'images/board_three.jpg',
      title: 'Pay Cash Or Even Card',
      body: 'The order can be paid by credit card or cash at the time of the delivery ',
    ),
    OnBoardingModel(
      image: 'images/board_four.jpg',
      title: 'Welcome !',
      body: 'Enjoy',
    ),
  ];
  var MyPageController = PageController();
  bool isLast = false;
  bool status = true;
class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(onPressed: (){
            ToLogin();
          },
              child: Text(
                'SKIP',
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                  fontSize: 15
                ),
              )
          )
        ],
      ),
      body:Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: PageView.builder(
                onPageChanged: (index){
                  if(index == Boarding.length-1)
                    setState(() {
                      isLast = true;
                      print('isLast');
                    });
                  else
                    setState(() {
                      isLast = false;
                      print('NotLast');
                    });
                },
                itemBuilder: (context,index)=>buildBoardItem(Boarding[index]),
                controller: MyPageController,
                itemCount: Boarding.length,
                physics: BouncingScrollPhysics(),
              ),
            ),
            SizedBox(height: 70,),
           Column(
             crossAxisAlignment: CrossAxisAlignment.center,
             children: [
               SmoothPageIndicator(
                   controller: MyPageController ,
                   effect: ExpandingDotsEffect(
                     dotHeight: 10,
                     dotWidth: 10,
                     spacing: 5,
                     expansionFactor: 5,
                     activeDotColor: boardColor,
                     dotColor: Colors.grey,
                   ),
                   count: Boarding.length
               ),
               SizedBox(height: 20,),
               MaterialButton(
                 disabledColor: Colors.grey,
                 disabledTextColor: Colors.black,
                 minWidth: double.infinity,
                 height: 40.0,
                 shape: RoundedRectangleBorder(
                   borderRadius: BorderRadius.circular(20.0),
                 ),
                 onPressed: isLast ? ToLogin :null,
                 child: Text(
                   'Get Started',
                   style: TextStyle(
                     fontWeight: FontWeight.bold,
                     fontSize: 15,
                     color: Colors.white
                   ),
                 ),
                 color: Colors.red,
               ),
             ],
           ),
          ],
        ),
      ),

    );
  }

  Widget buildBoardItem(OnBoardingModel model)=>Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Expanded(
        child: Image(
          image: AssetImage('${model.image}'),
        ),
      ),
      Text('${model.title}',
        textAlign: TextAlign.center,
        style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 23,
            color: Colors.black
        ),
      ),
      SizedBox(height:10 ,),
      Text('${model.body}',
        textAlign: TextAlign.center,
        style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 13,
            color: Colors.black
        ),
      ),
    ],
  );
  void ToLogin(){
    CashHelper.saveData(key: 'onBoarding', value: true).then((value) {
      if(value)
        navigateAndFinish(context, Login_Screen());
    });
  }
}
