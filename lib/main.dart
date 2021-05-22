import 'package:flutter/material.dart';
import 'package:smartshop/ui/screens/auth/Welcome/welcome_screen.dart';
import 'package:smartshop/ui/screens/home.dart';
import 'package:smartshop/ui/screens/orders.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:smartshop/ui/screens/account.dart';
import 'package:provider/provider.dart';
import 'package:smartshop/models/item.dart';
import 'package:smartshop/services/database.dart';
import 'package:smartshop/ui/screens/whishlist.dart';
import 'package:smartshop/ui/screens/auth/login.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  // Ensure that Firebase is initialized
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize Firebase
  await Firebase.initializeApp();
  runApp(MyApp());
}

final FirebaseAuth auth = FirebaseAuth.instance;

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // return StreamProvider<UID>.value(
    //     value: Database("Soumya's Store").itemsInUserDocument,
    //     child: Consumer<UID>(builder: (context, test, __) {
    //       if (test == null) {
    //         return MaterialApp(
    //           debugShowCheckedModeBanner: false,
    //           theme: ThemeData.dark(),
    //           title: 'Sendr',
    //           home: LoginScreen(),
    //         );
    //       } else {
    return StreamProvider<Store>.value(
        value: Database("Soumya's Store").store,
        child: Consumer<Store>(builder: (context, user, __) {
          if (user == null) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Flutter Demo',
              theme: ThemeData(
                primarySwatch: Colors.blue,
                fontFamily: 'OpenSans',
              ),
              home: WelcomeScreen(),
              routes: {
                'orderscreen': (ctx) => OrdersScreen(),
                'welcomescreen': (ctx) => WelcomeScreen(),
                'account': (ctx) => AccountScreen(),
                'home': (ctx) => HomeScreen(),
                'whishlist': (ctx) => WhishList()
              },
            );
          } else {
            return MultiProvider(
                providers: [
                  StreamProvider<List<Item>>(
                      create: (BuildContext context) =>
                          Database(user.storename).items,
                      child: HomeScreen()),
                  StreamProvider<List<CartItem>>(
                      create: (BuildContext context) =>
                          Database(user.storename).cartitems,
                      child: HomeScreen()),
                  StreamProvider<List<WhishListItem>>(
                      create: (BuildContext context) =>
                          Database(user.storename).whishlistitems,
                      child: HomeScreen()),
                  ChangeNotifierProvider<Count>(
                    create: (context) => Count(),
                    child: HomeScreen(),
                  ),
                ],
                child: MaterialApp(
                  debugShowCheckedModeBanner: false,
                  title: 'Flutter Demo',
                  theme: ThemeData(
                    primarySwatch: Colors.blue,
                    fontFamily: 'OpenSans',
                  ),
                  home: WelcomeScreen(),
                  routes: {
                    'orderscreen': (ctx) => OrdersScreen(),
                    'welcomescreen': (ctx) => WelcomeScreen(),
                    'account': (ctx) => AccountScreen(),
                    'home': (ctx) => HomeScreen(),
                    'whishlist': (ctx) => WhishList()
                  },
                ));
          }
        }));
  }
  // }));
  // }
}
// ChangeNotifierProvider<Store>(
// create: (context) => Store(),
// child: LoginScreen(),
// ),
