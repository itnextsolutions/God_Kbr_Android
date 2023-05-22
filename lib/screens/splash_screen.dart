import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:godrej_login_auth/screens/login_screen.dart';

class SplashScreen extends StatefulWidget {

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void initState(){
    super.initState();
    Timer(Duration(seconds: 2),() {
      Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) => LoginScreen(),
      ));
    });
  }
  @override
 Widget build(BuildContext context){
    return Scaffold(
        backgroundColor: Colors.white,
            body: Center(
               child: SingleChildScrollView(
               child: Container(
                     color: Colors.white,
               child: Padding(
              padding: const EdgeInsets.all(36.0),
               child: Column(
                     mainAxisAlignment: MainAxisAlignment.center,
                     crossAxisAlignment: CrossAxisAlignment.center,
                       children: <Widget>[
                         SizedBox(
                           height: 200,
                            child: Image.asset(
                               "assets/logo.png",
                                 fit: BoxFit.contain,
                            ),
                         ),
                       ],
               )
              ),
                ),
               ),
        ),
    );
  }
}