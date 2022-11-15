// ignore: file_names
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:printdesignadmin/model/product.dart';

class ProductSV {
  final _db = FirebaseFirestore.instance;
  final String _productsCollectionKey = 'products';
  Future<bool> addProduct(Product newProduct) async {
    Map<String, dynamic> jsonProduct = newProduct.toJson();

    await _db
        .collection(_productsCollectionKey)
        .doc(newProduct.id)
        .set(jsonProduct)
        .then((value) {
      log('from then add');
      return true;
    }).onError((error, stackTrace) {
      log(error.toString());
      return false;
    });
    return false;
  }

  Future<bool> deleteProduct(String id) async {
    var successFlag = false;
    successFlag = await _db
        .collection(_productsCollectionKey)
        .doc(id)
        .delete()
        .then((value) {
      return true;
    });
    return successFlag;
  }

  // Future<List<Product>>
  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>> getProduct() async {
    QuerySnapshot<Map<String, dynamic>> snapShot =
        await _db.collection(_productsCollectionKey).get();
    return snapShot.docs;
  }

  Future<bool> editProdcut(Product newProduct) async {
    Map<String, dynamic> jsonProduct = newProduct.toJson();
    bool isUploadSuccess = false;
    await _db
        .collection(_productsCollectionKey)
        .doc(newProduct.id)
        .set(jsonProduct)
        .then((value) {
      isUploadSuccess = true;
    });
    return isUploadSuccess;
  }
}
