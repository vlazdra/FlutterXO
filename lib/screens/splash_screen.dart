import 'package:firebase_auth/firebase_auth.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() {
    return _SplashScreenState();
  }
}

class _SplashScreenState extends State<SplashScreen> {
  // GoogleSignInAccount _googleSignInAccount;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2), () => {_checkNextScreen()});
  }

  void _checkNextScreen() async {
    FirebaseUser firebaseUser = await FirebaseAuth.instance.currentUser();
    if (firebaseUser == null) {
      print('NOT SINGED IN');
      Navigator.pushReplacementNamed(context, '/login');
    } else {
      print('SIGNED IN');
      Navigator.pushReplacementNamed(context, '/main');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 150,
          child: FlareActor(
            'assets/loading.flr',
            animation: "run",
          ),
        ),
      ),
    );
  }
}
