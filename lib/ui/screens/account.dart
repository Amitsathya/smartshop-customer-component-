import 'package:flutter/material.dart';
import 'package:smartshop/services/database.dart';
import 'package:smartshop/ui/widgets/rounded_button.dart';
import 'package:smartshop/ui/widgets/rounded_input_field.dart';
import 'package:firebase_auth_ui/firebase_auth_ui.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:smartshop/global.dart';
import 'package:flutter/cupertino.dart';

final _firestore = FirebaseFirestore.instance;
final FirebaseAuth auth = FirebaseAuth.instance;

class AccountScreen extends StatefulWidget {
  @override
  _AccountScreenState createState() => _AccountScreenState();
}

List<String> _test = List<String>();

class _AccountScreenState extends State<AccountScreen> {
  FirebaseUser _user;
  String _chosenValue = null;
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final addressController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final initialStore = TextEditingController();
  @override
  void initState() {
    super.initState();
    phoneNumberController.text = auth.currentUser?.phoneNumber;
    _firestore
        .collection("users")
        .doc("${auth.currentUser?.uid}")
        .get()
        .then((value) {
      firstNameController.text = value.data()["firstName"];
      lastNameController.text = value.data()["lastName"];
      emailController.text = value.data()["emailID"];
      addressController.text = value.data()["address"];
      initialStore.text = value.data()["store"];
    });
  }

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    int index = 2;
    _firestore
        .collection("users")
        .doc(auth.currentUser.uid)
        .get()
        .then((value) {
      print(value.data()["store"]);
    });
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.blueAccent,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.title),
            title: Text("Home"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border),
            title: Text("Whishlist"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            title: Text("User Settings"),
          ),
        ],
        onTap: (value) => {
          if (value == 0)
            {Navigator.pushNamed(context, 'home')}
          else if (value == 1)
            {Navigator.pushNamed(context, 'whishlist')},
        },
      ),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black54),
        backgroundColor: Color(0xfff9f9f9),
        elevation: 0.0,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(
            Icons.chevron_left,
            color: Colors.black,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('data'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              auth.signOut();
              Navigator.pushNamed(context, 'welcomescreen');
            },
          ),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "ACCOUNT DETAILS",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: size.height * 0.03),
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
              RoundedInputField(
                Controler: phoneNumberController,
                hintText: "Your Mobile Number",
                readonly: true,
                onChanged: (value) {
                  phoneNumberController.text = value;
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
                        _test = _test.toSet().toList();
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
                            });
                          },
                          children: pickerItems,
                        );
                      }),
                ),
              ),
              RoundedButton(
                text: "EDIT",
                press: () {
                  if (_chosenValue == initialStore.text) {
                    final snackBar = SnackBar(
                      content: Text(
                        'User details updated successfully',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: kPrimaryColor),
                      ),
                      backgroundColor: kPrimaryLightColor,
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  } else {
                    Database("Soumya's Store").deleteCart();
                    Database("Soumya's Store").deleteWhisht();
                    final snackBar = SnackBar(
                      content: Text(
                        'User details updated successfully.\n Store change recognized, please clear the app',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: kPrimaryColor),
                      ),
                      backgroundColor: kPrimaryLightColor,
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                  _firestore
                      .collection('users')
                      .doc(auth.currentUser?.uid)
                      .update({
                    'address': addressController.text,
                    'emailID': emailController.text,
                    'firstName': firstNameController.text,
                    'lastName': lastNameController.text,
                    'store': _chosenValue,
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
