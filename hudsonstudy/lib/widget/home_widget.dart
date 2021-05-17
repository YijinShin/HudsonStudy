import 'package:flutter/material.dart';
import 'package:hudsonstudy/page/start_page.dart';
import 'package:provider/provider.dart';

//provider
import 'package:hudsonstudy/provider/applicationstate_provider.dart';

import 'package:hudsonstudy/page/profile_page.dart';



class HomeWidget extends StatefulWidget {
  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {

  final _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white10,
        elevation: 0.0,
        actions: [
          IconButton(
            icon: Icon(Icons.alarm,color: Colors.black), 
            onPressed: (){
            },
          ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          children: [
            Row(
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
                  width: 120,
                  height: 120,
                  child: FlatButton(
                    child: Image.asset('assets/user.png',fit: BoxFit.fill,),
                    onPressed: (){
                       Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ProfilePage()),
                      );
                    },
                  )
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text('Hi,',style: TextStyle(fontSize: 40, fontWeight: FontWeight.w300)),
                        Text('Yijin ',style: TextStyle(fontSize: 40, fontWeight: FontWeight.w400)),
                      ],
                    ),
                    Text('Computer Science',style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300)),
                  ],
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    padding: EdgeInsets.fromLTRB(35, 0, 10,10),
                    height: 50,
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        filled: true, 
                        labelText: 'Find the study you want',
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                  child: IconButton(
                    icon: Icon(Icons.search_outlined), 
                    onPressed: (){}
                  ),
                ),
              ],
            ),
          ],
        )
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        child: Icon(Icons.add,color: Colors.white,),
        onPressed: (){print('floating button');},
      ),
    );
  }
}
