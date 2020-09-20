import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quizzard/QuestionLoop.dart';
import 'package:quizzard/shared/loading.dart';

void main() => runApp(MaterialApp(
  home: Quiz(),
));


class Quiz extends StatefulWidget {

  final String quiz;
  final String course;
  Quiz({this.quiz,this.course});

  @override
  _QuizState createState() => _QuizState();
}

class _QuizState extends State<Quiz> {

  List questions;

  bool loading = false;

  getQuestions() {
    return Firestore.instance.collection('courses')
        .document(widget.course)
        .collection('quizzes').document(widget.quiz).get().then((docs) {
      setState(() {
        questions = docs.data['questions'];
      });
    },
    );
  }

  @override
  void initState(){
    getQuestions();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    if(questions==null){
      loading=true;
    }else{
      loading = false;
      print(questions);
    }



    return loading ? Loading() : Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text(widget.quiz),
          centerTitle: true,
          backgroundColor: Colors.purple[400],
        ),
      body: Center(
        child: MaterialButton(
          color: Colors.cyan,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25)
          ),
          child: Text(
            'Start quiz',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
          onPressed: (){
            Navigator.pushNamed(context, '/questionLoop', arguments: {'course':widget.course,'questions':questions});
          },
        ),
      ),
    );
  }
}
