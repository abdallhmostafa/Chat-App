 // ignore_for_file: must_be_immutable

 import 'package:flutter/material.dart';

class CustomBottom extends StatelessWidget {
  CustomBottom({super.key, this.text,this.onPressed});
    VoidCallback? onPressed;
    String? text;
    @override
    Widget build(BuildContext context) {
      return ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            alignment: Alignment.center,
            minimumSize:const Size(double.infinity, 50),
            enableFeedback: true,

          ),
          child: Text(text!,style:const TextStyle(fontSize: 22.0,fontWeight: FontWeight.w600),));
    }
  }
