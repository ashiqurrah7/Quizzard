import 'package:firebase_auth/firebase_auth.dart';
import 'package:quizzard/models/user.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;


  //create user obj based on FirebaseUser
  Users _userFromFireBaseUser(User user){
    return user != null? Users(uid: user.uid) : null;
  }

  // auth change user stream
  Stream<Users> get user {
    return _auth.authStateChanges()
        .map(_userFromFireBaseUser);
  }

  //sign in with email & password

  // register with credentials

  // sign out
  Future signOut() async {
    try{
      return await _auth.signOut();
    }catch(e){
      print(e.toString());
      return null;
    }
  }
}