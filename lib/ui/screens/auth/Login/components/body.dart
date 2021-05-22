import 'package:flutter/material.dart';
import 'package:smartshop/global.dart';
import 'package:smartshop/ui/screens/auth/Welcome/welcome_screen.dart';
import 'background.dart';
import 'package:smartshop/ui/screens/auth/Signup/signup_screen.dart';
import 'package:smartshop/ui/widgets/already_have_an_account_acheck.dart';
import 'package:smartshop/ui/widgets/rounded_button.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smartshop/ui/screens/home.dart';
import 'package:firebase_auth_ui/firebase_auth_ui.dart';
import 'package:firebase_auth_ui/providers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final _firestore = FirebaseFirestore.instance;
final FirebaseAuth auth = FirebaseAuth.instance;

class Body extends StatefulWidget {
  const Body({
    Key key,
  }) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  FirebaseUser _user;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "LOGIN",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.03),
            SvgPicture.asset(
              "assets/icons/login.svg",
              height: size.height * 0.35,
            ),
            SizedBox(height: size.height * 0.03),
            RoundedButton(
              text: "LOGIN",
              press: () {
                _onActionTapped();
              },
            ),
            SizedBox(height: size.height * 0.03),
            AlreadyHaveAnAccountCheck(
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return SignUpScreen();
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _onActionTapped() async {
    if (auth.currentUser == null) {
      FirebaseAuthUi.instance().launchAuth([
        AuthProvider.phone(),
      ]).then((firebaseUser) async {
        DocumentReference ref =
            _firestore.collection("users").doc("${firebaseUser.uid}");
        await ref.get().then((doc) {
          if (doc.exists) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return WelcomeScreen();
                },
              ),
            );
          } else {
            final snackBar = SnackBar(
              content: Text(
                'User does not exist! Please SignUp',
                style: TextStyle(color: kPrimaryLightColor),
              ),
              backgroundColor: kPrimaryColor,
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return SignUpScreen();
                },
              ),
            );
          }
        });
      });
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return WelcomeScreen();
          },
        ),
      );
    }
  }
}
