import 'package:chat_app/models/message_model.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class CustomChatBubble extends StatelessWidget {
   CustomChatBubble({
    super.key,
    this.color = kPrimaryColor,
    this.radiusOfBottomRight = 0,
    this.radiusOfBottomLeft = 0,
    required this.theMessage,
      this.alignment= Alignment.centerLeft,
  });
   MessageModel theMessage;
 final Color color;
  final double radiusOfBottomRight;
  final  double radiusOfBottomLeft;
  final AlignmentGeometry alignment ;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment:alignment,
      child: Container(
          margin: const EdgeInsets.only(bottom: 5.0),
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
          decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(radiusOfBottomRight),
                  bottomLeft: Radius.circular(radiusOfBottomLeft),
                  topLeft: const Radius.circular(30.0),
                  topRight: const Radius.circular(30.0))),
          child:  Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                theMessage.message,
                style: const TextStyle(fontSize: 20.0, color: white),
              ),
              Text(
               '${theMessage.date.toDate().hour.toString().padLeft(2,'0')}:${ theMessage.date.toDate().minute.toString().padLeft(2,'0')}',
                style: const TextStyle(fontSize: 11.0, color: white,),textAlign:TextAlign.left ,
              ),
            ],
          )),
    );
  }
}
