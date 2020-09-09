import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizzard/models/user.dart';
import '../home.dart';
import '../login.dart';


class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<Users>(context);

    if (user == null){
      return Login();
    }else{
      return Home();
    }

  }
}
