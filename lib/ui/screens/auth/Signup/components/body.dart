import 'package:flutter/material.dart';
import 'package:smartshop/ui/screens/auth/Login/login_screen.dart';
import 'package:smartshop/ui/screens/auth/Signup/components/background.dart';
import 'package:smartshop/ui/screens/auth/Welcome/welcome_screen.dart';
import 'package:smartshop/ui/widgets/already_have_an_account_acheck.dart';
import 'package:smartshop/ui/widgets/rounded_button.dart';
import 'package:smartshop/ui/widgets/rounded_input_field.dart';
import 'package:firebase_auth_ui/firebase_auth_ui.dart';
import 'package:firebase_auth_ui/providers.dart';
import 'package:flutter_svg/svg.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smartshop/ui/screens/home.dart';
import 'package:smartshop/global.dart';
import 'package:intl/intl.dart';
import 'package:smartshop/global.dart';
import 'package:flutter/cupertino.dart';

final _firestore = FirebaseFirestore.instance;

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

List<String> _test = List<String>();

class _BodyState extends State<Body> {
  String _chosenValue = null;
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "SIGNUP",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.03),
            SvgPicture.asset(
              "assets/icons/signup.svg",
              height: size.height * 0.35,
            ),
            RoundedInputField(
              Controler: firstNameController,
              hintText: "Your First Name",
              onChanged: (value) {
                firstNameController.text = value;
              },
            ),
            RoundedInputField(
              Controler: lastNameController,
              hintText: "Your Last Name",
              onChanged: (value) {
                lastNameController.text = value;
              },
            ),
            RoundedInputField(
              Controler: emailController,
              hintText: "Your Email",
              onChanged: (value) {
                emailController.text = value;
              },
            ),
            RoundedInputField(
              Controler: addressController,
              hintText: "Your Address",
              onChanged: (value) {
                addressController.text = value;
              },
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 45),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(29),
                child: StreamBuilder<QuerySnapshot>(
                    stream: _firestore.collection('stores').snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Center(
                          child: CircularProgressIndicator(
                            backgroundColor: Colors.lightBlueAccent,
                          ),
                        );
                      }
                      final messages = snapshot.data.docs;
                      for (var message in messages) {
                        _test.add(message.data()['name']);
                      }
                      List<Text> pickerItems = [];
                      for (String currency in _test) {
                        pickerItems.add(Text(currency));
                      }
                      return CupertinoPicker(
                        backgroundColor: kPrimaryLightColor,
                        itemExtent: 50,
                        onSelectedItemChanged: (selectedIndex) {
                          setState(() {
                            _chosenValue = _test[selectedIndex];
                            print(_chosenValue);
                          });
                        },
                        children: pickerItems,
                      );
                    }),
              ),
            ),
            RoundedButton(
              text: "SIGNUP",
              press: () {
                _onActionTapped();
              },
            ),
            SizedBox(height: size.height * 0.03),
            AlreadyHaveAnAccountCheck(
              login: false,
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
          ],
        ),
      ),
    );
  }

  void _onActionTapped() async {
    FirebaseAuthUi.instance().launchAuth([
      AuthProvider.phone(),
    ]).then((firebaseUser) async {
      print(firebaseUser.providerId);
      DocumentReference ref =
          _firestore.collection("users").doc("${firebaseUser.uid}");
      await ref.get().then((doc) {
        if (doc.exists) {
          print(true);
          Navigator.pop(context);
          final snackBar = SnackBar(
            content: Text(
              'User exist already! Please Login',
              style: TextStyle(color: kPrimaryLightColor),
            ),
            backgroundColor: kPrimaryColor,
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        } else {
          DateTime now = DateTime.now();
          String formattedDate = DateFormat('yyyy-MM-dd – kk:mm').format(now);
          ref.set({
            'address': addressController.text,
            'emailID': emailController.text,
            'firstName': firstNameController.text,
            'lastName': lastNameController.text,
            'userType': 'customer',
            'createdOn': formattedDate,
            'store': _chosenValue,
          });
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return WelcomeScreen();
              },
            ),
          );
        }
      });
    });
  }
}
