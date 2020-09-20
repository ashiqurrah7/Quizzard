import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService{

  final String uid;
  DatabaseService({this.uid});

  //collection reference
  final CollectionReference enrollCollection = Firestore.instance.collection('enrolled');

  Future updateUserData(List course, String name) async{
    return await enrollCollection.document(uid).setData({
      'Name' : name,
      'uid' : uid,
      'course' : course,
    });
  }

  // Map<Enrolled> _enrolledListFromSnapshot(QuerySnapshot snapshot){
  //   return snapshot.documents.map((doc) =>
  //      Enrolled(course: doc.data['course'] ?? '')
  //   ).toList();
  // }

  Stream<QuerySnapshot> get enrolled {
    return enrollCollection.snapshots();
  }

}