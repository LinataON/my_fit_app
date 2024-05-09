import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_fit_app/domain/user.dart';
import 'package:my_fit_app/screens/auth.dart';
import 'package:my_fit_app/screens/home.dart';
import 'package:provider/provider.dart';

class LandingPage extends StatelessWidget{
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){
    final MyAppUser? user = Provider.of<MyAppUser?>(context);
    final bool isloggedin = user != null;

    return isloggedin ? HomePage() : AuthorizationPage();

  }
}