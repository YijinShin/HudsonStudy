import 'package:flutter/material.dart';
import 'package:hudsonstudy/page/start_page.dart';
import 'package:provider/provider.dart';

import 'package:hudsonstudy/provider/applicationstate_provider.dart';



class HomeWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Center(
        child: FlatButton(
          onPressed: (){
            final provider = Provider.of<ApplicationStateProvider>(context, listen:false);
            provider.signOut();
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => StartPage()),
            );
          },
          child: Text('loggout'),  
        ),
      ),
    );
  }
}