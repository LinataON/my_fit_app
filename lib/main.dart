 import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_fit_app/domain/user.dart';
import 'package:my_fit_app/screens/landing.dart';
import 'package:my_fit_app/services/auth.dart';
import 'package:provider/provider.dart';
import 'domain/workout.dart';
//void main() => runApp(MyFitApp());
 void main() async {
   WidgetsFlutterBinding.ensureInitialized();
   await Firebase.initializeApp();
   runApp(MyFitApp());
 }

class MyFitApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<MyAppUser?>.value(
      value: AuthService().currentUser,
      initialData: null, // Specify initial data as null
      child: MaterialApp(
          title: 'My Fitness Plan',
          theme: ThemeData(
              primaryColor: Color.fromRGBO(50, 65, 85, 1),
              textTheme: TextTheme(titleLarge: TextStyle(color: Colors.white))
          ),
          home: LandingPage()
      ),
    );
  }
}



