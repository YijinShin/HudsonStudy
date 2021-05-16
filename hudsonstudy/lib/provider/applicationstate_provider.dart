import 'dart:io';
import 'package:intl/intl.dart';
//import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
//import 'package:image_picker/image_picker.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async'; //StreamSubscription 을 사용하기 위해 

enum ApplicationLoginState {
  loggedOut,
  emailAddress,
  register,
  password,
  loggedIn,
}


class ApplicationStateProvider extends ChangeNotifier{

  //생성자.
  ApplicationStateProvider(){
    init(); //초기에는 false로 초기화
  }

   Future<void> init() async {
    _isSigningIn = false;
   
   }

  
  //-------------------- sign up --------------------
  ApplicationLoginState _loginState = ApplicationLoginState.loggedOut; //기본적으로는 로그아웃 상태
  ApplicationLoginState get loginState => _loginState; 

  final _googleSignIn = GoogleSignIn();             //google user
  final FirebaseAuth _auth = FirebaseAuth.instance; //anonymous user
  bool _isSigningIn; // singing 중이면 버퍼링 표시를 띄우기 위해 필요.

  //_isSigningIn 에 대한 getter
  bool get isSigningIn => _isSigningIn;
  //_isSigningIn 에 대한 setter
  set isSigningIn(bool inSignin){
    _isSigningIn = isSigningIn;
    notifyListeners();
  }

  //Google Sign in method
  Future signInWithGoogle() async {
    isSigningIn = true; //sign in flow가 시작된것이니까 true로 하기 
    //GoogleSignInAccount 여기서 user정보 뽑아 쓰면됨
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();
    //signin 실패한 경우 
    if (GoogleSignInAccount == null){
      isSigningIn = false;
      return; 
    }
    //signin 성공한 경우 
    else{
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication; //user auth 받아오기 
      //create credential with 위에서 구한 google auth object
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      await FirebaseAuth.instance.signInWithCredential(credential);
      //sign in 마치면 다시 false로 바꾸기 
      isSigningIn = false;
    }
  }

  //loggout method
  Future signOut() async {
    await _auth.signOut();
    await _googleSignIn.signOut();
    FirebaseAuth.instance.signOut();
  }

}