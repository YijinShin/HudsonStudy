import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; 
import 'package:firebase_auth/firebase_auth.dart';

//widget
import 'package:hudsonstudy/widget/signup_widget.dart';
import 'package:hudsonstudy/widget/home_widget.dart';

//provider
import 'package:hudsonstudy/provider/applicationstate_provider.dart';

class HomePage extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(), //state가 바뀌는지 모니터링. 만약 로그아웃또는 로그인을 하면 googleUser return함. 
          builder: (context, snapshot){ //위에서 리턴한 googleUser이 snapshot에 들어감. 
            final provider = Provider.of<ApplicationStateProvider>(context, listen:false);
            //로그인 flow중이면 로딩 indicator return
            if(provider.isSigningIn){
              return buildLoading();
            }
            //로그인을 완료했는지 확인. 끝난거면 snapshot data가 있을것. 그럼 home widget으로 넘어감.  
            else if(snapshot.hasData){
              return HomeWidget();
            }
            //로그인 flow에 들어가지 않았다면. 즉, 아직 로그인을 해야하는 상황이면 signupwidget return 
            else{
              return SignUpWidget(); 
            }
          },
        ),
      );
  }
  Widget buildLoading() => Center(child: CircularProgressIndicator());
}