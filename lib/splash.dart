import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:chat_app/screens/login_screen.dart';
import 'package:flutter/material.dart';

import 'constants.dart';

class Splash extends StatelessWidget {
  const Splash({super.key});
  static String id ='Splash';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedSplashScreen(
          backgroundColor: kPrimaryColor,
          animationDuration:const Duration(milliseconds: 1500),
          duration:1400,
          splashTransition: SplashTransition.fadeTransition,
          nextScreen: LoginScreen(),
          splashIconSize:  140,
          splash:Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Image.asset(kLogo,
                  width: 100.0, fit: BoxFit.cover),
              const Text(
                "Chatly Your App To Chat",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 26.0,
                    letterSpacing: 1,
                    fontWeight: FontWeight.w600),
              ),
            ],
          )
      ),
    );
  }
}

