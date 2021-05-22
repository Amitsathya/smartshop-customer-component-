import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartshop/models/item.dart';
import 'package:smartshop/services/database.dart';

class Counter extends StatefulWidget {
  int count;
  String barcode;
  int price;
  Counter({Key key, this.count, this.barcode, this.price}) : super(key: key);
  @override
  _CounterState createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  @override
  Widget build(BuildContext context) {
    final count = Provider.of<Count>(context, listen: false);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        GestureDetector(
          onTap: () {
            setState(() {
              widget.count += 1;
              count.updateQuantity(widget.count);
              if (widget.barcode.isNotEmpty) {
                Database("Soumya's Store")
                    .updateCartItems(widget.barcode, widget.count);
              } else {
                count.updateQuantity(widget.count);
              }
            });
          },
          child: Container(
            padding: const EdgeInsets.all(3.0),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(),
            ),
            child: Icon(Icons.add),
          ),
        ),
        SizedBox(width: 15.0),
        Text(
          "${widget.count}",
          style: TextStyle(fontSize: 20),
        ),
        SizedBox(width: 15.0),
        GestureDetector(
          onTap: () {
            setState(() {
              if (widget.count > 1) {
                widget.count -= 1;
                if (widget.barcode != null) {
                  Database("Soumya's Store")
                      .updateCartItems(widget.barcode, widget.count);
                } else {
                  count.updateQuantity(widget.count);
                }
              } else if (widget.barcode.isNotEmpty) {
                Database("Soumya's Store").deleteCartItem(widget.barcode);
              }
            });
          },
          child: Container(
            padding: const EdgeInsets.all(3.0),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(),
            ),
            child: Icon(Icons.remove),
          ),
        ),
      ],
    );
  }
}
