import 'package:flutter/material.dart';

class StartPage extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      body:Stack(
        children: [
          Container(
              width: MediaQuery.of(context).size.width ,
              child: Image.asset(
              'assets/background4.jpg',
              fit:BoxFit.cover,
            ),
          ),
          Container(
              width: MediaQuery.of(context).size.width ,
              child: Image.asset(
              'assets/title.png',
              fit:BoxFit.cover,
            ),
          ),
          Container(
            alignment: Alignment.bottomCenter,
            child: AspectRatio(
              aspectRatio: 18/5,
              child: Container(
                decoration: BoxDecoration(
                    boxShadow: [ //riasedbutton은 그림자 위치 변경이 힘든것 같다.
                      BoxShadow(
                        offset: Offset(2,0),
                        color: Colors.black,
                        blurRadius: 100.0,
                      ),
                    ]
                ),
                child: FlatButton(
                  minWidth: MediaQuery.of(context).size.width ,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
                  color: Colors.black,
                  onPressed:(){
                    Navigator.pop(context);
                  },
                  child: Text(
                    'start study',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25.0,
                      fontWeight: FontWeight.w200,
                      letterSpacing: 1.5,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}