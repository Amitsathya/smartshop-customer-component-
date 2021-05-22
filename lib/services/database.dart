import 'dart:async';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:smartshop/models/item.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

final FirebaseAuth auth = FirebaseAuth.instance;

class Database {
  Database(this.uid);
  final String uid;
  final _firestore = FirebaseFirestore.instance;

  Stream<List<Item>> get items {
    return _firestore
        .collection("stores")
        .doc(uid)
        .collection("products")
        .snapshots()
        .map((QuerySnapshot querySnapshot) => querySnapshot.docs
            .map((DocumentSnapshot documentSnapshot) => Item(
                  name: documentSnapshot.data()['name'],
                  type: documentSnapshot.data()['category'],
                  price: documentSnapshot.data()['mrp'],
                  aisle: documentSnapshot.data()['aisle'],
                  barcode: documentSnapshot.data()['barcode'],
                  img: documentSnapshot.data()['productImageLocation'],
                  desc: documentSnapshot.data()['description'],
                ))
            .toList());
  }

  Stream<Store> get store {
    if (auth.currentUser != null) {
      return _firestore
          .collection("users")
          .doc(auth.currentUser?.uid)
          .snapshots()
          .map((event) => Store(storename: event.data()["store"]));
    } else {
      return _firestore
          .collection("users")
          .doc("zRs96ZB8utQN0O8yo468Dhoh2b52")
          .snapshots()
          .map((event) => Store(storename: event.data()["store"]));
    }
  }

  Stream<UID> get itemsInUserDocument {
    return _firestore
        .collection("users")
        .doc('M84KA1oJ6QXsEIncReUpmSGA1y52')
        .snapshots()
        .map((event) => UID(uid: event.data()["store"]));
  }

  Stream<List<CartItem>> get cartitems {
    return _firestore
        .collection("customers")
        .doc(auth.currentUser.uid)
        .collection("cart")
        .snapshots()
        .map((QuerySnapshot querySnapshot) => querySnapshot.docs
            .map((DocumentSnapshot documentSnapshot) => CartItem(
                  name: documentSnapshot.data()['name'],
                  quantity: documentSnapshot.data()['quantity'],
                  price: documentSnapshot.data()['price'],
                  barcode: documentSnapshot.data()['barcode'],
                ))
            .toList());
  }

  Future<void> addCartitems(b, n, p, q) {
    String barcode = b;
    String name = n;
    String price = p;
    String quantity = q;
    var dataMap = Map<String, dynamic>();
    dataMap['barcode'] = b;
    dataMap['name'] = n;
    dataMap['price'] = p;
    dataMap['quantity'] = q;

    _firestore
        .collection("customers")
        .doc(auth.currentUser.uid)
        .collection("cart")
        .doc(barcode)
        .set(dataMap);
  }

  Future<void> updateCartItems(n, q) {
    _firestore
        .collection("customers")
        .doc(auth.currentUser.uid)
        .collection("cart")
        .doc(n)
        .update({'quantity': q.toString()});
    print('Removed ${n} to CartItem');
  }

  Future<void> deleteCartItem(n) {
    _firestore
        .collection("customers")
        .doc(auth.currentUser.uid)
        .collection("cart")
        .doc(n)
        .delete();
    print('Deleted ${n} to CartItem');
  }

  //TODO: sa
  Future<void> saveOrder(n) {
    _firestore
        .collection("customers")
        .doc(auth.currentUser.uid)
        .collection("past")
        .doc(n)
        .delete();
    print('Deleted ${n} to CartItem');
  }

  //TODO: sa
  Future<void> deleteCart() {
    _firestore
        .collection("customers")
        .doc(auth.currentUser.uid)
        .collection("cart")
        .snapshots()
        .forEach((element) {
      for (QueryDocumentSnapshot snapshot in element.docs) {
        snapshot.reference.delete();
      }
    });
  }

  Stream<List<WhishListItem>> get whishlistitems {
    return _firestore
        .collection("customers")
        .doc(auth.currentUser.uid)
        .collection("whishlist")
        .snapshots()
        .map((QuerySnapshot querySnapshot) => querySnapshot.docs
            .map((DocumentSnapshot documentSnapshot) => WhishListItem(
                  barcode: documentSnapshot.data()['barcode'],
                ))
            .toList());
  }

  Future<void> addWhishListitems(b) {
    String barcode = b;
    var dataMap = Map<String, dynamic>();
    dataMap['barcode'] = b;
    _firestore
        .collection("customers")
        .doc(auth.currentUser.uid)
        .collection("whishlist")
        .doc(b)
        .set(dataMap);
    print('Added ${b} to Whishlist');
  }

  Future<void> deleteWhishListitems(b) {
    String barcode = b;
    var dataMap = Map<String, dynamic>();
    dataMap['barcode'] = b;
    _firestore
        .collection("customers")
        .doc(auth.currentUser.uid)
        .collection("whishlist")
        .doc(b)
        .delete();
    print('Removed ${b} to Whishlist');
  }

//TODO: sa
  Future<void> deleteWhisht() {
    _firestore
        .collection("customers")
        .doc(auth.currentUser.uid)
        .collection("whishlist")
        .snapshots()
        .forEach((element) {
      for (QueryDocumentSnapshot snapshot in element.docs) {
        snapshot.reference.delete();
      }
    });
  }
}
