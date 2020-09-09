import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quizzard/services/auth.dart';

void main() => runApp(MaterialApp(
  home: Login(),
));



class Login extends StatefulWidget {

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  final AuthService _auth = AuthService();

  String username = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple[400],
      body: Center(
        child: Container(
          height: 200,
          width: 200,
          child: Form(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30)
                  ),
                  padding: EdgeInsets.only(left: 20),
                  child: TextFormField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Username',
                    ),
                    onChanged: (val){
                      setState(() => username = val);
                    },
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30)
                  ),
                  padding: EdgeInsets.only(left: 20),
                  child: TextFormField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Password',
                    ),
                    obscureText: true,
                    onChanged: (val){
                      setState(() => password = val);
                    }
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children : <Widget>[
                      MaterialButton(
                        color: Colors.cyan,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25)
                        ),
                        child: Text(
                          'Login',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                        onPressed: (){

                        },
                      ),
                      MaterialButton(
                        color: Colors.yellow[700],
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25)
                        ),
                        child: Text(
                          'Register',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                        onPressed: (){
                          Navigator.pushNamed(context, '/register');
                        },
                      ),
                    ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
