import 'package:flutter/material.dart';

//page
import 'package:hudsonstudy/page/home_page.dart';

class EditStudyPage2 extends StatefulWidget {
  EditStudyPage2(
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
    String category;
    String introduction;
    bool isPrivite;
    int maxMemNumber;
    final String name;
    String password;
    final String status;
    String when;
    String rules;
    final Future<void> Function(String category, String introduction, bool isPrivite, int maxMemNumber
      , String studyName, String password, String rule, String status, String when) updateStudy;
  

  @override
  _EditStudyPage2State createState() => _EditStudyPage2State();
}

class _EditStudyPage2State extends State<EditStudyPage2> {
  
  @override
  Widget build(BuildContext context) {
    final _maxMemNumberController = TextEditingController(text: '${widget.maxMemNumber}');
    final _categoryController = TextEditingController(text: '${widget.category}');
    final _introductionController = TextEditingController(text: '${widget.introduction}');
    final _studyRuleController = TextEditingController(text: '${widget.rules}');
    final _whenController = TextEditingController(text: '${widget.when}');

    final _formKey = GlobalKey<FormState>(debugLabel: '_EditStudyPage2State');

    return Scaffold(
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
                  child: TextFormField(
                    controller: _maxMemNumberController,
                    style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.w300),     
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
                  )
                ),
                SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.fromLTRB(50, 0,0,0),
                  child: Text(
                    'Category',
                    style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(30, 0,30,0),
                  child: TextFormField(
                    controller: _categoryController,
                    style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.w300),     
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
                  )
                ),
                SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.fromLTRB(50, 0,0,0),
                  child: Text(
                    'Introdution',
                    style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(30, 0,30,0),
                  child: TextFormField(
                    controller: _introductionController,
                    style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.w300),     
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
                  )
                ),
                SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.fromLTRB(50, 0,0,0),
                  child: Text(
                    'Study Rules',
                    style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(30, 0,30,0),
                  child: TextFormField(
                    controller: _studyRuleController,
                    style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.w300),     
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
                  )
                ),
                SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.fromLTRB(50, 0,0,0),
                  child: Text(
                    'When',
                    style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(30, 0,30,0),
                  child: TextFormField(
                    controller: _whenController,
                    style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.w300),     
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
                  )
                ),
                SizedBox(height: 20),
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
                            //call editing function 
                            widget.updateStudy(_categoryController.text, _introductionController.text, false, int.tryParse( _maxMemNumberController.text), 
                                 widget.name,'1111',_studyRuleController.text, '모집중',_whenController.text);
                            //controller clear
                            _categoryController.clear(); 
                            _introductionController.clear();
                            _maxMemNumberController.clear();
                            _studyRuleController.clear();
                            _whenController.clear();
                          }
                           Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => HomePage()),
                          );
                        },
                      ),
                    ),
                  )
              ],
            ),
          )
        ],
      ),
      

    );
  }
}