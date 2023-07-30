import 'package:chat_app/cubit/auth_cubit/auth_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit(super.initialState);

  Future<void> userLogin(
      {required String email, required String password}) async {
    emit(LoginLoadingState());
    try {
      UserCredential user = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      emit(LoginSuccessState());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        emit(LoginFailureState(erorrMessage: 'No user found for that email.'));
      } else if (e.code == 'wrong-password') {
        emit(LoginFailureState(
            erorrMessage: "Wrong password provided for that user."));
      } else if (e.code == 'email-already-in-use') {
        emit(LoginFailureState(
            erorrMessage: "The Email Address is Already Existed."));
      } else if (e.code == 'the-email-address-is-badly-formatted') {
        emit(LoginFailureState(
            erorrMessage: "The email address is badly formatted"));
      } else {
        emit(LoginFailureState(
            erorrMessage: "There Was an Error"));
      }
    } catch (e) {
      emit(LoginFailureState(erorrMessage: "There Was an Error"));
    }
  }


  Future<void> userSingIn({required String email, required String password}) async {
    emit(SignInLoadingState());
    try {
      UserCredential user = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      emit(SignInSuccessState());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        emit(SignInFailureState(errorMessage: 'User Not founded!'));
      } else if (e.code == 'wrong-password') {
        emit(SignInFailureState(errorMessage: "Wrong Password!"));
      } else if (e.code == 'email-already-in-use') {
        emit(SignInFailureState(
            errorMessage: "The Email Address is Already Existed."));
      } else {
        emit(SignInFailureState(errorMessage: "There are an Error!"));
      }
    } on Exception catch (e) {
      emit(SignInFailureState(errorMessage: "There are an Error!"));
    }
  }
}