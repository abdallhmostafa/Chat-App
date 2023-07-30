// ignore_for_file: use_build_context_synchronously

import 'package:chat_app/components/custom_buttom.dart';
import 'package:chat_app/components/custom_text_form_field.dart';
import 'package:chat_app/constants.dart';
import 'package:chat_app/cubit/auth_cubit/auth_cubit.dart';
import 'package:chat_app/cubit/auth_cubit/auth_state.dart';
import 'package:chat_app/cubit/chat_cubit/chat_cubit.dart';
import 'package:chat_app/helper/show_snake_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';


import 'chat_screen.dart';

class SignUpScreen extends StatelessWidget {
  static const String id = 'SignUp';

  bool isLoading = false;
  String? email, password;
  GlobalKey<FormState> formKey = GlobalKey();

  SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticationCubit, AuthenticationState>(
      listener: (context, state) {
        if (state is SignInLoadingState) {
          isLoading = true;
        } else if (state is SignInSuccessState) {
          BlocProvider.of<ChatCubit>(context).reviveMessage();

          customSnakeBar(context, "Sign In Successfully.", color: Colors.green);
          Navigator.pushNamed(context, ChatScreen.id, arguments: email);
          isLoading = false;
        } else if (state is SignInFailureState) {
          customSnakeBar(context, state.errorMessage);
          isLoading = false;
        }
      },
      builder: (context, state) => ModalProgressHUD(
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
                        const Text(
                          "Sing In",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 30.0,
                              letterSpacing: 1,
                              fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(
                          height: 60,
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
                          height: 18,
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
                          height: 25,
                        ),
                        CustomBottom(
                            onPressed: () async {
                              if (formKey.currentState!.validate()) {
                                BlocProvider.of<AuthenticationCubit>(context)
                                    .userSingIn(
                                        email: email!, password: password!);
                              }
                            },
                            text: 'Sign In'),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              " Don't have an account?",
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
                                Navigator.pop(context);
                              },
                              child: const Text(
                                "Sign Up",
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