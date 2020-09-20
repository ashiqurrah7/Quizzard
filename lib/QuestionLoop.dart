import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class QuestionLoop extends StatefulWidget {
  


  @override
  _QuestionLoopState createState() => _QuestionLoopState();
}

class _QuestionLoopState extends State<QuestionLoop> {
  var _end=false;
  var _next=true;
  int _qNo = 0;
  int _value;
  String _btnName = 'Next';
  int total = 0;
  int timer = 10;
  String showtimer = "10";
  bool timeEnd = false;
  bool cancelTimer = false;
  List questions;
  bool isDisabled = false;
  // = [
  //   {'question':'Question 1',
  //     'options' : ['option 1', 'option 2', 'option 3', 'option 4'],
  //     'answer': 1 },
  //   {'question':'Question 2',
  //     'options' : ['option 11', 'option 22', 'option 33', 'option 44'],
  //     'answer': 2 },
  //   {'question':'Question 3',
  //     'options' : ['option 111', 'option 222', 'option 333', 'option 444'],
  //     'answer': 0 },
  //   {'question':'Question 1',
  //     'options' : ['option 1', 'option 2', 'option 3', 'option 4'],
  //     'answer': 1 },
  //   {'question':'Question 2',
  //     'options' : ['option 11', 'option 22', 'option 33', 'option 44'],
  //     'answer': 2 },
  //   {'question':'Question 3',
  //     'options' : ['option 111', 'option 222', 'option 333', 'option 444'],
  //     'answer': 0 },
  //   {'question':'Question 1',
  //     'options' : ['option 1', 'option 2', 'option 3', 'option 4'],
  //     'answer': 1 },
  //   {'question':'Question 2',
  //     'options' : ['option 11', 'option 22', 'option 33', 'option 44'],
  //     'answer': 2 },
  //   {'question':'Question 3',
  //     'options' : ['option 111', 'option 222', 'option 333', 'option 444'],
  //     'answer': 0 },
  //   {'question':'Question 1',
  //     'options' : ['option 1', 'option 2', 'option 3', 'option 4'],
  //     'answer': 1 },
  // ];




  Widget question(int q){
    // var list = new List<int>.generate(40, (int index) => index); // [0, 1, 4]
    // list.shuffle();
    // var list2 = list.sublist(0,10);
    // print(list2);

    return Column(
      mainAxisAlignment:MainAxisAlignment.center,
      children: <Widget>[
        Container(
          child: Text(questions[q]['question'],
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
        ),
        for (int i = 0; i <questions[q]['options'].length; i++)
          ListTile(
            title: Text(
              questions[q]['options'][i],
              style: TextStyle(color: timeEnd ? Colors.black38 : Colors.black),
            ),
            leading: Radio(
              value: i,
              groupValue: _value,
              activeColor: Color(0xFF6200EE),
              onChanged: timeEnd ? null : (int value) {
                setState(() {
                  _value = value;
                  print('answer :' + questions[q]['answer'].toString());
                  print(total);
                });
              },
            ),
          ),
      ],
    );
  }

  void startTimer() async{
    const oneSec = Duration(seconds: 1);
    Timer.periodic(oneSec, (t) {
      setState(() {
        if(timer < 1){
          t.cancel();
          timeEnd=true;
        }else if(cancelTimer==true){
          t.cancel();
        }else{
          timer--;
        }
        setState(() {
          showtimer = timer.toString();
        });
      });
    });
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void initState(){
    startTimer();
    questions.shuffle();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    Map data = ModalRoute.of(context).settings.arguments;
    questions = data['questions'];
    final String course = data['course'];

    void nextQuestion(){
      setState(() {
        if(_qNo<questions.length-1){
          _qNo++;
          if(_qNo == questions.length-1){
            _next=false;
            _end=true;
          }
        }
        cancelTimer=false;
        isDisabled = false;
      });
      timeEnd=false;
      timer = 10;
      startTimer();
    }


    return WillPopScope(
      onWillPop: (){
        return showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Warning!'),
            content: Text('Please finish the quiz!'),
            actions: <Widget>[
              MaterialButton(
                color: Colors.cyan,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25)
              ),
                child: Text('Ok', style: TextStyle(color: Colors.white),),
                onPressed: (){
                  Navigator.pop(context);
                },
              )
            ],
          )
        );
      },
      child: Scaffold(
          body: SafeArea(
            child: Column(
              children: <Widget>[
                Flexible( flex: 2, child: question(_qNo)),
                Flexible(flex: 1,child: Visibility(
                  visible: _next,
                  child: MaterialButton(
                    color: Colors.cyan,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25)
                    ),
                    child: Text('Next',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ), onPressed: isDisabled ? null :  (){
                    setState(() {
                      isDisabled = true;
                      cancelTimer = true;
                      if(_value == questions[_qNo]['answer']){
                        total++;
                      }
                    });
                    Timer(Duration(seconds: 1), nextQuestion);
                  },
                  ),
                )),
                Flexible( flex: 1, child: Visibility(
                  visible: _end,
                  child: MaterialButton(onPressed: () {

                    if(_value == questions[_qNo]['answer']){
                      total++;
                      print(total);
                    }
                    setState(() {
                      cancelTimer = true;
                    });
                    Navigator.pushReplacementNamed(context, '/result', arguments: {'course':course,'total':total});
                  },
                    color: Colors.cyan,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25)
                    ),
                    child: Text('End Exam',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),),
                )),
                Expanded(
                  flex: 1, child: Container(height: double.infinity,alignment: Alignment.bottomCenter,child: Text(showtimer, style:TextStyle(color: Colors.purple[500],fontSize: 40),)),
                ),
              ],
            ),
          )
      ),
    );
  }
}
