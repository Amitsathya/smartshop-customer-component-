import 'package:flutter/material.dart';
import 'package:smartshop/ui/screens/auth/Login/login_screen.dart';
import 'package:smartshop/ui/screens/auth/Signup/signup_screen.dart';
import 'package:smartshop/ui/screens/auth/Welcome/components/background.dart';
import 'package:smartshop/ui/widgets/rounded_button.dart';
import 'package:smartshop/global.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:firebase_auth/firebase_auth.dart';

final FirebaseAuth auth = FirebaseAuth.instance;

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // This size provide us total height and width of our screen
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Image.asset(
            //   "assets/img/logo.PNG",
            //   height: 80,
            //   width: 80,
            // ),
            Text(
              "Welcome to Smart",
              style: TextStyle(
                height: .9,
                fontSize: 40,
              ),
            ),
            Text(
              "Shop",
              style: TextStyle(
                height: .9,
                fontSize: 40,
              ),
            ),
            SizedBox(height: size.height * 0.01),
            SvgPicture.asset(
              "assets/icons/home.svg",
              height: size.height * 0.45,
            ),
            SizedBox(height: size.height * 0.05),
            RoundedButton(
              text: "HOME",
              color: kPrimaryLightColor,
              textColor: Colors.black,
              press: () {
                if (auth.currentUser != null) {
                  Navigator.pushNamed(context, 'home');
                } else {
                  final snackBar = SnackBar(
                    content: Text(
                      'Please Login',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: kPrimaryLightColor),
                    ),
                    backgroundColor: kPrimaryColor,
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
              },
            ),
            RoundedButton(
              text: "LOGIN",
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return LoginScreen();
                    },
                  ),
                );
              },
            ),
            RoundedButton(
              text: "SIGN UP",
              color: kPrimaryLightColor,
              textColor: Colors.black,
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
}
