import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hudsonstudy/page/start_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

//provider
import 'package:hudsonstudy/provider/applicationstate_provider.dart';
//page
import 'package:hudsonstudy/page/home_page.dart';
import 'package:hudsonstudy/page/edit_profile_page.dart';
//widget
import 'package:hudsonstudy/widget/profile_listview_widget.dart';


class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  final _searchController = TextEditingController();
  final appUserRef = FirebaseFirestore.instance.collection('appUser');
  String currentUserEmail = FirebaseAuth.instance.currentUser.email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white10,
        //title: Text('My page',style: TextStyle(color: Colors.black),),
        leading: BackButton(color: Colors.black),
        elevation: 0.0,
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            color: Colors.black,
            onPressed: (){    
              final provider = Provider.of<ApplicationStateProvider>(context, listen:false);
              provider.signOut();
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomePage()),
              );
            },    
          )
        ],
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
                        StreamBuilder(
                          stream: appUserRef.doc('$currentUserEmail').snapshots(),
                          builder: (context, snapshot){
                            return Text(
                              '${snapshot.data['firstName']}  ${snapshot.data['sureName']}',
                              style: TextStyle(fontSize: 40, fontWeight: FontWeight.w400)
                            );
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.edit), 
                          onPressed: (){
                             Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => EditProfilePage()),
                            );
                          }
                        ),
                      ],
                    ),
                    Text('Computer Science',style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300)),
                  ],
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.fromLTRB(45, 15, 0, 10),
              child: Text('My Study',style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400))
            ),
            ProfileViewWidget(),
          ],
        )
      ),
    );
  }
}