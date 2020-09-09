import 'package:flutter/material.dart';
import 'package:quizzard/home.dart';
import 'package:quizzard/courseList.dart';
//import 'package:quizzard/login.dart';
//import 'package:quizzard/models/user.dart';
import 'package:quizzard/quizList.dart';
//import 'package:quizzard/register.dart';
import 'package:quizzard/quiz.dart';
//import 'package:provider/provider.dart';
//import 'package:quizzard/services/auth.dart';

//void main() => runApp(Quizzard());
//
//
//class Quizzard extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return StreamProvider<Users>.value(
//      value: AuthService().user,
//      child: MaterialApp(
//          routes: {
//            '/' : (context) => Home(),
//            '/courseList' : (context) => CourseList(),
//            '/login' : (context) => Login(),
//            '/register' : (context) => Register(),
//            '/quizList' : (context) => QuizList(),
//            '/quiz' : (context) => Quiz(),
//          }
//      )
//    );
//  }
//}

void main() => runApp(MaterialApp(
    routes: {
            '/' : (context) => Home(),
            '/courseList' : (context) => CourseList(),
//            '/login' : (context) => Login(),
//            '/register' : (context) => Register(),
            '/quizList' : (context) => QuizList(),
            '/quiz' : (context) => Quiz(),

    },
));