import 'package:flutter/material.dart';
import 'package:printdesignadmin/services/ads.dart';
import '../model/ads.dart';

class AdsVM extends ChangeNotifier {
  List<Ad> ads = [];

/////////loading/////////////////
  bool isLoading = false;
  void changeIsLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  AdsVM() {
    getAds();
  }

  void getAds() async {
    changeIsLoading(true);
    ads = await AdsSV().getAds();
    changeIsLoading(false);
  }

////////////add new ad
  String title = '', content = '', url = '';
  void changeTitle(String input) {
    title = input;
  }

  void changeContent(String input) {
    content = input;
  }

  void changeUrl(String input) {
    url = input;
  }

  String editURL(String oldURL) {
    oldURL = oldURL.trim();
    oldURL = oldURL.substring(32, 65);
    return 'https://drive.google.com/uc?export=view&id=$oldURL';
  }

  Future<void> addAd() async {
    if (title == '' || content == '' || url == '') {
    } else {
      changeIsLoading(true);
      Ad newad = Ad(title: title, content: content, imgURL: editURL(url));
      bool isSuccess = await AdsSV().addAd(newad, newad.id);
      if (isSuccess) {
        ads.add(newad);
        title = '';
        content = '';
        url = '';
      }
      changeIsLoading(false);
    }
  }

//////////////////////delete////////////////////////
  Future<void> deleteAd(String id, int index) async {
    changeIsLoading(true);
    bool isSuccess = await AdsSV().deleteAd(id);
    if (isSuccess) {
      ads.removeAt(index);
      isSuccess = false;
      changeIsLoading(false);
    }
  }

//////////edit///////////////////

  Ad? newAd = Ad(title: '', content: '', imgURL: '');

  void changeAd(Ad old) {
    newAd = old;
  }

  void editTitle(String newTitle) {
    if (newAd!.title == newTitle) {
    } else {
      newAd!.title = newTitle;
    }
  }

  void editContent(String newContent) {
    if (newAd!.content == newContent) {
    } else {
      newAd!.content = newContent;
    }
  }

  void editUrl(String newUrl) {
    if (newAd!.imgURL == newUrl) {
    } else {
      newAd!.imgURL = editURL(newUrl);
    }
  }

  Future<void> editAdToFirebase(int index) async {
    changeIsLoading(true);
    bool isSuccess = await AdsSV().addAd(newAd!, newAd!.id);
    if (isSuccess) {
      ads[index] = newAd!;
      newAd!.content = '';
      newAd!.title = '';
      newAd!.imgURL = '';

      isSuccess = false;
    }
    changeIsLoading(false);
  }
}
