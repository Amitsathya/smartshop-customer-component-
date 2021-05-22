import 'package:flutter/material.dart';
import 'package:smartshop/global.dart';
import 'package:smartshop/services/database.dart';
import 'package:smartshop/ui/widgets/counter.dart';
import 'package:smartshop/ui/widgets/rounded_button.dart';
import 'package:provider/provider.dart';
import 'package:smartshop/models/item.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class DetailsScreen extends StatefulWidget {
  int id;
  final String barcode;
  DetailsScreen({Key key, this.id, this.barcode}) : super(key: key);
  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  IconData _icon = Icons.favorite_border;

  @override
  Widget build(BuildContext context) {
    List<Item> itemList = Provider.of<List<Item>>(context);
    List<WhishListItem> whishList = Provider.of<List<WhishListItem>>(context);
    if (widget.barcode != null) {
      for (int i = 0; i < itemList.length; i++) {
        if (itemList[i].barcode == widget.barcode) {
          widget.id = i;
        }
      }
    }
    // for (int i = 0; i < whishList.length; i++) {
    //   if (itemList[i].barcode == widget.barcode) {
    //     widget.id = i;
    //   }
    // }
    if ((whishList.singleWhere((it) => it.barcode == widget.barcode,
            orElse: () => null)) !=
        null) {
      setState(() {
        print('f');
        _icon = Icons.favorite;
      });
    } else {
      setState(() {
        print('f');
        _icon = Icons.favorite_border;
      });
    }

    return SafeArea(child: Consumer<Count>(builder: (context, count, child) {
      return Scaffold(
        backgroundColor: kPrimaryColor,
        body: Column(
          children: <Widget>[
            Expanded(
              child: Stack(
                children: <Widget>[
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        IconButton(
                          icon: Icon(
                            Icons.chevron_left,
                          ),
                          onPressed: () => {
                            Navigator.pop(context),
                            count.updateQuantity(1),
                          },
                        ),
                        IconButton(
                            icon: Icon(
                              Icons.shopping_basket,
                            ),
                            onPressed: () =>
                                Navigator.pushNamed(context, 'orderscreen')),
                      ],
                    ),
                  ),
                  SizedBox(
                    child: Container(
                      width: double.infinity,
                      alignment: Alignment.center,
                      child: Hero(
                        tag: '${widget.id}',
                        child: FutureBuilder(
                          future: _getImage(context, '${widget.barcode}.jpg'),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.done) {
                              return Container(
                                width: MediaQuery.of(context).size.width / 1.2,
                                height: MediaQuery.of(context).size.width / 1.2,
                                child: snapshot.data,
                              );
                            }
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
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
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25.0),
                    topRight: Radius.circular(25.0),
                  ),
                ),
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            "${itemList[widget.id].name}",
                            style: Theme.of(context).textTheme.display1,
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            _icon,
                            color: Colors.red,
                          ),
                          onPressed: () {
                            setState(() {
                              if (_icon == Icons.favorite) {
                                setState(() {
                                  _icon = Icons.favorite_border;
                                });
                                Database("Soumya's Store").deleteWhishListitems(
                                    itemList[widget.id].barcode);
                                final snackBar = SnackBar(
                                  content: Text(
                                    'Item removed from Whishlist',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(color: kPrimaryColor),
                                  ),
                                  backgroundColor: kPrimaryLightColor,
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              } else if (_icon == Icons.favorite_border) {
                                setState(() {
                                  _icon = Icons.favorite;
                                });
                                Database("Soumya's Store").addWhishListitems(
                                    itemList[widget.id].barcode);
                                final snackBar = SnackBar(
                                  content: Text(
                                    'Item added to Whishlist',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(color: kPrimaryColor),
                                  ),
                                  backgroundColor: kPrimaryLightColor,
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              }
                            });
                          },
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Aisle: ${itemList[widget.id].aisle}",
                          style: Theme.of(context).textTheme.title,
                        ),
                        Text(
                          'Type: ${itemList[widget.id].type}',
                          style: Theme.of(context).textTheme.title,
                        )
                      ],
                    ),
                    Text(
                      "Description",
                      style: Theme.of(context).textTheme.title,
                    ),
                    Text(
                      "${itemList[widget.id].desc}",
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Counter(
                          count: count.quantity,
                        ),
                        Text(
                          "\u{20B9}${int.parse(itemList[widget.id].price) * count.quantity}",
                          style: Theme.of(context).textTheme.title,
                        ),
                      ],
                    ),
                    Container(
                      width: double.infinity,
                      child: RoundedButton(
                        text: "Add to Cart",
                        press: () {
                          Database("Soumya's store").addCartitems(
                              itemList[widget.id].barcode,
                              itemList[widget.id].name,
                              itemList[widget.id].price,
                              count.quantity.toString());
                          Navigator.pop(context);
                          count.updateQuantity(1);
                          final snackBar = SnackBar(
                            content: Text(
                              'Item added to Cart',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: kPrimaryColor,
                              ),
                            ),
                            backgroundColor: kPrimaryLightColor,
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        },
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      );
    }));
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
