import 'package:chat_app/constants.dart';
import 'package:chat_app/cubit/chat_cubit/chat_state.dart';
import 'package:chat_app/models/message_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class ChatCubit extends Cubit<ChatState> {
  ChatCubit(super.initialState);

  final ScrollController listController = ScrollController();
  final TextEditingController textFiledController = TextEditingController();

  final CollectionReference messages =
      FirebaseFirestore.instance.collection(kMessageCollection);

  void sendMessage({required String message, required String email}) {
    try {
      messages.add({
        'id': email,
        kMessage: message,
        kSendAt: DateTime.now(),
      });
    } catch (e) {
      print("The Error in Sending Message is : $e");
    }
  }

  void reviveMessage() {
    messages.orderBy(kSendAt, descending: true).snapshots().listen((event) {
      List<MessageModel> listOfMessages = [];
      for (var doc in event.docs) {
        listOfMessages.add(MessageModel.formJson(doc));
      }
      emit(ChatSuccessState(listOfMessages: listOfMessages));

    });
  }

  void scrollToLastMessage() {
    listController.animateTo(listController.position.minScrollExtent,
        duration: const Duration(milliseconds: 1000),
        curve: Curves.fastOutSlowIn);
  }
}
