import 'package:firebase_auth/firebase_auth.dart';
import 'package:quizzard/models/user.dart';
import 'package:quizzard/services/database.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;


  //create user obj based on FirebaseUser
  User _userFromFireBaseUser(FirebaseUser user){
    return user != null? User(uid: user.uid) : null;
  }

  // auth change user stream
  Stream<User> get user {
    return _auth.onAuthStateChanged
        .map(_userFromFireBaseUser);
  }

  //sign in with email & password
  Future signInWithCreds(String username, String password) async{
    try{
      AuthResult result = await _auth.signInWithEmailAndPassword(email: username, password: password);
      FirebaseUser user = result.user;
      return user;
    }catch(e){
      print(e.toString());
      return null;
    }
  }
  // register with credentials
  Future registerWithCreds(String username, String password) async{
    try{
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: username, password: password);
      FirebaseUser user = result.user;

      //create a new document for the user with uid
      await DatabaseService(uid: user.uid).updateUserData('Dummy Course');
      return _userFromFireBaseUser(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }

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