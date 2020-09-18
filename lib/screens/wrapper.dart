import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizzard/models/user.dart';
import 'package:quizzard/screens/authenticate/authenticate.dart';
import 'package:quizzard/screens/authenticate//login.dart';
import 'home/home.dart';


class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);

    if (user == null){
      return Authenticate();
    }else{
      return Home(user:user);
    }

  }
}
