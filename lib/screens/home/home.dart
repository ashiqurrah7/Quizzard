import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quizzard/models/user.dart';
import 'package:quizzard/services/auth.dart';
import 'package:quizzard/services/database.dart';
import 'package:provider/provider.dart';
import 'enrolledList.dart';

void main() => runApp(MaterialApp(
  home: Home(),
));

class Home extends StatefulWidget {

  final User user;
  Home({this.user});

  @override
  _HomeState createState() => _HomeState();
}

List<String> enrolled = ['CSE 490','CSE 491', 'CSE 424'];

class _HomeState extends State<Home> {

  final AuthService _auth = AuthService();

  @override
  // void initState(){
  //   print(widget.user.fname);
  //   super.initState();
  // }
  Widget build(BuildContext context) {

    // final enrolled = Provider.of<QuerySnapshot>(context);

    return StreamProvider<QuerySnapshot>.value(
      value: DatabaseService().enrolled,
      child: Scaffold(
        drawer: Drawer(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              DrawerHeader(
                child: Column(
                  children: <Widget>[
                    Icon(Icons.people),
                    Text('Hello user'),
                  ],
                ),
              ),
              FlatButton(child: Icon(Icons.exit_to_app,), onPressed: () async{
                await _auth.signOut();
              },
              )
            ],
          ),
        ),
        appBar: AppBar(
          elevation: 0,
          title: Text('Quizzard'),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.pushNamed(context, '/courseList', arguments: widget.user.uid);
              },
            ),
          ],
          backgroundColor: Colors.purple[400],
        ),
        body: EnrolledList(user: widget.user,),
        // body: Text(widget.user.uid),
      ),
    );
  }

}