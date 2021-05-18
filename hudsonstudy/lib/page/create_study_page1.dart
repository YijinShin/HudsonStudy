import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; 
//page
import 'package:hudsonstudy/page/create_study_page2.dart';
//model
import 'package:hudsonstudy/model/study.dart';
//provider
import 'package:hudsonstudy/provider/applicationstate_provider.dart';

class CreateStudyPage1 extends StatefulWidget {
  @override
  _CreateStudyPage1State createState() => _CreateStudyPage1State();
}

class _CreateStudyPage1State extends State<CreateStudyPage1> {

  final _studyNameController = TextEditingController();
  final _memberNumberController = TextEditingController();
  final _categoryController = TextEditingController();
  final _introductionController = TextEditingController();
  final _formKey = GlobalKey<FormState>(debugLabel: '_AddPage1State');
  
  NewStudy newStudy = new NewStudy();

  @override
  Widget build(BuildContext context) {
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
                      'Study Name',
                      style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(30, 0,30,0),
                    child: TextFormField(
                      style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.w300),
                      controller: _studyNameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter your message to continue';
                        }
                        return null;
                      },
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
                      'Number of member',
                      style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(30, 0,30,0),
                    child: TextFormField(
                      style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.w300),
                      controller: _memberNumberController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter your message to continue';
                        }
                        return null;
                      },
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
                    child: TextFormField(
                      style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.w300),
                      controller: _categoryController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter your message to continue';
                        }
                        return null;
                      },
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
                      'Introduction',
                      style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(30, 0,30,0),
                    child: TextFormField(
                      style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.w300),
                      controller: _introductionController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter your message to continue';
                        }
                        return null;
                      },
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
                        child: Text('Create!',style: TextStyle(color: Colors.white),),
                        onPressed: (){    
                          if (_formKey.currentState.validate()) {
                            //save info to study model
                            newStudy.name = _studyNameController.text;
                            newStudy.category = _categoryController.text;
                            newStudy.maxMemNumber = int.parse(_memberNumberController.text);
                            newStudy.introduction = _introductionController.text;
                            //controller clear
                            _studyNameController.clear();
                            _memberNumberController.clear();
                            _categoryController.clear();
                            _introductionController.clear(); 
                            //navigator
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context){
                                  return Consumer<ApplicationStateProvider>(
                                    builder: (context, appState, _) => CreateStudyPage2(
                                      addStudyToStudy: (NewStudy newStudy) =>
                                        appState.addStudyToStudy(newStudy),
                                      newStudy : newStudy
                                    )
                                  );
                                }
                              ),
                            );
                          }
                        },
                      ),
                    ),
                  )
                ]
              ),
            ),
        ],
      ),
    );
  }
}
