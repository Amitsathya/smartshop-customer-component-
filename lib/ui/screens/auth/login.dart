import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_ui/firebase_auth_ui.dart';
import 'package:firebase_auth/firebase_auth.dart' as FirebaseAut;
import 'package:firebase_auth_ui/providers.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  FirebaseUser _user;
  String _error = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Firebase Auth UI Demo'),
        ),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              _getMessage(),
              Container(
                margin: EdgeInsets.only(top: 10, bottom: 10),
                child: RaisedButton(
                  child: Text(_user != null ? 'Logout' : 'Login'),
                  onPressed: _onActionTapped,
                ),
              ),
              _getErrorText(),
              _user != null
                  ? FlatButton(
                      child: Text('Delete'),
                      textColor: Colors.red,
                      onPressed: () => _deleteUser(),
                    )
                  : Container()
            ],
          ),
        ),
      ),
    );
  }

  Widget _getMessage() {
    if (_user != null) {
      return Text(
        'Logged in user is: ${_user?.email} ${_user?.phoneNumber}',
        style: TextStyle(
          fontSize: 16,
        ),
      );
    } else {
      return Text(
        'Tap the below button to Login',
        style: TextStyle(
          fontSize: 16,
        ),
      );
    }
  }

  Widget _getErrorText() {
    if (_error.isNotEmpty == true) {
      return Text(
        _error,
        style: TextStyle(
          color: Colors.redAccent,
          fontSize: 16,
        ),
      );
    } else {
      return Container();
    }
  }

  void _deleteUser() async {
    print(_user);
  }

  void _onActionTapped() async {
    if (_user == null) {
      FirebaseAuthUi.instance().launchAuth([
        AuthProvider.phone(),
        // AuthProvider.google(),
      ]).then((firebaseUser) async {
        setState(() {
          _error = "";
          _user = firebaseUser;
        });
      }).catchError((error) {
        if (error is PlatformException) {
          setState(() {
            if (error.code == FirebaseAuthUi.kUserCancelledError) {
              _error = "User cancelled login";
            } else {
              _error = error.message ?? "Unknown error!";
            }
          });
        }
      });
    } else {
      _logout();
    }
  }

  void _logout() async {
    await FirebaseAuthUi.instance().logout();
    setState(() {
      _user = null;
    });
  }
}
