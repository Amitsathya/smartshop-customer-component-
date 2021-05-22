import 'package:flutter/material.dart';
import 'package:smartshop/global.dart';
import 'package:smartshop/ui/widgets/counter.dart';
import 'package:smartshop/ui/widgets/rounded_button.dart';
import 'package:provider/provider.dart';
import 'package:smartshop/models/item.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class OrdersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    int total = 0;
    List<CartItem> itemList = Provider.of<List<CartItem>>(context);
    for (int i = 0; i < itemList.length; i++) {
      total += int.parse(itemList[i].price) * int.parse(itemList[i].quantity);
    }
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(
            Icons.chevron_left,
            color: Colors.black,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "My Cart",
          style: TextStyle(fontWeight: FontWeight.w700, color: Colors.black),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 11.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 5.0,
                  ),
                  Expanded(
                    child: ListView(
                      children: <Widget>[
                        ...List.generate(itemList.length, (id) {
                          return ListTile(
                            leading: ClipRRect(
                              borderRadius: BorderRadius.circular(5.0),
                              child: FutureBuilder(
                                future: _getImage(
                                    context, '${itemList[id].barcode}.jpg'),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.done) {
                                    return Container(
                                      width: 100,
                                      height: 100,
                                      child: snapshot.data,
                                    );
                                  }
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return Container(
                                      width: 1,
                                      height: 1,
                                      child: CircularProgressIndicator(),
                                    );
                                  }
                                  return Container();
                                },
                              ),
                            ),
                            title: Text(
                              "${itemList[id].name}",
                              style: Theme.of(context).textTheme.title,
                            ),
                            subtitle: Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 15.0,
                              ),
                              child: Counter(
                                  count: int.parse(itemList[id].quantity),
                                  barcode: itemList[id].barcode,
                                  price: int.parse(itemList[id].price)),
                            ),
                            trailing: Text(
                              "\u{20B9}${int.parse(itemList[id].price) * int.parse(itemList[id].quantity)}",
                              style: Theme.of(context).textTheme.title,
                            ),
                          );
                        }).toList(),
                        itemList.length == 0
                            ? Center(child: Text('No Items Added to Cart'))
                            : SizedBox()
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(15.0),
              color: Colors.grey[100],
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Payment",
                    style: Theme.of(context).textTheme.title,
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 15.0),
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        children: <Widget>[
                          ...List.generate(1, (i) {
                            return Container(
                              padding: const EdgeInsets.all(15.0),
                              margin: const EdgeInsets.only(right: 15),
                              alignment: Alignment.topLeft,
                              width: MediaQuery.of(context).size.width / 3,
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    "**** 4832",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  Spacer(),
                                  Text(
                                    "\u{20B9}${total}",
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                  Image.asset("assets/img/mastercard.png"),
                                ],
                              ),
                            );
                          }),
                          InkWell(
                            onTap: () {},
                            child: Container(
                              margin: const EdgeInsets.symmetric(
                                vertical: 15.0,
                              ),
                              alignment: Alignment.center,
                              width: MediaQuery.of(context).size.width / 3,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5)),
                              child: Icon(Icons.add),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    child: RoundedButton(
                      text: "Confirm Payment",
                      press: () {},
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
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
    return x;
  }
}
