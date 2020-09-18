import 'package:flutter/material.dart';

class QuestionLoop extends StatefulWidget {

  @override
  _QuestionLoopState createState() => _QuestionLoopState();
}

class _QuestionLoopState extends State<QuestionLoop> {
  var _end=false;
  var _next=true;
  int _qNo = 0;
  int _value = 1;
  String _btnName = 'Next';
  int total = 0;
  List<Map> questions = [
    {'question':'Question 1',
      'options' : ['option 1', 'option 2', 'option 3', 'option 4'],
      'answer': 1 },
    {'question':'Question 2',
      'options' : ['option 11', 'option 22', 'option 33', 'option 44'],
      'answer': 2 },
    {'question':'Question 3',
      'options' : ['option 111', 'option 222', 'option 333', 'option 444'],
      'answer': 0 },
    {'question':'Question 1',
      'options' : ['option 1', 'option 2', 'option 3', 'option 4'],
      'answer': 1 },
    {'question':'Question 2',
      'options' : ['option 11', 'option 22', 'option 33', 'option 44'],
      'answer': 2 },
    {'question':'Question 3',
      'options' : ['option 111', 'option 222', 'option 333', 'option 444'],
      'answer': 0 },
    {'question':'Question 1',
      'options' : ['option 1', 'option 2', 'option 3', 'option 4'],
      'answer': 1 },
    {'question':'Question 2',
      'options' : ['option 11', 'option 22', 'option 33', 'option 44'],
      'answer': 2 },
    {'question':'Question 3',
      'options' : ['option 111', 'option 222', 'option 333', 'option 444'],
      'answer': 0 },
    {'question':'Question 1',
      'options' : ['option 1', 'option 2', 'option 3', 'option 4'],
      'answer': 1 },
  ];


  Widget question(int q){
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
            ),
            leading: Radio(
              value: i,
              groupValue: _value,
              activeColor: Color(0xFF6200EE),
              onChanged: (int value) {
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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                ), onPressed: (){
                  setState(() {
                    if(_value == questions[_qNo]['answer']){
                      total++;
                    }
                    if(_qNo<questions.length-1){
                      _qNo++;
                      if(_qNo == questions.length-1){
                        _next=false;
                        _end=true;
                      }
                    }
                  });
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
                  Navigator.pushReplacementNamed(context, '/result', arguments: total);
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
            ],
          ),
        ));
  }
}
