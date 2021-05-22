import 'package:flutter/material.dart';

//page
import 'package:hudsonstudy/page/home_page.dart';
//model
import 'package:hudsonstudy/model/study.dart';

class EditStudyPage extends StatefulWidget {

  // CreateStudyPage1에서 study model 받아오기 (여기서 add해야해서)
   EditStudyPage(
    {
     @required this.updateStudy,
     @required this.category,
     @required this.introduction,
     @required this.isPrivite,
     @required this.maxMemNumber,
     @required this.name,
     @required this.password,
     @required this.status,
     @required this.when,
     @required this.rules
    });
    final String category;
    final String introduction;
    final bool isPrivite;
    final int maxMemNumber;
    final String name;
    final String password;
    final String status;
    final String when;
    final String rules;
    final Future<void> Function(String category, String introduction, bool isPrivite, int maxMemNumber
    , String studyName, String password, String rule, String status, String when) updateStudy;
  
  @override
  _EditStudyPageState createState() => _EditStudyPageState();
}

class _EditStudyPageState extends State<EditStudyPage> {

  final _formKey = GlobalKey<FormState>(debugLabel: '_AddPage2State');
  bool isSwitched = false;


  @override
  Widget build(BuildContext context) {
    final _categoryController = TextEditingController(text: '${widget.category}');
    final _introductionController = TextEditingController(text: '${widget.introduction}');
    final _maxMemNumberController = TextEditingController(text: '${widget.maxMemNumber}');
    final _passwordController = TextEditingController(text: '${widget.password}');
    final _studyRuleController = TextEditingController(text: '${widget.rules}');
    final _whenController = TextEditingController(text: '${widget.when}');

    bool isPrivite = widget.isPrivite;

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
                      'Number of member',
                      style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(30, 0,30,0),
                    child: TextField(
                      style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.w300),
                      controller: _maxMemNumberController,
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
                      'Category',
                      style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(30, 0,30,0),
                    child: TextField(
                      style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.w300),
                      controller: _categoryController,
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
                      'Introdution',
                      style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(30, 0,30,0),
                    child: TextField(
                      style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.w300),
                      controller: _introductionController,
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
                            if(isSwitched) isPrivite = true;
                            else isPrivite = false;
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
                        child: Text('Save',style: TextStyle(color: Colors.white),),
                        onPressed: () async{    
                          if (_formKey.currentState.validate()) {
                            //save data to widget.newStudy
                            //call editing function 
                            widget.updateStudy(_categoryController.text, _introductionController.text, isPrivite, int.tryParse( _maxMemNumberController.text), 
                                  widget.name,_passwordController.text,_studyRuleController.text, '모집중',_whenController.text);
                            //controller clear
                            _categoryController.clear(); 
                            _introductionController.clear();
                            _maxMemNumberController.clear();
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
