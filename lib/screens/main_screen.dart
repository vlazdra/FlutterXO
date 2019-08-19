import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_xo/dialogs/alert_dialog.dart';
import 'package:flutter_xo/dialogs/profile_overlay.dart';

class MainScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MainScreenState();
  }
}

class _MainScreenState extends State<MainScreen> {
  String _loggedInUserImage;

  @override
  void initState() {
    super.initState();

    _fetchUserImage();
  }

  void _fetchUserImage() async {
    FirebaseUser firebaseUser = await FirebaseAuth.instance.currentUser();
    setState(() {
      _loggedInUserImage = firebaseUser.photoUrl;
    });
  }

  Future<bool> _onWillPop() {
    return showDialog(
        context: context,
        builder: (context) {
          return MyCustomAlertDialog.getForBackPressValidation(context);
        });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
            appBar: AppBar(
              title: Text('Flutter XO'),
              actions: <Widget>[
                IconButton(
                  onPressed: () => Navigator.of(context).push(ProfileOverlay()),
                  icon: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: _loggedInUserImage != null
                        ? Image.network(_loggedInUserImage)
                        : Container(),
                  ),
                )
              ],
            ),
            body: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    constraints: BoxConstraints(minWidth: double.infinity),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                      color: Colors.blue,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Text(
                          'Pick one option, create or join!',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                    child: Container(
                  constraints: BoxConstraints(
                    minWidth: double.infinity,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Material(
                            color: Colors.blue,
                            borderRadius: BorderRadius.all(Radius.circular(4)),
                            elevation: 4,
                            child: InkWell(
                              onTap: () => print('aa'),
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(16, 8, 16, 8),
                                child: Text(
                                  'Create a game',
                                  style: TextStyle(
                                    fontSize: 24,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Material(
                            color: Colors.blue,
                            borderRadius: BorderRadius.all(Radius.circular(4)),
                            elevation: 4,
                            child: InkWell(
                              onTap: () => print('aa'),
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(16, 8, 16, 8),
                                child: Text(
                                  'Join a game',
                                  style: TextStyle(
                                    fontSize: 24,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ))
              ],
            )));
  }
}
