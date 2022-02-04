// ignore_for_file: avoid_print

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const defaultColor = Colors.red;
const boardColor =  Colors.red;

dynamic token = '';
bool? onBoarding = false;

void printFullText(String text){
  final pattern = RegExp('.{1,800}');
  pattern.allMatches(text).forEach((match)=> print(match.group(0)));
}