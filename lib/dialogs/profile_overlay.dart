import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileOverlay extends ModalRoute {
  @override
  Color get barrierColor => Colors.white.withOpacity(0.45);

  @override
  bool get barrierDismissible => false;

  @override
  String get barrierLabel => null;

  @override
  bool get maintainState => true;

  @override
  bool get opaque => false;

  @override
  Duration get transitionDuration => Duration(milliseconds: 250);

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    // This makes sure that text and other content follows the material style
    return Material(
      type: MaterialType.transparency,
      // make sure that the overlay content is not cut off
      child: ProfileScreen(),
    );
  }

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    // You can add your own animations for the overlay content
    return FadeTransition(opacity: animation, child: child);
  }
}

class ProfileScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ProfileScreen();
  }
}

class _ProfileScreen extends State<ProfileScreen> {
  String _imageURL;
  String _displayName;
  String _email;

  @override
  void initState() {
    super.initState();

    _fetchUserImage();
  }

  void _fetchUserImage() {
    FirebaseAuth.instance.currentUser().then((firebaseUser) {
      setState(() {
        _imageURL = firebaseUser.photoUrl;
        _displayName = firebaseUser.displayName;
        _email = firebaseUser.email;
      });
    }).catchError((error) => print("ERROR: $error"));
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 300,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(90),
              spreadRadius: 0.5,
              blurRadius: 5.0,
              offset: Offset(1.5, 2),
            )
          ],
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(32, 16, 32, 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: _imageURL != null
                    ? Image.network(_imageURL)
                    : Container(
                        color: Colors.blue,
                      ),
              ),
              SizedBox(
                height: 16,
              ),
              Text(
                _displayName != null ? _displayName : 'n/a',
                style: TextStyle(color: Colors.black, fontSize: 26.0),
              ),
              Text(
                _email != null ? _email : 'n/a',
                style: TextStyle(color: Colors.black, fontSize: 18.0),
              ),
              SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  FlatButton(
                    onPressed: () {
                      FirebaseAuth.instance.signOut();
                      Navigator.pop(context);
                      Navigator.pushReplacementNamed(context, '/login');
                    },
                    child: Text(
                      'Logout',
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                  FlatButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      'Close',
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
