import 'package:cloud_firestore/cloud_firestore.dart';

import '../constants.dart';

class MessageModel{
  final String message;
  final String id;
  final Timestamp date;


  MessageModel(this.message,this.id,this.date);
  factory MessageModel.formJson(dynamic data){
    return MessageModel(data[kMessage],data[kId],data[kSendAt]);
  }
}