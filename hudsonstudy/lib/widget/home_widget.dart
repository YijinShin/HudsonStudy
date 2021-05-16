import 'package:flutter/material.dart';
import 'package:hudsonstudy/page/start_page.dart';
import 'package:provider/provider.dart';

import 'package:hudsonstudy/provider/applicationstate_provider.dart';



class HomeWidget extends StatefulWidget {
  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {

  final _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            Container(
              padding: EdgeInsets.all(15),
              alignment: Alignment.topRight,
              child: IconButton(
                icon: Icon(Icons.alarm,color: Colors.black), 
                onPressed: (){

                },
              ),
            ),
            Row(
              children: [
                Container(
                  padding: EdgeInsets.fromLTRB(40,0,15,0),
                  child: Icon(
                    Icons.account_circle_outlined,
                    color: Colors.black,
                    size: 85,
                  ),
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
                    padding: EdgeInsets.fromLTRB(30, 10, 20,10),
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
                IconButton(icon: Icon(Icons.search_outlined), onPressed: (){}),
              ],
            ),
            FlatButton(
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
          ],
        )
      ),
    );
  }
}