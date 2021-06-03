import 'package:flutter/material.dart';

//page
import 'package:hudsonstudy/page/home_page.dart';
//model
import 'package:hudsonstudy/model/study.dart';

class CreateStudyPage2 extends StatefulWidget {

  // CreateStudyPage1에서 study model 받아오기 (여기서 add해야해서)
   CreateStudyPage2(
    {@required this.newStudy,
     @required this.addStudyToStudy,
    });
    NewStudy newStudy;
    final Future<void> Function(NewStudy newStudy) addStudyToStudy;
  
  @override
  _CreateStudyPage2State createState() => _CreateStudyPage2State();
}

class _CreateStudyPage2State extends State<CreateStudyPage2> {

  final _studyRuleController = TextEditingController();
  final _whenController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>(debugLabel: '_CreateStudyPage2State');

  bool isSwitched = false;

  void _createDialog() { 
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          title: Center(
            child: Text(
              "잠깐!",
              //style: TextStyle(color: Colors.orange[600]),
            )
          ),
          content: Text("스터디를 만드시겠습니까?"),
          actions: <Widget>[ 
            FlatButton(
              color: Colors.orange[600],
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
              child: Text(
                "아니오",
                style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w700),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            FlatButton(
              color: Colors.orange[600],
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
              child: new Text(
                "확인",
                style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w700),
              ),
              onPressed: () async{    
                if (_formKey.currentState.validate()) {
                  //save data to widget.newStudy
                  widget.newStudy.rule = _studyRuleController.text;
                  widget.newStudy.when = _whenController.text;
                  widget.newStudy.password = _passwordController.text;
                  //call adding function 
                  await widget.addStudyToStudy(widget.newStudy);
                  //controller clear
                  _studyRuleController.clear();
                  _whenController.clear();
                  _passwordController.clear();
                } 
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                );
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //resizeToAvoidBottomInset : false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      extendBodyBehindAppBar: true,
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(color: Colors.grey[300]),
            child: Stack(
              alignment: Alignment.bottomRight,
              children: <Widget> [
                Image.asset('assets/studyDefaultImage.png',fit: BoxFit.fill),
                Image.asset('assets/gradation1.png',fit: BoxFit.fill),
                IconButton(
                  color: Colors.white,
                  icon: Icon(Icons.photo_camera),
                  onPressed: (){
                    print('image picker');
                  },
                )
              ],
            ),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.topRight,
              width:  MediaQuery.of(context).size.width,
              height:  MediaQuery.of(context).size.height*0.65,
              child: ListView(
                children: [
                  Container(
                    padding: EdgeInsets.fromLTRB(50, 0,0,0),
                    child: Text(
                      'Study Rules',
                      style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(30, 0,30,0),
                    child: TextField(
                      style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.w300),
                      controller: _studyRuleController,
                      decoration: InputDecoration(
                        fillColor: Colors.transparent,
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.circular(25.7),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.circular(25.7),
                        ),
                        filled: true, 
                      ),
                    ),
                  ),
                  SizedBox(height: 20,),
                  Container(
                    padding: EdgeInsets.fromLTRB(50, 0,0,0),
                    child: Text(
                      'When',
                      style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(30, 0,30,0),
                    child: TextField(
                      style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.w300),
                      controller: _whenController,
                      decoration: InputDecoration(
                        fillColor: Colors.transparent,
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.circular(25.7),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.circular(25.7),
                        ),
                        filled: true, 
                      ),
                    ),
                  ),
                  SizedBox(height: 20,),
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.fromLTRB(50, 0,0,0),
                        child: Text(
                          'Privite',
                          style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20),
                        ),
                      ),
                      Switch(
                        value: isSwitched,
                        onChanged: (value){
                          setState(() {
                            isSwitched = value;
                            if(isSwitched) widget.newStudy.isPrivite = true;
                            else  widget.newStudy.isPrivite = false;
                          });
                        },
                        inactiveThumbColor: Colors.grey,
                        inactiveTrackColor: Colors.black,
                        activeTrackColor: Colors.orangeAccent,
                        activeColor: Colors.white,
                      ),
                    ],
                  ),
                  SizedBox(height: 20,),
                  Container(
                    padding: EdgeInsets.fromLTRB(50, 0,0,0),
                    child: Text(
                      'Password',
                      style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(30, 0,30,0),
                    child: TextField(
                      style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.w300),
                      controller: _passwordController,
                      decoration: InputDecoration(
                        fillColor: Colors.transparent,
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.circular(25.7),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.circular(25.7),
                        ),
                        filled: true, 
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 50, 50, 30),
                    alignment: Alignment.bottomRight,
                    child: Form(
                      key: _formKey,
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
                        color: Colors.black,
                        elevation:4.0,
                        child: Text('Create!',style: TextStyle(color: Colors.white),),
                        onPressed: () async{ 
                          _createDialog();
                        },
                      ),
                    ),
                  )
                ]
              ),
            ),
          ),
        ],
      ),
    );
  }
}
