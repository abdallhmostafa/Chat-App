// ignore_for_file: use_build_context_synchronously

import 'package:chat_app/components/custom_buttom.dart';
import 'package:chat_app/cubit/auth_cubit/auth_cubit.dart';
import 'package:chat_app/cubit/auth_cubit/auth_state.dart';
import 'package:chat_app/cubit/chat_cubit/chat_cubit.dart';
import 'package:chat_app/screens/chat_screen.dart';
import 'package:chat_app/screens/sign_up_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../components/custom_text_form_field.dart';
import '../constants.dart';
import '../helper/show_snake_bar.dart';

class LoginScreen extends StatelessWidget {
  String? email, password;
  static const String id = 'Login';

  bool isLoading = false;
  GlobalKey<FormState> formKey = GlobalKey();

  LoginScreen({super.key});
  @override
  Widget build(BuildContext context) {

    return BlocConsumer<AuthenticationCubit, AuthenticationState>(
      listener: (context, state) {
        if (state is LoginLoadingState) {
          isLoading = true;
        } else if (state is LoginSuccessState) {
          BlocProvider.of<ChatCubit>(context).reviveMessage();
          customSnakeBar(context, "The Email Created Successfully.",
              color: Colors.green);
          Navigator.pushNamed(context, ChatScreen.id, arguments: email);
          isLoading = false;

        } else if (state is LoginFailureState) {
        customSnakeBar(context,state.erorrMessage);
          isLoading = false;

        }
      },
      builder:(context,state)=> ModalProgressHUD(
        dismissible: true,
        inAsyncCall: isLoading,
        child: Scaffold(
          backgroundColor: kPrimaryColor,
          body: SizedBox(
            width: double.infinity,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding:
                    const EdgeInsets.only(top: 50.0, left: 15.0, right: 15.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(kLogo, width: 100.0, fit: BoxFit.cover),
                      const Text(
                        "Chatly",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 30.0,
                            letterSpacing: 1,
                            fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(
                        height: 100,
                      ),
                      CustomTextFormFiled(
                          onChange: (data) => email = data,
                          obscureText: false,
                          labelText: "Email",
                          textInputAction: TextInputAction.next,
                          icon: const Icon(
                            Icons.email,
                            color: Colors.white,
                          )),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomTextFormFiled(
                          onChange: (data) => password = data,
                          obscureText: true,
                          labelText: "Password",
                          textInputAction: TextInputAction.done,
                          icon: const Icon(
                            Icons.lock,
                            color: Colors.white,
                          )),
                      const SizedBox(
                        height: 30,
                      ),
                      CustomBottom(
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              BlocProvider.of<AuthenticationCubit>(context).userLogin(
                                  email: email!, password: password!);
                            }
                          },
                          text: 'Sign Up'),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Already have an account?",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                                fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            excludeFromSemantics: true,
                            onTap: () {
                              Navigator.pushNamed(context, SignUpScreen.id);
                            },
                            child: const Text(
                              "Sign In ",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22.0,
                                  fontWeight: FontWeight.w600),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

 
}
