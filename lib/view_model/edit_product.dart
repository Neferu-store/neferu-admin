import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:printdesignadmin/model/hash_tags.dart';
import 'package:printdesignadmin/model/product.dart';
import 'package:printdesignadmin/services/products.dart';
import 'package:printdesignadmin/view_model/add_products.dart';

class EditProductVM extends ChangeNotifier {
  Product prod;
  List<String> hashTags;
  List<String> sizesList;

  EditProductVM(this.prod, this.hashTags, this.sizesList) {
    getSelIndexForSizes();
    getSelIndexForChips();
    getCategoryIndexForChips();
    getPrintedIndexForChips();
    getSeasonIndexForChips();
    getSizedIndexForChips();
    getSleeveIndexForChips();
    getColors();
  }

////////////start loading functions/////////////
  bool isLoading = false;
  void changeIsLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  void setIsLoadingFalseDelaye() {
    Future.delayed(const Duration(milliseconds: 50)).then((value) {
      changeIsLoading(false);
    });
  }
////////////end loading functions/////////////

  var basicHashTags = HashTagsOptions.basicOptions;
  String tempUrl = '';
  List<dynamic> imgList = [];
  List<int> selChipsIndex = [];
  List<int> categIndex = [];
  List<int> plainIndex = [];
  List<int> sizeIndex = [];
  List<int> sizesIndex = [];
  List<int> sleeveIndex = [];
  List<int> seasonIndex = [];
  List<String> colors = [];
  String pickedColor = '';

// to make a green border on text form field and done icon//
//to make the user know which value has been changed///
  String tempName = '';
  String tempPrice = '';
  String tempMaterial = '';
  String tempDesc = '';

/////////start HASH TAGS////////////////
//--to know the selected hash tages----//
  void getSelIndexForSizes() {
    var selSizes = prod.sizes;
    for (int i = 0; i < selSizes.length; i++) {
      var index = sizesList.indexWhere((size) => size == selSizes[i]);

      sizesIndex.add(index);
    }
    notifyListeners();
  }

  void getSelIndexForChips() {
    var selHashTags = prod.optionalhashTags;
    for (int i = 0; i < selHashTags.length; i++) {
      var index = hashTags.indexWhere((hashtag) => hashtag == selHashTags[i]);
      selChipsIndex.add(index);
    }
    notifyListeners();
  }

  void getCategoryIndexForChips() {
    var selHashTags = prod.basicHashTags[categoryKey];
    var hashTags = basicHashTags[categoryKey];

    var index = hashTags!.indexWhere((hashtag) => hashtag == selHashTags[0]);
    categIndex.add(index);
    notifyListeners();
  }

  void getPrintedIndexForChips() {
    var selHashTags = prod.basicHashTags[plainOrPrintedKey];
    var hashTags = basicHashTags[plainOrPrintedKey];
    var index = hashTags!.indexWhere((hashtag) => hashtag == selHashTags[0]);
    plainIndex.add(index);
    notifyListeners();
  }

  void getSizedIndexForChips() {
    var selHashTags = prod.basicHashTags[sizeKey];
    var hashTags = basicHashTags[sizeKey];
    var index = hashTags!.indexWhere((hashtag) => hashtag == selHashTags[0]);
    sizeIndex.add(index);
    notifyListeners();
  }

  void getSleeveIndexForChips() {
    var selHashTags = prod.basicHashTags[sleeveKey];
    var hashTags = basicHashTags[sleeveKey];
    var index = hashTags!.indexWhere((hashtag) => hashtag == selHashTags[0]);
    sleeveIndex.add(index);
    notifyListeners();
  }

  void getSeasonIndexForChips() {
    var selHashTags = prod.basicHashTags[seasonKey];
    var hashTags = basicHashTags[seasonKey];

    var index = hashTags!.indexWhere((hashtag) => hashtag == selHashTags[0]);

    seasonIndex.add(index);

    notifyListeners();
  }

  void changeBasicHT(String hashTagsKey, int selectedIndex) {
    prod.basicHashTags[hashTagsKey] = [
      basicHashTags[hashTagsKey]![selectedIndex]
    ];
    notifyListeners();
  }

  void changSizes(int seletedIndex, List<String> sizesList) {
    if (prod.sizes.contains(sizesList[seletedIndex])) {
      prod.sizes.remove(sizesList[seletedIndex]);
    } else {
      prod.sizes.add(sizesList[seletedIndex]);
    }
    notifyListeners();
  }

  void changOptionalHT(int seletedIndex) {
    if (prod.optionalhashTags.contains(hashTags[seletedIndex])) {
      prod.optionalhashTags.remove(hashTags[seletedIndex]);
    } else {
      prod.optionalhashTags.add(hashTags[seletedIndex]);
    }
    notifyListeners();
  }
/////////end HASH TAGS////////////////

//--change original values in prod-----------------//
  void changeName(String newName) {
    prod.name = newName;
    tempName = newName;
    notifyListeners();
  }

  void changHasOffer(bool value) {
    prod.hasOffer = value;
    if (!value) {
      prod.offerPercent = 0;
      prod.priceAfterOffer = prod.price;
    }
    notifyListeners();
  }

  String offerPercentError = '';
  void changeOfferPercent(double percent) {
    if (percent != prod.offerPercent && percent > 0) {
      offerPercentError = '';
      prod.offerPercent = percent;
      calcOfferPrice();
    } else if (percent < 0) {
      offerPercentError = 'النسبة يجب ان تكون موجبة ';
    }
    notifyListeners();
  }

  void calcOfferPrice() {
    if (prod.hasOffer) {
      double savedAmount = (prod.price * (prod.offerPercent)) / 100;
      prod.priceAfterOffer = prod.price - savedAmount;

      notifyListeners();
    }
  }

  void changePrice(String newPrice) {
    prod.price = double.parse(newPrice);
    tempPrice = newPrice;
    notifyListeners();
  }

  String tempSizeGuide = '';
  void changeSizeGuide(String newUrl) {
    prod.sizeGuideImg = editURL(newUrl);
    tempSizeGuide = newUrl;
    notifyListeners();
  }

  void changeMaterial(String newMaterial) {
    prod.material = newMaterial;
    tempMaterial = newMaterial;
    notifyListeners();
  }

  void changeDesc(String newDesc) {
    prod.description = newDesc;
    tempDesc = newDesc;
    notifyListeners();
  }

///////// start hexa colors section////////////////
  void getColors() {
    colors.addAll(prod.colorsAndImgURL.keys);
  }

//convert from color(0xff) => 0xff
//covert from #1111111 => 0xff1111111
  String cutTheColorToInt(String pickedColor) {
    pickedColor = pickedColor.trim();
    if (pickedColor.contains('Color')) {
      return pickedColor
          .replaceAll('Color(', '')
          .replaceAll(')', '')
          .replaceAll(' ', '');
    } else if (pickedColor.startsWith('#')) {
      pickedColor = pickedColor.replaceAll('#', '0xff').replaceAll(' ', '');
      return pickedColor;
    }
    return '0xff0000';
  }

//when notifey listeners the color picker will not move
  void addPickedColor(String picked) {
    pickedColor = cutTheColorToInt(picked);
  }

  void changeColor(String oldColor, String newColor, int index) {
    if (newColor == oldColor ||
        pickedColor.isEmpty ||
        !colors.contains(oldColor)) {
    } else {
      //take the img list
      List<dynamic> tempImgList = prod.colorsAndImgURL[oldColor];
      //remove the entire entry
      prod.colorsAndImgURL.remove(oldColor);
      //make a new entry with the new color as key and the old img list
      prod.colorsAndImgURL[newColor] = tempImgList;
      colors[index] = newColor;
      changeIsLoading(true);
    }
    //the initial value in color field will not change untill the widget rebuild and list view will not rebuild the conent
    Future.delayed(const Duration(milliseconds: 50)).then((value) {
      changeIsLoading(false);
    });
  }

//-- get the color key to be used in the map
  String getColorKeyByIndex(int colorIndex) {
    return colors[colorIndex];
  }

  void deleteColor(int colorIndex) {
    changeIsLoading(true);
    String colorKey = getColorKeyByIndex(colorIndex);
    prod.colorsAndImgURL.remove(colorKey);
    colors.removeAt(colorIndex);
    setIsLoadingFalseDelaye();
  }

  String tempPickedColor = '';

  void changetempPickedColor(String pickedcolor) {
    tempPickedColor = pickedcolor;
  }

  void addNewColorAndImg(String newURL) {
    if (tempPickedColor != '') {
      newURL = editURL(newURL);
      changeIsLoading(true);
      String colorKey = cutTheColorToInt(tempPickedColor);
      // ignore: unnecessary_null_comparison

      if (prod.colorsAndImgURL.containsKey(colorKey)) {
        List<dynamic> imgList = prod.colorsAndImgURL[colorKey];
        if (imgList.contains(newURL)) {
        } else {
          imgList.add(newURL);
        }
        imgList = [];
      } else {
        List<dynamic> imgList = [newURL];
        prod.colorsAndImgURL[colorKey] = imgList;
      }
      setIsLoadingFalseDelaye();
      imgList = [];
    }
  }
/////////////end hexa colors section/////////////

/////////////start img url /////////////////////
  List<dynamic> getImgURLs(String color) {
    imgList = [];
    imgList.addAll(prod.colorsAndImgURL[color]);
    return imgList;
  }

  void changeTempUrl(String newUrl) {
    tempUrl = newUrl;
    notifyListeners();
  }

  String editURL(String oldURL) {
    oldURL = oldURL.trim();
    oldURL = oldURL.substring(32, 65);
    return 'https://drive.google.com/uc?export=view&id=$oldURL';
  }

  void addToImgsList(int colorIndex) {
    changeIsLoading(true);
    tempUrl = editURL(tempUrl);
    //get index of the color
    String colorKey = getColorKeyByIndex(colorIndex);
    List<dynamic> imgList = prod.colorsAndImgURL[colorKey];
    ///////////////////////////////////////
    if (imgList.contains(tempUrl)) {
    } else {
      log("message");
      imgList.add(tempUrl);
      log("message");
    }
    imgList = [];
    setIsLoadingFalseDelaye();
  }

  void changImgUrl(int colorIndex, String newUrl, int index) {
    changeIsLoading(true);
    newUrl = editURL(newUrl);
    //get index of the old url
    String colorKey = getColorKeyByIndex(colorIndex);

    imgList = prod.colorsAndImgURL[colorKey];
    imgList[index] = newUrl;
    //change the url list value
    prod.colorsAndImgURL[colorKey] = imgList;
    //the initial value in color field will not change untill the widget rebuild and list view will not rebuild the conent
    imgList = [];
    setIsLoadingFalseDelaye();
  }

  void deleteImg(int colorIndex, int index) {
    changeIsLoading(true);
    //get index of the old url
    String colorKey = getColorKeyByIndex(colorIndex);

    imgList = prod.colorsAndImgURL[colorKey];
    imgList.removeAt(index);
    //change the url list value
    prod.colorsAndImgURL[colorKey] = imgList;
    //the initial value in color field will not change untill the widget rebuild and list view will not rebuild the conent
    imgList = [];
    setIsLoadingFalseDelaye();
  }

/////////////end img url /////////////////////

/////////upload to firebase//////////////////
  uploadProduct() async {
    changeIsLoading(true);
    await ProductSV().editProdcut(prod);
    changeIsLoading(false);
  }

//////////////show and un show widgets////////////////

//1-show color and img section
  bool colorVisible = false;
  void changeColorVisible() {
    colorVisible = !colorVisible;
    notifyListeners();
  }

//2- show img urls section
  bool showImgUrlsSection = false;
  void changeShowImgUrls() {
    showImgUrlsSection = !showImgUrlsSection;
    notifyListeners();
  }

//3-show color palette section
  bool showColorPaletteSection = false;
  void changeshowColorPalette() {
    showColorPaletteSection = !showColorPaletteSection;
    notifyListeners();
  }

//4-show old color section
  bool showOldColorSec = false;
  void changeshowOldColorSec() {
    showOldColorSec = !showOldColorSec;
    notifyListeners();
  }

//5-show add color sec
  bool showAddColorSec = false;
  void changeshowAddColorSec() {
    showAddColorSec = !showAddColorSec;
    notifyListeners();
  }

//6-show basic hashTags
  bool basicVisible = false;
  void changebasicVisible() {
    basicVisible = !basicVisible;
    notifyListeners();
  }

//7-show optional hashTags
  bool optionalVisible = false;
  void changeOptionalHTvisivle() {
    optionalVisible = !optionalVisible;
    notifyListeners();
  }
}
