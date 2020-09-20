import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizzard/models/user.dart';
import 'package:quizzard/quizList.dart';
import 'package:quizzard/shared/loading.dart';

class EnrolledList extends StatefulWidget {

  final User user;
  EnrolledList({this.user});

  @override
  _EnrolledListState createState() => _EnrolledListState();
}

class _EnrolledListState extends State<EnrolledList> {

  bool loading = false;
  @override
  Widget build(BuildContext context) {


    final enrolled = Provider.of<QuerySnapshot>(context);
    // print(enrolled.documents);
    // enrolled.forEach((e) {
    //   print(e.course);
    // });



    List getCourseList() {
      if (enrolled != null) {
        for (var doc in enrolled.documents) {
          if (doc.data['uid'] == widget.user.uid) {
            return doc.data['course'];
          }
        }
    }
    }

    List courses;
    if(enrolled==null){
      loading = true;
    }else{
      courses = getCourseList();
      loading = false;
    }

    return loading ? Loading() : GridView.count(
        crossAxisCount: 2,
        children: List.generate( courses.length, (index) {
          return Container(
            child: MaterialButton(
              child: Text(
                courses[index],
                style: Theme.of(context).textTheme.headline5,
              ),
              onPressed: () {
                // Navigator.pushNamed(context, '/quizList', arguments: {'title':getCourseList()[index]});
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => QuizList(title: courses[index],),
                ));
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