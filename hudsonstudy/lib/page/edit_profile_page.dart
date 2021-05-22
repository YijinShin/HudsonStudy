import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

//provider
import 'package:hudsonstudy/provider/applicationstate_provider.dart';
//page
import 'package:hudsonstudy/page/home_page.dart';
//model
import 'package:hudsonstudy/model/user.dart';


class EditProfilePage extends StatefulWidget {

  EditProfilePage({
    @required this.updateAppUser,
    //@required this.editUser,
    @required this.firstName,
    @required this.sureName,
    @required this.contect,
    @required this.major,
  });
  final Future<void> Function(String firstName, String sureName, String major, String contect) updateAppUser;
  //EditUser editUser;
   String firstName;
   String sureName;
   String contect;
   String major;
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {

  final _majorList = [
    'None',
    'Computure Science',
    'Life Science',
    'Electrical Engineering',
    'Mechanical Engineering',
    'Counseling Psychology',
    'Social Welfare',
    'Communication Arts',
    'Languages',
    'Law',
  ];

  @override
  Widget build(BuildContext context) {
      final _firstNameController = TextEditingController(text: "${widget.firstName}");
      final _sureNameController = TextEditingController(text: "${widget.sureName}");
      final _contectController = TextEditingController(text: "${widget.contect}");
      String selectedMajor = "${widget.major}";
      //print('selected : $selectedMajor');
      //String selectedMajor = 'None';
      String firstName, sureName, contect, major;


    final _formKey = GlobalKey<FormState>(debugLabel: '_EditProfilePageState');

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        //title: Text('My page',style: TextStyle(color: Colors.black),),
        leading: BackButton(color: Colors.black),
        elevation: 0.0,
      ),
      body: SafeArea(
        child: ListView(
          children: [
            Row(
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
                  width: 90,
                  height: 90,
                  child: Image.asset('assets/user.png',fit: BoxFit.fill,),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text('Yijin ',style: TextStyle(fontSize: 40, fontWeight: FontWeight.w400)),
                      ],
                    ),
                    Text('Computer Science',style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300)),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20,),
            Container(
              padding: EdgeInsets.fromLTRB(50, 0,0,0),
              child: Text(
                'Firstname',
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(30, 0,30,0),
              child: TextFormField(
                style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.w300),
                controller: _firstNameController,
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
                'Surename',
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(30, 0,30,0),
              child: TextFormField(
                style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.w300),
                controller: _sureNameController,
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
                'Major',
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(55, 10,55,0),
              padding: EdgeInsets.fromLTRB(20, 0,20,0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.black12, width: 2),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 0.4,
                    blurRadius: 2,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton(
                  value: selectedMajor,
                  //elevation : 40,
                  items: _majorList.map(
                      (value){
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }
                  ).toList(),
                  onChanged: (String newValue){
                    setState((){
                      selectedMajor = newValue;
                      print('seleted major : $newValue');
                    });
                  },
                ),
              ),
            ),
            SizedBox(height: 20,),
            Container(
              padding: EdgeInsets.fromLTRB(50, 0,0,0),
              child: Text(
                'Contect',
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(30, 0,30,0),
              child: TextFormField(
                style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.w300),
                controller: _contectController,
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
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side: BorderSide(color: Colors.black),
                        ),
                        color: Colors.white,
                        elevation:5.0,
                        child: Text('Edit',style: TextStyle(color: Colors.black),),
                        onPressed: () async{    
                          if (_formKey.currentState.validate()) {
                            //save edited info to structure
                            print('new first name :${_firstNameController.text}');
                            //update appUser
                            await widget.updateAppUser(_firstNameController.text, _sureNameController.text, selectedMajor, _contectController.text);
                            //controller clear
                            _firstNameController.clear();
                            _sureNameController.clear();
                            _contectController.clear();
                            //navigator
                            Navigator.pop(context);
                          }
                        },
                      ),
                    ),
                  )
          ],
        )
      ),
    );
  }
}