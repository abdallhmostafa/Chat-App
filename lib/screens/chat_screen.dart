import 'package:chat_app/components/custom_chat_buble.dart';
import 'package:chat_app/constants.dart';
import 'package:chat_app/cubit/chat_cubit/chat_cubit.dart';
import 'package:chat_app/cubit/chat_cubit/chat_state.dart';
import 'package:chat_app/models/message_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';



class ChatScreen extends StatelessWidget {
  ChatScreen({super.key});

  static const String id = 'ChatScreen';
  late String messageText;


  List<MessageModel> listOfMessages = [];
  @override
  Widget build(BuildContext context) {
    final chatCubit= BlocProvider.of<ChatCubit>(context);

    final String email = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Chatly",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 25.0,
                  letterSpacing: 1,
                  fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              width: 5.0,
            ),
            Image.asset(kLogo, width: 40.0, fit: BoxFit.cover),
          ],
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.grey.shade300,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 10.0),
        child: Column(
          children: [
            const SizedBox(
              height: 5.0,
            ),
            Expanded(
              child: BlocConsumer<ChatCubit, ChatState>(
                listener: (context, state) {
                  if(state is  ChatSuccessState){
                    listOfMessages = state.listOfMessages;
                  }
                },
                builder: (context, state) {
                  return ListView.builder(
                    controller:chatCubit.listController,
                    reverse: true,
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemBuilder: (context, index) =>
                        listOfMessages[index].id == email
                            ? CustomChatBubble(
                                radiusOfBottomRight: 30.0,
                                theMessage: listOfMessages[index])
                            : CustomChatBubble(
                                radiusOfBottomLeft: 30.0,
                                theMessage: listOfMessages[index],
                                color: kFriendColor,
                                alignment: Alignment.centerRight,
                              ),
                    itemCount: listOfMessages.length,
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: TextField(
                  controller:chatCubit.textFiledController,
                  onChanged: (value) => messageText = value,
                  onSubmitted: (data) {
                    chatCubit.sendMessage(message: data, email: email);
                    chatCubit.textFiledController.clear();
                    chatCubit.scrollToLastMessage();
                  },
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 18.0,
                  ),
                  cursorOpacityAnimates: true,
                  enableSuggestions: true,
                  enableIMEPersonalizedLearning: true,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.send,
                  maxLines: 2,
                  minLines: 1,
                  autocorrect: true,
                  scrollPhysics: const BouncingScrollPhysics(),
                  keyboardAppearance: Brightness.dark,
                  cursorColor: kPrimaryColor,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12.0, vertical: 8.0),
                    hintText: 'Send Message...',
                    hintStyle: const TextStyle(
                      color: kPrimaryColor,
                    ),
                    suffixIcon: IconButton(
                        onPressed: () {
                          chatCubit.sendMessage(message: messageText, email: email);
                          chatCubit.textFiledController.clear();
                          chatCubit.scrollToLastMessage();
                        },
                        icon: const Icon(
                          Icons.send_rounded,
                          color: kPrimaryColor,
                          size: 30.0,
                        )),
                    enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 2.0,
                          color: kPrimaryColor,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(15.0))),
                    border: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: kPrimaryColor,
                          width: 2.0,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(15.0))),
                    focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 3.0,
                          color: kPrimaryColor,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(15.0))),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
