import 'dart:io';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async'; //StreamSubscription 을 사용하기 위해 

//model
import 'package:hudsonstudy/model/study.dart';
import 'package:hudsonstudy/model/user.dart';

enum ApplicationLoginState {
  loggedOut,
  emailAddress,
  register,
  password,
  loggedIn,
}


class ApplicationStateProvider extends ChangeNotifier{
  
  //-------------------- initialize --------------------
  //생성자.
  ApplicationStateProvider(){
    init(); //초기에는 false로 초기화
  }

   Future<void> init() async {
      _isSigningIn = false;
      FirebaseAuth.instance.userChanges().listen((user) {
          //로그인이 되어있는 상태 
          if(user != null){
            _loginState = ApplicationLoginState.loggedIn; 
            //if this is first loggin 
              
              //check this is first loggin
              addUserToAppUser(); //add user in appUser colleciton
            //read study collection
            _studySubscription = 
              FirebaseFirestore.instance
                .collection('study')
                .snapshots()
                .listen((snapshot) { 
                  _study = [];
                  snapshot.docs.forEach((document) { 
                    _study.add(
                      Study(
                        name: document.data()['name'],
                        category: document.data()['category'],
                        maxMemNumber: document.data()['maxMemNumber'],
                        currentMemNumber: document.data()['currentMemNumber'],
                        when: document.data()['when'],
                        introduction: document.data()['introduction'],
                        rule: document.data()['rule'],
                        status: document.data()['status'],
                        isPrivite: document.data()['isPrivite'],
                        password: document.data()['password'],
                      ),
                    );
                  });
                }); 
            //read user collection
            _appUserSubscription = 
              FirebaseFirestore.instance
                .collection('appUser')
                .snapshots()
                .listen((snapshot) { 
                  _appUser = [];
                  snapshot.docs.forEach((document) { 
                    _appUser.add(
                      AppUser(
                        userId: document.data()['userId'],
                        firstName: document.data()['firstName'],
                        sureName: document.data()['sureName'],
                        major: document.data()['major'],
                        contect: document.data()['contect'],
                      ),
                    );
                  });
                }); 
            notifyListeners();              
          }
          //로그인이 안되어있는 상태 
          else{
            _loginState = ApplicationLoginState.loggedOut; 
            _study = [];
            _studySubscription?.cancel();
            _appUser = [];
            _appUserSubscription?.cancel();
            notifyListeners();
          }
        });
   }

  //-------------------- cloud storage --------------------
  //study collection
  StreamSubscription<QuerySnapshot> _studySubscription; 
  List<Study> _study = [];
  List<Study> get study => _study;
  //appuser collection 
  StreamSubscription<QuerySnapshot> _appUserSubscription; 
  List<AppUser> _appUser = [];
  List<AppUser> get appUser => _appUser;
  

  //checking first sign up & add user to appUser collection
  Future<DocumentReference> addUserToAppUser ()async{
    if (_loginState != ApplicationLoginState.loggedIn) {
      throw Exception('Must be logged in');
    }
    bool firstSignUp = false;
    final ref = FirebaseFirestore.instance.collection('appUser');
    String currentUserEmail = FirebaseAuth.instance.currentUser.email;
    //checking first sign up
    await ref.doc('$currentUserEmail').get().then((document){
      if (document.exists) firstSignUp = true;
      else firstSignUp = false;
    });
    //add user in appUser
    if(!firstSignUp){
      ref.doc('$currentUserEmail').set({
        'userId':currentUserEmail,
        'firstName': '----',
        'sureName' : FirebaseAuth.instance.currentUser.displayName,
        'major' : '----',
        'contect' : currentUserEmail,      
      });
    }
  }

  Future<DocumentReference> addStudyToStudy (NewStudy newStudy)async{
    if (_loginState != ApplicationLoginState.loggedIn) {
      throw Exception('Must be logged in');
    }
    final appUserRef = FirebaseFirestore.instance.collection('appUser');
    final studyRef = FirebaseFirestore.instance.collection('study');
    
    //study의 matser 정보 얻기 
    String currentUserEmail = FirebaseAuth.instance.currentUser.email;
    String firstName, sureName, major, contect;
    await appUserRef.doc('$currentUserEmail').get().then((document){
      firstName = document.data()['firstName'];
      sureName = document.data()['sureName'];
      major = document.data()['major'];
      contect = document.data()['contect'];
    });
    //study colleciton에 study 추가 
    studyRef.doc('${newStudy.name}').set({
      'name' : newStudy.name,
      'category' : newStudy.category,
      'maxMemNumber' : newStudy.maxMemNumber,
      'currentMemNumber' : 0,
      'when' : newStudy.when,
      'introduction' : newStudy.introduction,
      'rule' : newStudy.rule,
      'status' : '모집중',
      'isPrivite' : newStudy.isPrivite,
      'password' : newStudy.password,
    });
    studyRef.doc('${newStudy.name}').collection('member').doc('${currentUserEmail}').set({
      'firstName': firstName,
      'sureName': sureName,
      'contect': contect,
      'master': true
    });
    //appUser > mystudy subcollection에 Study 추가 
    appUserRef.doc('${currentUserEmail}').collection('myStudy').doc('${newStudy.name}').set({
      'name' : newStudy.name,
      'category' : newStudy.category,
      'maxMemNumber' : newStudy.maxMemNumber,
      'currentMemNumber' : 0,
      'status' : '모집중',
      'master' : true, 
    });
  }


  
  //-------------------- authentication --------------------
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