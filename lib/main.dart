import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:printdesignadmin/core/my_theme_data.dart';
import 'package:printdesignadmin/view_model/add_hash_tags.dart';
import 'package:printdesignadmin/view_model/add_products.dart';
import 'package:printdesignadmin/view_model/add_size.dart';
import 'package:printdesignadmin/view_model/orders.dart';
import 'package:printdesignadmin/view_model/products.dart';
import 'package:printdesignadmin/views/saplsh.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => AddProductsVM(),
          ),
          ChangeNotifierProvider(
            create: (context) => AddHashTagsVM(),
          ),
          ChangeNotifierProvider(
            create: (context) => AddSizeVM(),
          ),
          ChangeNotifierProvider(
            create: (context) => ProductsVM(),
          ),
          ChangeNotifierProvider(
            create: (context) => OrdersVM(),
          )
        ],
        builder: (context, child) {
          return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Neferu Admin',
              theme: MyThemeData.myTheme,
              home: const Scaffold(
                body: Splash(),
              ));
        });
  }
}
