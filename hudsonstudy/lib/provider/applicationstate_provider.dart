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
import 'package:hudsonstudy/model/application.dart';

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
                        master: document.data()['master'],
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
            //read application collection
            _applicationSubscription = 
              FirebaseFirestore.instance
                .collection('application')
                .snapshots()
                .listen((snapshot) { 
                  _application = [];
                  snapshot.docs.forEach((document) { 
                    _application.add(
                      Application(
                        studyName: document.data()['studyName'],
                        applicant : document.data()['applicant'], 
                        master : document.data()['master'], 
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
  //application collection 
  StreamSubscription<QuerySnapshot> _applicationSubscription; 
  List<Application> _application = [];
  List<Application> get application => _application;
  

  //Add User
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
        'firstName': ' ',
        'sureName' : FirebaseAuth.instance.currentUser.displayName,
        'major' : 'None',
        'contect' : currentUserEmail,      
      });
    }
  }

  //Add Study
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
      'currentMemNumber' : 1, //Master 한명으로 시작하니까 1부터 시작
      'when' : newStudy.when,
      'introduction' : newStudy.introduction,
      'rule' : newStudy.rule,
      'status' : '모집중',
      'isPrivite' : newStudy.isPrivite,
      'password' : newStudy.password,
      'master' : currentUserEmail,
    });
    studyRef.doc('${newStudy.name}').collection('member').doc('${currentUserEmail}').set({
      'firstName': firstName,
      'sureName': sureName,
      'major': major,
      'contect': contect,
      'master': true,
      'userId' : currentUserEmail,
    });
    //appUser > mystudy subcollection에 Study 추가 
    appUserRef.doc('${currentUserEmail}').collection('myStudy').doc('${newStudy.name}').set({
      'name' : newStudy.name,
      'category' : newStudy.category,
      'master' : true, 
    });
  }

  //add application 
  Future<DocumentReference> addApplicationToApplication (String studyName)async{
    if (_loginState != ApplicationLoginState.loggedIn) {
        throw Exception('Must be logged in');
    }
    final applicationRef = FirebaseFirestore.instance.collection('application');
    final studyRef = FirebaseFirestore.instance.collection('study');
    String currentUserEmail = FirebaseAuth.instance.currentUser.email;
    String master;
    //get study master id 
    await studyRef.doc('$studyName').get().then((document) => master = document['master']);
    //add application to collection 
    applicationRef.add({
      'studyName' : studyName,
      'applicant' : currentUserEmail,
      'master' : master,
    });
  }

  //add application alarm
  Future<DocumentReference> addApplicationToAlarm (String studyName)async{
    if (_loginState != ApplicationLoginState.loggedIn) {
        throw Exception('Must be logged in');
    }
    final studyRef = FirebaseFirestore.instance.collection('study');
    //get current user id (신청자)
    String currentUserEmail = FirebaseAuth.instance.currentUser.email;
    //get study master id (마스터 )
    String master;
    await studyRef.doc('$studyName').get().then((document) => master = document['master']);
    final applicantUserAlarmRef = FirebaseFirestore.instance.collection('appUser').doc('$currentUserEmail').collection('alarm');
    final masterUserAlarmRef = FirebaseFirestore.instance.collection('appUser').doc('$master').collection('alarm');
    //add apply alarm to 신청자 
    applicantUserAlarmRef.add({
      'type' : 'apply',
      'studyName' : studyName,
      'applicant' : currentUserEmail,
      'master' : master,
    });
    //add alarm to 마스터  
    masterUserAlarmRef.add({
      'type' : 'application',
      'studyName' : studyName,
      'applicant' : currentUserEmail,
      'master' : master,
    });
  }

  //if master accept application) delete application + add accept alarm 
  Future<DocumentReference> updateAcceptAlarm (String userId, String studyName)async{
    final ref = FirebaseFirestore.instance.collection('application');
    final studyRef = FirebaseFirestore.instance.collection('study');
    String currentUserEmail = FirebaseAuth.instance.currentUser.email;
    final applicantUserAlarmRef = FirebaseFirestore.instance.collection('appUser').doc('$userId').collection('alarm');
    final masterUserAlarmRef = FirebaseFirestore.instance.collection('appUser').doc('$currentUserEmail').collection('alarm');

    //delete applicaiton alarm from master.alarm
    await masterUserAlarmRef.where('studyName', isEqualTo: '$studyName')
      .where('applicant', isEqualTo: '$userId').get().then((snapshot){
        for(DocumentSnapshot document in snapshot.docs){
          document.reference.delete();
        }
    });
    //add accept alarm to applicant
    applicantUserAlarmRef.add({
      'type' : 'accept',
      'studyName' : studyName,
      'applicant' : currentUserEmail,
      'master' : currentUserEmail,
    }); 
  }
  
  //if master accept application) delete application + add accept alarm 
  Future<DocumentReference> updateRejectAlarm (String userId, String studyName)async{
    final ref = FirebaseFirestore.instance.collection('application');
    String currentUserEmail = FirebaseAuth.instance.currentUser.email;
    final applicantUserAlarmRef = FirebaseFirestore.instance.collection('appUser').doc('$userId').collection('alarm');
    final masterUserAlarmRef = FirebaseFirestore.instance.collection('appUser').doc('$currentUserEmail').collection('alarm');

    //delete applicaiton alarm from master.alarm
    await masterUserAlarmRef.where('studyName', isEqualTo: '$studyName')
      .where('applicant', isEqualTo: '$userId').get().then((snapshot){
        for(DocumentSnapshot document in snapshot.docs){
          document.reference.delete();
        }
    });
    //add accept alarm to applicant
    applicantUserAlarmRef.add({
      'type' : 'reject',
      'studyName' : studyName,
      'applicant' : currentUserEmail,
      'master' : currentUserEmail,
    }); 
  }
  
  Future<DocumentReference> updateQuery (String query)async{
    final queryRef = FirebaseFirestore.instance.collection('query'); 
    bool isDoc = true;
    await queryRef.doc('$query').get().then((document){
      if (document.exists) isDoc = true;
      else isDoc = false;
    });
    //add user in appUser
    if(!isDoc){
      queryRef.doc('query').set({
        'query' : query,      
      });
    }
    else{
      await queryRef.doc('$query').update({
        'query' : query
      });
    }

  }

  //add study to myStudy in appUser
  Future<DocumentReference> addStudyToMyStudy (String userId, String studyName)async{
    final userRef = FirebaseFirestore.instance.collection('appUser'); 
    final studyRef = FirebaseFirestore.instance.collection('study'); 
    String category, status;
    int currentMemNumber, maxMemNumber;
    await studyRef.doc('$studyName').get().then((document){
      category = document.data()['category'];
      status = document.data()['status'];
      currentMemNumber = document.data()['currentMemNumber'];
      maxMemNumber = document.data()['maxMemNumber'];
    });
    await userRef.doc('$userId').collection('myStudy').doc('$studyName').set({
      'category' : category,
      'master' : false,
      'name': studyName,
    });
  }


  //add member to member in study
  Future<DocumentReference> addMemberToMember (String userId, String studyName)async{
    print('in user data');
    final userRef = FirebaseFirestore.instance.collection('appUser'); 
    final studyRef = FirebaseFirestore.instance.collection('study'); 
     int currentMemNumber,maxMemNumber;
      await studyRef.doc('$studyName').get().then((document){
        currentMemNumber = document.data()['currentMemNumber'];
        maxMemNumber = document.data()['maxMemNumber'];
      });
    //study currentNumber 갱신
      await studyRef.doc('$studyName').update({
        'currentMemNumber' : currentMemNumber + 1
      });
    //study state 갱신(maxmam == current mem인 경우만 해당)
      if(currentMemNumber+1 == maxMemNumber){
        await studyRef.doc('$studyName').update({
          'status' : '모집완료'
        });
      }
    //study mem에 mem 추가 
      String contect, firstName, sureName, major;
      print('in user data');
      await userRef.doc('$userId').get().then((document){
        contect = document.data()['contect'];
        firstName = document.data()['firstName'];
        sureName = document.data()['sureName'];
        major = document.data()['major'];
        userId = document.data()['userId'];
      });
      await studyRef.doc('$studyName').collection('member').doc('$userId').set({
        'contect' : contect,
        'firstName': firstName,
        'sureName' : sureName,
        'major': major,
        'master': false,
        'userId' : userId,
      });
  }

  //delete data in application collection
  Future<DocumentReference> deleteApplication (String userId, String studyName)async{
    final ref = FirebaseFirestore.instance.collection('application');

    await ref.where('studyName', isEqualTo: '$studyName')
      .where('applicant', isEqualTo: '$userId').get().then((snapshot){
        for(DocumentSnapshot document in snapshot.docs){
          document.reference.delete();
        }
      });
  }

  //delete study member 
  Future<DocumentReference> deleteMember (String studyName, String memberId) async{
    final studyRef = FirebaseFirestore.instance.collection('study');
    final memberRef = studyRef.doc('${studyName}').collection('member');
    final myStudyRef = FirebaseFirestore.instance.collection('appUser').doc('${memberId}').collection('myStudy');
    
    int currentMemNumber,maxMemNumber;
      await studyRef.doc('$studyName').get().then((document){
        currentMemNumber = document.data()['currentMemNumber'];
        maxMemNumber = document.data()['maxMemNumber'];
    });

    //study > member에서 member 지우기 
    await memberRef.where('userId', isEqualTo: '$memberId').get().then((snapshot){
      for(DocumentSnapshot document in snapshot.docs){
          document.reference.delete();
        }
    });
    //study currentMemNumber 수정
    await studyRef.doc('$studyName').update({
        'currentMemNumber' : currentMemNumber - 1
    });
    //study status 수정
    if(currentMemNumber-1 < maxMemNumber){
        await studyRef.doc('$studyName').update({
          'status' : '모집중'
        });
    }
    //appUser > myStudy에서 study지우기 
    await myStudyRef.where('name', isEqualTo: '$studyName').get().then((snapshot){
      for(DocumentSnapshot document in snapshot.docs){
          document.reference.delete();
        }
    });
  }

  Future<DocumentReference> deleteStudy (String studyName) async{
    
    final studyRef = FirebaseFirestore.instance.collection('study');
    final memberRef = studyRef.doc('$studyName').collection('member');
    final appUserRef = FirebaseFirestore.instance.collection('appUser');
    final myStudyRef = FirebaseFirestore.instance.collectionGroup('myStudy');

    //member의 appUser > myStudy에서 스터디 삭제
    await myStudyRef.where('name', isEqualTo: '$studyName').get().then((snapshot){
      for(DocumentSnapshot document in snapshot.docs){
          document.reference.delete();
        }
    });
    //study document의 member collection 문서 삭제
    await memberRef.get().then((snapshot){
       for(DocumentSnapshot document in snapshot.docs){
          document.reference.delete();
        }
    });
    //study collection에서 study document 삭제
    await studyRef.doc('$studyName').delete();
  }


  //edit appUser Info 
  Future<dynamic> updateAppUser(String firstName, String sureName, String major, String contect)async{
    if (_loginState != ApplicationLoginState.loggedIn) {
      throw Exception('Must be logged in');
    }
    print('check:$firstName $sureName, $major, $contect}');
    String currentUserEmail = FirebaseAuth.instance.currentUser.email;
    final appUserRef = FirebaseFirestore.instance.collection('appUser');
    final memberRef = FirebaseFirestore.instance.collectionGroup('member')
      .where('userId', isEqualTo: currentUserEmail); //study의 subcollection (복합색인)
    //final memberRef2 = FirebaseFirestore.instance.collectionGroup('member');
    //edit appUser 
    appUserRef.doc('$currentUserEmail').update({
      'firstName' : firstName,
      'sureName' : sureName,
      'contect' : contect,
      'major' : major,
    });
    memberRef.get().then((value){
      value.docs.forEach((element) { print('member : ${element.data()}');});
    });
    //edit member
    memberRef.get().then((snapshot){
      snapshot.docs.forEach((doc) { 
        doc.reference.update({
          'firstName' : firstName,
          'sureName' : sureName,
          'contect' : contect,
          'major' : major,
        });
      });
    });
   }


  //edit study Info 
  Future<dynamic> updateStudy(String category, String introduction, bool isPrivite, int maxMemNumber
    , String studyName, String password, String rule, String status, String when)async{
    if (_loginState != ApplicationLoginState.loggedIn) {
      throw Exception('Must be logged in');
    }
    String currentUserEmail = FirebaseAuth.instance.currentUser.email;
    final studyrRef = FirebaseFirestore.instance.collection('study');
    final memberRef = FirebaseFirestore.instance.collectionGroup('myStudy')
      .where('name', isEqualTo: studyName); //study의 subcollection (복합색인)
    //edit study 
    studyrRef.doc('$studyName').update({
      'category' : category,
      'introduction' : introduction,
      'isPrivite' : isPrivite,
      'maxMemNumber' : maxMemNumber,
      'password':password,
      'rule' : rule,
      'status': status,
      'when': when,
    });
    memberRef.get().then((value){
      value.docs.forEach((element) { print('member : ${element.data()}');});
    });
    //edit myStudy
    memberRef.get().then((snapshot){
      snapshot.docs.forEach((doc) { 
        doc.reference.update({
          'category' : category,
        });
      });
    });
   }

  //Checking Master User
  Future<String> checkMasterUser(String studyName) async {      
    final ref = FirebaseFirestore.instance.collection('appUser');
    String currentUserEmail = FirebaseAuth.instance.currentUser.email;
    String result;
    await ref.doc('$currentUserEmail').collection('myStudy')
      .where('name', isEqualTo: '$studyName')
      .get().then((QuerySnapshot snapshot){
        snapshot.docs.forEach((document) { 
          if(document['master']) {
            result= 'true';
          }
          else result= 'false';
        });
      });
    return result;
  }

  Future<String> checkMyStudy(String studyName) async{
    final ref = FirebaseFirestore.instance.collection('appUser');
    String currentUserEmail = FirebaseAuth.instance.currentUser.email;
    String result;

    await ref.doc('$currentUserEmail').collection('myStudy')
      .where('name', isEqualTo: '$studyName')
      .get().then((QuerySnapshot snapshot){
        snapshot.docs.forEach((document) { 
          if(document.exists) {
            print('$studyName : in my study');
            result= 'true';
          }
        });
      });
    if (result != 'true') result = 'false';
    return result;
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