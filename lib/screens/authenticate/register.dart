import 'package:flutter/material.dart';
import 'package:quizzard/services/auth.dart';
import 'package:quizzard/shared/constants.dart';
import 'package:quizzard/shared/loading.dart';

void main() => runApp(MaterialApp(
  home: Register(),
));


class Register extends StatefulWidget {

  final Function toggleView;
  Register({ this.toggleView });


  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  String fname = '';
  String username = '';
  String password = '';
  String cpassword = '';
  String error ='';

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.purple[400],
      body: Center(
        child: Container(
          height: 400,
          width: 200,
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                TextFormField(
                  validator: (val) => val.isEmpty ? 'Enter your full name' : null,
                  decoration: textInputDecoration.copyWith(hintText: 'Full Name'),
                  onChanged: (val){
                    setState(() => fname = val);
                  },
                ),
                TextFormField(
                  validator: (val) => val.isEmpty ? 'Enter a email' : null,
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
                  },
                ),
                TextFormField(
                  validator: (val) => val != password  ? 'Passwords did not match' : null,
                  decoration: textInputDecoration.copyWith(hintText: 'Confirm Password'),
                  obscureText: true,
                  onChanged: (val){
                    setState(() => cpassword = val);
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children : <Widget>[
                    MaterialButton(
                      color: Colors.yellow[700],
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
                        widget.toggleView();
                      },
                    ),
                    MaterialButton(
                      color: Colors.cyan,
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
                      onPressed: () async{
                        if (_formKey.currentState.validate()){
                          setState(() => loading = true);
                          dynamic result = await _auth.registerWithCreds(username, password);
                          if(result == null) {
                            setState((){
                              error = 'Error occurred while registering';
                              loading = false;
                            });
                          }
                        }
                      },
                    ),
                  ],
                ),
                SizedBox(height: 12.0,),
                Text (error, style: TextStyle(color: Colors.yellow),),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
