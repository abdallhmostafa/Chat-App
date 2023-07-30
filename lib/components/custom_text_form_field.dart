 import 'package:flutter/material.dart';

class CustomTextFormFiled extends StatelessWidget {
  const CustomTextFormFiled({super.key, this.labelText,required this.obscureText,this.icon,this.textInputAction,this.onChange,this.textEditingController});
 final String? labelText;
  final bool obscureText;
  final TextEditingController? textEditingController;
  final Function(String)? onChange;
  final Icon? icon;
  final TextInputAction? textInputAction;
    @override
    Widget build(BuildContext context) {
      return TextFormField(
        validator: (value) {
          if(value!.isEmpty) return  "Filed IS Required!";

        },
        controller:textEditingController ,
        onChanged: onChange,
        style:const TextStyle(color: Colors.white),
        autocorrect: true,
        keyboardAppearance:Brightness.dark,
        textAlign: TextAlign.start,
        textInputAction: textInputAction,
        keyboardType: TextInputType.emailAddress,
        maxLines: 1,
        maxLength: 50,
        obscureText: obscureText,
        cursorHeight: 25.0,
        decoration: InputDecoration(
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                  color: Colors.red,
              width: 3)
          ),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                  color: Colors.white
              )
          ),
          focusedBorder:OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide:const BorderSide(
                  width: 3,
                  color: Colors.white
              )

          ) ,
          focusedErrorBorder:OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide:const BorderSide(
                  width: 3,
                  color: Colors.red
              )
          ) ,
          border: OutlineInputBorder(

              borderRadius: BorderRadius.circular(10),
              borderSide:const BorderSide(
                  color: Colors.red,
              )

          ),
          labelText: labelText,
          labelStyle:const TextStyle(fontSize: 20.0),
          contentPadding:const EdgeInsets.only(left: 20.0,bottom: 10.0),
          suffixIcon:icon ,

        ),
      );
    }
  }
