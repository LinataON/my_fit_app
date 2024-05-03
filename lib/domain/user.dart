import 'package:firebase_auth/firebase_auth.dart';

class MyAppUser {
  late String id;

  MyAppUser.fromFirebase(User user){
    id = user.uid;
  }
}