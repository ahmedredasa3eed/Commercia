import 'package:firebase_auth/firebase_auth.dart';

class FirebaseServices{

  String getUserId(){
    return FirebaseAuth.instance.currentUser.uid;
  }

}