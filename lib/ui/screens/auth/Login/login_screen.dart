import 'package:flutter/material.dart';
import 'package:smartshop/ui/screens/auth/Login/components/body.dart';

import 'package:provider/provider.dart';
import 'package:smartshop/models/item.dart';
import 'package:smartshop/services/database.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
    );
  }
}
