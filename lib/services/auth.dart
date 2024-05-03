import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_fit_app/domain/user.dart';

class AuthService{
  final FirebaseAuth _fAuth = FirebaseAuth.instance;

  Future <MyAppUser?> signInWithEmailAndPassword(String email, String password) async {
    try{
      UserCredential result = await _fAuth.signInWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      return MyAppUser.fromFirebase(user!);
    }catch(e){
      print(e);
      return null;

    }
  }

  Future <MyAppUser?> registerWithEmailAndPassword(String email, String password) async {
    try{
      UserCredential result = await _fAuth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      return MyAppUser.fromFirebase(user!);
    }catch(e){
      return null;

    }
  }

  Future logOut() async{
    await _fAuth.signOut();
  }
  Stream<MyAppUser?> get currentUser{
    return _fAuth.authStateChanges()
        .map((user) => user != null ? MyAppUser.fromFirebase(user) : null);


  }

}