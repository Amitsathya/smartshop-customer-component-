import 'package:flutter/material.dart';
import 'package:smartshop/global.dart';
import 'package:smartshop/ui/screens/details.dart';
import 'package:provider/provider.dart';
import 'package:smartshop/models/item.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductContainer extends StatelessWidget {
  final _firestore = FirebaseFirestore.instance;
  final int id;
  String filter;
  final String barcode;
  String store;
  List<String> storeList = [];
  ProductContainer({Key key, this.id, this.filter, this.barcode, this.store})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    List<Item> itemList = Provider.of<List<Item>>(context);
    List<WhishListItem> whishList = Provider.of<List<WhishListItem>>(context);
    List<Item> searchList = [];
    filterList() {
      if (this.barcode != null) {
        for (int j = 0; j < whishList.length; j++) {
          for (int i = 0; i < itemList.length; i++) {
            if (itemList[i]
                .barcode
                .toLowerCase()
                .contains(whishList[j].barcode.toLowerCase())) {
              searchList.add(itemList[i]);
            }
          }
        }
      } else if (filter == null || filter.isEmpty) {
        searchList = itemList;
      } else {
        for (int i = 0; i < itemList.length; i++) {
          if (itemList[i].name.toLowerCase().contains(filter.toLowerCase())) {
            searchList.add(itemList[i]);
          }
        }
      }
    }

    filterList();
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => DetailsScreen(
                  barcode: searchList[id].barcode,
                )),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: kPrimaryLightColor,
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "\u{20B9}${searchList[id].price}",
                style: TextStyle(
                  color: kPrimaryColor,
                ),
              ),
            ),
            SizedBox(
              height: 15.0,
            ),
            Expanded(
              child: FutureBuilder(
                future: _getImage(context, '${searchList[id].barcode}.jpg'),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return Container(
                      width: MediaQuery.of(context).size.width / 1.2,
                      height: MediaQuery.of(context).size.width / 1.2,
                      child: snapshot.data,
                    );
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Container(
                      width: MediaQuery.of(context).size.width / 1.2,
                      height: MediaQuery.of(context).size.width / 1.2,
                      child: CircularProgressIndicator(),
                    );
                  }
                  return Container();
                },
              ),
            ),
            SizedBox(
              height: 15.0,
            ),
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(15.0),
              width: double.infinity,
              decoration: BoxDecoration(
                color: kPrimaryColor,
                borderRadius: BorderRadius.all(
                  Radius.circular(9.0),
                ),
              ),
              child: Text("${searchList[id].name}",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: kPrimaryLightColor,
                  )),
            )
          ],
        ),
      ),
    );
  }

  Future<Widget> _getImage(BuildContext context, String imageName) async {
    Image image;
    await FireStorageService.loadImage(context, imageName).then((value) => {
          image = Image.network(
            value.toString(),
            fit: BoxFit.scaleDown,
            errorBuilder: (BuildContext context, Object exception,
                StackTrace stackTrace) {
              return Text('Your error widget...');
            },
          ),
        });
    return image;
  }
}

class FireStorageService extends ChangeNotifier {
  FireStorageService();
  static Future<dynamic> loadImage(BuildContext context, String Image) async {
    var x = await firebase_storage.FirebaseStorage.instance
        .ref()
        .child('products')
        .child(Image)
        .getDownloadURL();
    // print('a');
    // print(x);
    return x;
  }
}
