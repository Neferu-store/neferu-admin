import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:printdesignadmin/model/order.dart';

import '../model/product.dart';

class OrdersSV {
  /////////////ORDERS////////////////////////
  Future<List<PaidOrder>> getOrders(Map<String, dynamic> finalOrder) async {
    List<PaidOrder> ordersList = [];

    var response = await FirebaseDatabase.instance.ref().get();

    for (var order in response.children) {
      if (order.ref.key!.startsWith('Neferu Order')) {
        var resMap = order.value;
        ordersList.add(PaidOrder.fromJson({"body": resMap}));
      }
    }

    return ordersList;
  }

  final _db = FirebaseFirestore.instance;
  final String _productsCollectionKey = 'products';
//////////////////order items//////////////////////
  Future<List<Product>> getProducts(List<Order> orders) async {
    List<Product> orderProducts = [];
    for (var order in orders) {
      await _db
          .collection(_productsCollectionKey)
          .doc(order.productId)
          .get()
          .then((value) {
        Product product = Product.fromJson(value.data()!);
        orderProducts.add(product);
      });
    }
    return orderProducts;
  }

  //////////////DELETE/////////////////////
  Future<bool> deleteOrders(String id) async {
    bool isSuccess = false;

    await FirebaseDatabase.instance.ref(id).remove().then((value) {
      isSuccess = true;
    });

    return isSuccess;
  }

  //////////////Edit/////////////////////
  Future<bool> editOrderStatus(String id, String newStatus) async {
    bool isSuccess = false;

    await FirebaseDatabase.instance
        .ref(id)
        .update({"order_status": newStatus}).then((value) {
      isSuccess = true;
    });

    return isSuccess;
  }
}
