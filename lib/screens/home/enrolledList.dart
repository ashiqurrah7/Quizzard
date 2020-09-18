import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizzard/models/enrolled.dart';
import 'package:quizzard/models/user.dart';

class EnrolledList extends StatefulWidget {

  final User user;
  EnrolledList({this.user});

  @override
  _EnrolledListState createState() => _EnrolledListState();
}

class _EnrolledListState extends State<EnrolledList> {


  @override
  Widget build(BuildContext context) {

    final enrolled = Provider.of<QuerySnapshot>(context);
    // print(enrolled.documents);
    // enrolled.forEach((e) {
    //   print(e.course);
    // });

    List getCourseList() {
      for (var doc in enrolled.documents){
        if(doc.data['uid'] == widget.user.uid){
          return doc.data['course'];
        }else return [];
      }
    }
    return GridView.count(
        crossAxisCount: 2,
        children: List.generate(getCourseList().length, (index) {
          return Container(
            child: MaterialButton(
              child: Text(
                getCourseList()[index],
                style: Theme.of(context).textTheme.headline5,
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/quizList', arguments: {'title':getCourseList()[index]});
              },
              shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(50)
              ),
            ),
          );
        })
    );
  }
}