import 'package:flutter/material.dart';
import 'package:printdesignadmin/model/product.dart';
import 'package:printdesignadmin/services/products.dart';
import '../model/hash_tags.dart';

String categoryKey = 'category';
String plainOrPrintedKey = 'plainOrPrinted';
String sizeKey = 'size';
String sleeveKey = 'sleeve';
String seasonKey = 'season';

class AddProductsVM extends ChangeNotifier {
  List<String> imgList = [];
  Map<String, List<String>> colorsAndImgURL = {};

  var basicOpt = HashTagsOptions.basicOptions;
  // ignore: non_constant_identifier_names
  var SelbasicOptNum = HashTagsOptions.selBasicOptNum;
  // ignore: non_constant_identifier_names
  var SelbasicOpt = HashTagsOptions.selBasicOpt;

//---- start other options
  List<int> selOptionalNum = [];
  List<String> selOptional = [];
//---- end other options
  bool isLoading = false;
  String? errorMess;

///////////ofers/////////////
  bool hasOffer = false;
  void changeHasOffer(bool value) {
    if (hasOffer != value) {
      if (!value) {
        offerPercent = 0;
        priceAfterOffer = 0;
      }
      hasOffer = value;
    }
    notifyListeners();
  }

  double offerPercent = 0;
  String offerPercentError = '';
  void changeOfferPercent(double percent) {
    if (percent != offerPercent && percent > 0) {
      offerPercentError = '';
      offerPercent = percent;
      calcOfferPrice();
    } else if (percent < 0) {
      offerPercentError = 'النسبة يجب ان تكون موجبة ';
    }
    notifyListeners();
  }

  double priceAfterOffer = 0;
  void calcOfferPrice() {
    if (hasOffer) {
      priceAfterOffer = 0;
      double savedAmount = (price * (offerPercent)) / 100;

      priceAfterOffer = price - savedAmount;

      notifyListeners();
    }
  }

////////////////add sizes list///////
  List<int> selSizesNum = [];

  List<String> sizes = [];
  int isInSizes(String searchForThis) {
    int foundAtIndex = -1;
    if (sizes.isEmpty) {
      return foundAtIndex;
    } else {
      for (int i = 0; i < sizes.length; i++) {
        if (sizes[i] == searchForThis) {
          sizes.removeAt(i);
          foundAtIndex = i;
          break;
        }
      }
    }
    return foundAtIndex;
  }

  void changeSizes(int index, String name) {
    changeIsLoading(true);
    if (isInSizes(name) >= 0) {
    } else {
      sizes.add(name);
    }
    changeIsLoading(false);
  }

  String tempPickedColor = '0xff000000';
  void addTempPickedColor(String pickedColor) {
////if color picked from color pallete
    if (pickedColor.contains('Color(')) {
      //Color(0xffed1010)
      //remove Color(
      tempPickedColor = pickedColor.replaceAll('Color(', '');
      //remove )
      tempPickedColor = tempPickedColor.replaceAll(')', '').replaceAll(' ', '');
    }
    if (pickedColor.contains('#')) {
      tempPickedColor = pickedColor.replaceAll('#', '').replaceAll(' ', '');
    }
  }

  void addImgURL(String imgURL, String pickedColor) {
    if (imgURL.length < 65) {}
    imgURL = editURL(imgURL);
    if (colorsAndImgURL.containsKey(pickedColor)) {
      imgList.add(imgURL);
      colorsAndImgURL[pickedColor] = imgList;
    } else {
      imgList = [];
      imgList.add(imgURL);
      colorsAndImgURL[pickedColor] = imgList;
    }
    notifyListeners();
  }

  String editURL(String oldURL) {
    oldURL = oldURL.trim();
    oldURL = oldURL.substring(32, 65);
    return 'https://drive.google.com/uc?export=view&id=$oldURL';
  }

  Future<Product> makeProduct(String des, String material, String name,
      String sizeGuideImg, double price) async {
    Product newProduct = Product(
        sizes: sizes,
        optionalhashTags: selOptional,
        basicHashTags: SelbasicOpt,
        sizeGuideImg: editURL(sizeGuideImg),
        description: des,
        colorsAndImgURL: colorsAndImgURL,
        material: material,
        name: name,
        price: price,
        hasOffer: hasOffer,
        offerPercent: offerPercent,
        priceAfterOffer: priceAfterOffer);
    await addProduct(newProduct);
    return newProduct;
  }

  dynamic addProduct(Product newProduct) async {
    changeIsLoading(true);

    if (await ProductSV().addProduct(newProduct)) {
      selOptional = [];
      priceAfterOffer = 0;
      offerPercent = 0;
      price = 0;
      hasOffer = false;
      sizes = [];
      changeIsLoading(false);
      return newProduct;
    }
    changeIsLoading(false);
    if (errorMess != '') {
      return errorMess;
    }
  }

  inputValidator(String input) {
    String whithOutSpaces = input.trim();
    if (whithOutSpaces.length < 3) {
      return 'please insert a vaild input';
    }
  }

/////////price
  double price = 0;
  priceValidator(String input) {
    String whithOutSpaces = input.trim();
    if (whithOutSpaces.length < 2) {
      return 'please insert a vaild input';
    }
  }

  void changePrice(String input) {
    price = double.parse(input);
    notifyListeners();
  }

  void changeIsLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  void changeSelOption(String optionKey, int index) {
    //0 men -- 1 women ---  2 child
    SelbasicOpt[optionKey]![0] = basicOpt[optionKey]![index];
    notifyListeners();
  }

  void changeSelOptional(int index, String name) {
    changeIsLoading(true);
    // selOptionalNum.add(index);
    if (isInSelOptional(name) >= 0) {
    } else {
      selOptional.add(name);
    }
    changeIsLoading(false);
  }

  int isInSelOptional(String searchForThis) {
    int foundAtIndex = -1;
    if (selOptional.isEmpty) {
      return foundAtIndex;
    } else {
      for (int i = 0; i < selOptional.length; i++) {
        if (selOptional[i] == searchForThis) {
          selOptional.removeAt(i);
          foundAtIndex = i;
          break;
        }
      }
    }
    return foundAtIndex;
  }
}
