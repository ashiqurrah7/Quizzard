import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quizzard/services/auth.dart';
import 'package:quizzard/shared/constants.dart';
import 'package:quizzard/shared/loading.dart';

void main() => runApp(MaterialApp(
  home: Login(),
));



class Login extends StatefulWidget {

  final Function toggleView;
  Login({ this.toggleView });

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;


  String username = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.purple[400],
      body: Center(
        child: Container(
          height: 200,
          width: 200,
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                TextFormField(
                  validator: (val) => val.isEmpty ? 'Enter a username' : null,
                  decoration: textInputDecoration.copyWith(hintText: 'Email'),
                  onChanged: (val){
                    setState(() => username = val);
                  },
                ),
                TextFormField(
                  validator: (val) => val.length < 6 ? 'Enter a password which is 6+ characters long' : null,
                  decoration: textInputDecoration.copyWith(hintText: 'Password'),
                  obscureText: true,
                  onChanged: (val){
                    setState(() => password = val);
                  }
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
                        onPressed: () async {
                          if (_formKey.currentState.validate()){
                            setState(() => loading = true);
                            dynamic result = await _auth.signInWithCreds(username, password);
                            if(result == null) {
                              setState(() {
                                error = 'Could not sign in with those credentials';
                                loading = false;
                              });
                            }
                          }
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
                          widget.toggleView();
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
