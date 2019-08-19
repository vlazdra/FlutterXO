import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyCustomAlertDialog {
  static AlertDialog getForBackPressValidation(BuildContext context) {
    return AlertDialog(
      title: Text('Are you sure you want to exit?'),
      actions: <Widget>[
        RaisedButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text(
            'NO',
            style: TextStyle(color: Colors.white),
          ),
        ),
        RaisedButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: Text(
            'YES',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}
