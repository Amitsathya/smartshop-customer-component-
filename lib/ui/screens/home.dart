import 'dart:async';

import 'package:flutter/material.dart';
import 'package:smartshop/global.dart';
import 'package:smartshop/models/item.dart';
import 'package:smartshop/ui/widgets/categorycontainer.dart';
import 'package:smartshop/ui/widgets/productcontainer.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:smartshop/ui/screens/details.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

final _firestore = FirebaseFirestore.instance;

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  String filtervalue = null;
  int completed = 0;
  int filterLength = 0;
  int z = 1;
  Widget build(BuildContext context) {
    List<Item> itemList = Provider.of<List<Item>>(context);
    final count = Provider.of<Count>(context, listen: false);
    return Scaffold(
      backgroundColor: Color(0xfff9f9f9),
      bottomNavigationBar: BottomNavigationBar(
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
                if (value == 1)
                  {Navigator.pushNamed(context, 'whishlist')}
                else if (value == 2)
                  {Navigator.pushNamed(context, 'account')},
              }),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black54),
        backgroundColor: Color(0xfff9f9f9),
        elevation: 0.0,
        automaticallyImplyLeading: false,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.camera_alt),
            onPressed: () async {
              String x = await FlutterBarcodeScanner.scanBarcode(
                  '#6F35A5', 'CANCEL_BUTTON_TEXT', true, ScanMode.BARCODE);
              z = 1;
              for (int i = 0; i < itemList.length; i++) {
                if (itemList[i].barcode.contains(x)) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DetailsScreen(barcode: x)),
                  );
                  z++;
                }
              }
              if (z == 1) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Item does not exist!"),
                  ),
                );
              }
            },
          ),
          IconButton(
            icon: Icon(Icons.shopping_basket),
            onPressed: () {
              Navigator.pushNamed(context, 'orderscreen');
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: [
                Image.asset(
                  'assets/img/logo.PNG',
                  height: 80,
                  width: 80,
                ),
                SizedBox(
                  width: 5,
                ),
                Column(
                  children: [
                    Text(
                      "Smart",
                      style: TextStyle(
                        fontWeight: FontWeight.w200,
                        fontSize: 40,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      "Shop",
                      style: TextStyle(
                        height: .9,
                        fontSize: 40,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            TextField(
                autofocus: false,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  border: InputBorder.none,
                  prefixIcon: Icon(Icons.search),
                  hintText: "Search",
                ),
                onChanged: (text) {
                  setState(() {
                    filtervalue = text;
                    if (filtervalue.isNotEmpty) {
                      filterLength = 0;
                      for (int i = 0; i < itemList.length; i++) {
                        if (itemList[i]
                            .name
                            .toLowerCase()
                            .contains(filtervalue.toLowerCase())) {
                          filterLength += 1;
                        }
                      }
                    } else {
                      filtervalue = null;
                      filterLength = 0;
                    }
                  });
                }),
            SizedBox(
              height: 15,
            ),
            // Container(
            //   height: 81,
            //   child: CategoryContainer(),
            // ),
            SizedBox(
              height: 15,
            ),
            // Text(
            //   "Snacks",
            //   style: TextStyle(
            //     fontWeight: FontWeight.w400,
            //     color: kPrimaryColor,
            //   ),
            // ),
            SizedBox(
              height: 11,
            ),
            filtervalue != null && filterLength == 0
                ? Center(
                    child: Text(
                    "${filtervalue} item doesn't exist",
                  ))
                : SizedBox(),
            GridView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                  childAspectRatio: .7),
              itemCount: filtervalue == null ? itemList.length : filterLength,
              itemBuilder: (BuildContext context, int index) {
                return ProductContainer(
                  id: index,
                  filter: filtervalue,
                );
              },
            )
          ],
        ),
      ),
    );
  }

  // Future getData() async {
  //   if (completed == 0) {
  //     await _firestore.collection('stores').get().then((querySnapshot) {
  //       querySnapshot.docs.forEach((result) {
  //         _firestore
  //             .collection('stores')
  //             .doc()
  //             .collection('details')
  //             .snapshots()
  //             .map((QuerySnapshot querySnapshot) => querySnapshot.docs.map(
  //                 (DocumentSnapshot documentSnapshot) =>
  //                     _test.add(documentSnapshot.data()['name'])));
  //       });
  //       completed += 1;
  //     });
  //     return Future.delayed(Duration(seconds: 1)).then((value) => true);
  //   } else {
  //     print(_test);
  //     return true;
  //   }
  // }
}
