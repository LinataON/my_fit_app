import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_fit_app/screens/auth.dart';
import 'package:my_fit_app/screens/home.dart';

class LandingPage extends StatelessWidget{
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){
    final bool isloggedin = false;

    return isloggedin ? HomePage() : AuthorizationPage();

  }
}