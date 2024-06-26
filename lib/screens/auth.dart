import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_fit_app/domain/user.dart';
import 'package:my_fit_app/services/auth.dart';

class AuthorizationPage extends StatefulWidget {
  const AuthorizationPage({super.key});

  @override
  State<AuthorizationPage> createState() => _AuthorizationPageState();
}

class _AuthorizationPageState extends State<AuthorizationPage> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  late String _email;
  late String _password;
  bool showlogin = true;

  AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {

    Widget _logo(){
      return Padding(
          padding: EdgeInsets.only(top: 100),
          child: Container(
            child: Align(
              child: Text('MY FITNESS PLAN', style: TextStyle(fontSize: 45, fontWeight: FontWeight.bold, color: Colors.white  )
              )
            )
          )
      );
    }

    Widget _input(Icon icon, String hint, TextEditingController controller, bool obscure){
      return Container(
        padding: EdgeInsets.only(left: 20, right: 20),
        child: TextField(
          controller: controller,
          obscureText: obscure,
          style: TextStyle(fontSize: 20, color: Colors.white),
          decoration: InputDecoration(
            hintStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white30),
            hintText: hint,
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white, width: 3)
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white54, width: 1)
            ),
            prefixIcon: Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: IconTheme(
                data: IconThemeData(color: Colors.white),
                child: icon
              ) ,
            )
          ),
        ),
      );
    }
    /*Widget _button(String text, void func()){
      return ElevatedButton(
        splashColor: Theme.of(context).primaryColor,
        highlightColor: Theme.of(context).primaryColor,
        color: Colors.white,
        child: Text(
          text,
          style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor, fontSize: 20),

        ),
        onPressed: (){
          func();
        },
      );
    }
    */

    Widget _button(String text, void Function() func) {
      return ElevatedButton(
        style: ElevatedButton.styleFrom(
          //primary: Colors.white,
          //onPrimary: Theme.of(context).primaryColor,
        ),
        onPressed: func,
        child: Ink(
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Container(
            constraints: BoxConstraints(maxWidth: 300.0, minHeight: 50.0),
            alignment: Alignment.center,
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 20,
              ),
            ),
          ),
        ),
      );
    }
    Widget _form(String label, void func()){
      return Container(
        child: Column(
          children: <Widget> [
            Padding(
                padding: EdgeInsets.only(bottom: 20, top: 10),
                child: _input(Icon(Icons.email), "EMAIL", _emailController, false)
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 20),
              child: _input(Icon(Icons.lock), "PASSWORD", _passwordController, true)
            ),
            SizedBox(height: 20,),
            Padding(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  child: _button(label, func)

                )
            ),


          ],
        ),
      );
    }

    void _loginButtonAction() async{
      _email = _emailController.text;
      _password = _passwordController.text;

      if(_email.isEmpty || _password.isEmpty) return;

      MyAppUser? user =  await _authService.signInWithEmailAndPassword(_email.trim(), _password.trim());
      if (user == null)
        {
          Fluttertoast.showToast(
              msg: "Not able to sign in! Please check your email/password",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0
          );


        }else {
          _emailController.clear();
          _passwordController.clear();
        }
    }

    void _registerButtonAction() async{
      _email = _emailController.text;
      _password = _passwordController.text;

      if(_email.isEmpty || _password.isEmpty) return;

      MyAppUser? user =  await _authService.registerWithEmailAndPassword(_email.trim(), _password.trim());
      if (user == null)
      {
        Fluttertoast.showToast(
            msg: "Not able to register you! Please check your email/password",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
        );


      }else {
        _emailController.clear();
        _passwordController.clear();
      }
    }

    Widget _bottomWave() {
      return Expanded(
        child: Align(
          child: ClipPath(
            child: Container(
              color: Colors.white,
              height: 300,
            ),
            clipper: BottomWaveClipper(),
          ),
          alignment: Alignment.bottomCenter,
        ),
      );
    }

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Column(
        children: <Widget> [
          _logo(),
          SizedBox(height: 50,),
          (

          showlogin
             ? Column(
              children: <Widget>[
                _form('LOGIN', _loginButtonAction),
                Padding(
                    padding: EdgeInsets.all(10),
                    child: GestureDetector(
                      child: Text('Not registered yet? Register!', style: TextStyle(fontSize: 20, color: Colors.white)),
                      onTap:(){
                        setState((){
                          showlogin = false;
                    });
                    }

                    ),
                )
              ],
          )
          : Column(
            children: <Widget>[
              _form('REGISTER', _registerButtonAction),
              Padding(
                padding: EdgeInsets.all(10),
                child: GestureDetector(
                    child: Text('Already registered? Login!', style: TextStyle(fontSize: 20, color: Colors.white)),
                    onTap:(){
                      setState((){
                        showlogin = true;
                      });
                    }

                ),
              )
            ],
          )
          ),
          _bottomWave()

        ],
      )
    );
  }
}

class BottomWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.moveTo(size.width, 0.0);
    path.lineTo(size.width, size.height);
    path.lineTo(0.0, size.height);
    path.lineTo(0.0, size.height + 5);
    var secondControlPoint = Offset(size.width - (size.width / 6), size.height);
    var secondEndPoint = Offset(size.width, 0.0);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
      secondEndPoint.dx, secondEndPoint.dy);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
