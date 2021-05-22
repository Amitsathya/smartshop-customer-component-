import 'dart:async';

import 'package:flutter/cupertino.dart';

class Item {
  String name;
  String aisle;
  String type;
  String price;
  String barcode;
  String img;
  String desc;
  Item(
      {this.name,
      this.aisle,
      this.type,
      this.price,
      this.barcode,
      this.img,
      this.desc});
}

class CartItem {
  String name;
  String price;
  String barcode;
  String quantity;
  CartItem({this.name, this.quantity, this.price, this.barcode});
}

class WhishListItem {
  String barcode;
  WhishListItem({this.barcode});
}

class Count extends ChangeNotifier {
  int quantity = 1;
  void updateQuantity(int newquant) {
    quantity = newquant;
    notifyListeners();
  }
}

class Store {
  String storename;
  Store({this.storename});
}

class UID {
  String uid;
  UID({this.uid});
}
