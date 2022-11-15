import 'dart:developer';

import 'package:flutter/cupertino.dart';
import '../model/product.dart';
import '../services/products.dart';

class ProductsVM extends ChangeNotifier {
  List<Product> productsList = [];
  bool isLoading = false;
  String errorMess = '';
  List<String> colorsHexaList = [];
  List<dynamic> imgURLsList = [];

  ProductsVM() {
    getAllProducts();
    print('object');
  }

  String getFirstImg(int index) {
    String firstColor = productsList[index].colorsAndImgURL.keys.first;
    return productsList[index].colorsAndImgURL[firstColor][0];
  }

  void changeIsLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  Future<dynamic> getAllProducts() async {
    changeIsLoading(true);
    var res = await ProductSV().getProduct().then((snapShotList) {
      for (var i = 0; i < snapShotList.length; i++) {
        var jsonn = snapShotList[i].data();
        productsList.add(Product.fromJson(jsonn));
      }
    }).onError((error, stackTrace) {
      errorMess = error.toString();
      log(errorMess.toString());
    });
    changeIsLoading(false);
    if (errorMess != '') {
      return errorMess;
    }
    return res;
  }

  void deleteProduct(String id) async {
    changeIsLoading(true);
    await ProductSV().deleteProduct(id);
    if (await ProductSV().deleteProduct(id)) {
      productsList.removeWhere((element) => element.id == id);
    }
    changeIsLoading(false);
  }

//when add a new product
  void updataProducts(Product newProduct) {
    productsList.add(newProduct);
    updateColorsList(newProduct);
    updateImgsList(newProduct);
  }

  void updateColorsList(Product newProduct) {
    changeIsLoading(true);
    colorsHexaList.addAll(newProduct.colorsAndImgURL.keys);
    changeIsLoading(false);
  }

  void updateImgsList(Product newProduct) {
    changeIsLoading(true);
    imgURLsList.addAll(newProduct.colorsAndImgURL.keys);
    changeIsLoading(false);
  }
}
