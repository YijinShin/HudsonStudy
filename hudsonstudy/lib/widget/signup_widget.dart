import 'package:flutter/material.dart';

import 'package:hudsonstudy/widget/signup_button_widget.dart';

class SignUpWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Stack(
        children: [
          Container(
              width: MediaQuery.of(context).size.width ,
              child: Image.asset(
              'assets/background2.png',
              fit:BoxFit.cover,
            ),
          ),
          Container(
            alignment: Alignment.center,
            child: GoogleSignupButtonWidget()
          ),
        ],
      
      ),
    );
  }
}