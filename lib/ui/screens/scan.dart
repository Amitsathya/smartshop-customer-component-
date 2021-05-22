import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:smartshop/ui/widgets/productcontainer.dart';

class ScanScreen extends StatefulWidget {
  @override
  _ScanScreenState createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  String barcodeScanRes = 'Unknown';
  @override
  void initState() {
    super.initState();
    this.scan();
  }

  scan() async {}

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        child: Flex(
            direction: Axis.vertical,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Scan result : $barcodeScanRes\n',
                  style: TextStyle(fontSize: 20))
            ]));
  }
}
