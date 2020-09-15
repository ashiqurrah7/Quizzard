import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService{

  final String uid;
  DatabaseService({this.uid});

  //collection reference
  final CollectionReference enrollCollection = Firestore.instance.collection('enrolled');

  Future updateUserData(String course) async{
    return await enrollCollection.document(uid).setData({
      'course' : course,
    });
  }
  
}