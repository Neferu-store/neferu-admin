import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:printdesignadmin/core/my_theme_data.dart';
import 'package:printdesignadmin/view_model/orders.dart';
import 'package:printdesignadmin/views/ads.dart';
import 'package:printdesignadmin/views/affliate.dart';
import 'package:printdesignadmin/views/orders/orders.dart';
import 'package:printdesignadmin/views/products.dart';
import 'package:printdesignadmin/views/sizes.dart';
import 'package:printdesignadmin/widgets.dart';
import 'package:provider/provider.dart';

import '../model/order.dart';
import 'add_hash_tag.dart';

class OurDrawer extends StatelessWidget {
  const OurDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screnWidth = MediaQuery.of(context).size.width;
    double screnHeight = MediaQuery.of(context).size.height;
    OrdersVM ordersProvider = Provider.of(context);
    List<PaidOrder> ordersList = ordersProvider.orders;
    return Scaffold(
      appBar: Widgets.appBar("Neferu", arabic: false),
      body: Container(
        alignment: const Alignment(0, 0),
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Column(
            children: [
              drawerRow(screnHeight, screnWidth, context, () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Orders()));
              }, 'الاوردرات'),
              Widgets.verSizedBox35,
              drawerRow(screnHeight, screnWidth, context, () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AddHashTag()));
              }, 'هاشتاج'),
              Widgets.verSizedBox35,
              drawerRow(screnHeight, screnWidth, context, () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Products()));
              }, 'المنتجات'),
              Widgets.verSizedBox35,
              drawerRow(screnHeight, screnWidth, context, () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AddAffliate(ordersList)));
              }, 'المسوقين'),
              Widgets.verSizedBox35,
              drawerRow(screnHeight, screnWidth, context, () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Ads()));
              }, 'الاعلانات'),
              Widgets.verSizedBox35,
              drawerRow(screnHeight, screnWidth, context, () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const AddSize()));
              }, 'المقاسات')
            ],
          ),
        ),
      ),
    );
  }

  drawerRow(var screnHeight, var screnWidth, BuildContext context,
      Function() navigateFun, var content) {
    return Container(
        alignment: const Alignment(0, 0),
        height: 70,
        width: screnWidth,
        color: primaryColor,
        child: InkWell(
            onTap: navigateFun,
            child: Text(content, style: MyThemeData.drawerTS)));
  }
}
