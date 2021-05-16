import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:hudsonstudy/provider/applicationstate_provider.dart';


class GoogleSignupButtonWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Container(
    padding: EdgeInsets.fromLTRB(80,50,80,0),
    child: RaisedButton(
      shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(5.0)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(5.0)
            ),
            width: 50,
            height: 50,
            child: Icon(FontAwesomeIcons.google,color: Colors.white),
          ),
          SizedBox(width:20),
          Text('GOOGLE'),
        ],
      ),
      textColor: Colors.white,
      color: Colors.redAccent[100],
      onPressed: (){
        print('google sign in');
        final provider = Provider.of<ApplicationStateProvider>(context, listen:false);
        provider.signInWithGoogle();
      },
    ),
  );
}
