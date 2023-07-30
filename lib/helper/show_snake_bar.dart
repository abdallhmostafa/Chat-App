
import 'package:flutter/material.dart';

void customSnakeBar(BuildContext context,String message,{Color color=Colors.red}){
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(

    backgroundColor:color,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(15.0), topLeft: Radius.circular(15.0))),
    animation: kAlwaysDismissedAnimation,
    padding: const EdgeInsets.only(bottom: 4.0),
    content: Text(
      message,
      textAlign: TextAlign.center,
      style: const TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.w600,
          fontFamily: 'YsabeauInfant'),
    ),
  ));


}
