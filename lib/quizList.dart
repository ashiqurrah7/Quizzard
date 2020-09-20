import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quizzard/quiz.dart';
import 'package:quizzard/shared/loading.dart';

void main() => runApp(MaterialApp(
  home: QuizList(),
));



class QuizList extends StatefulWidget {


  final String title;

  QuizList({
    this.title
});


  @override
  _QuizListState createState() => _QuizListState();
}

class _QuizListState extends State<QuizList> {

  List<String> quizzes;

  bool loading = false;

  getQuizzes() {
    return Firestore.instance.collection('courses')
        .document(widget.title)
        .collection('quizzes')
        .getDocuments().then((docs) {
          setState(() {
            quizzes = docs.documents.map((doc) => doc.data['QuizNo'].toString())
                .toList();
          });
        },
    );

  }

  @override
  void initState(){
      getQuizzes();
    super.initState();
  }



  @override
  Widget build(BuildContext context) {

    if(quizzes==null){
      loading=true;
    }else{
      loading = false;
      print(quizzes);
    }

    return loading ? Loading() : Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(widget.title),
        centerTitle: true,
        backgroundColor: Colors.purple[400],
      ),
      body: GridView.count(
          crossAxisCount: 2,
          children: List.generate(quizzes.length, (index) {
            return Container(
              child: MaterialButton(
                child: Text(
                  quizzes[index],
                  style: Theme.of(context).textTheme.headline5,
                ),
                onPressed: () {
                  // Navigator.pushNamed(context, '/quiz', arguments: {'title':quizzes[index], 'course' : widget.title});
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) => Quiz(quiz: quizzes[index],course: widget.title,),
                  ));
                },
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(50)
                ),
              ),
            );
          })
      ),
    );
  }
}

