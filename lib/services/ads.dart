import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/ads.dart';

class AdsSV {
  final _db = FirebaseFirestore.instance;
  final _adsCollectionKey = 'Ads';

  Future<List<Ad>> getAds() async {
    List<Ad> ads = [];
    await _db.collection(_adsCollectionKey).get().then((res) {
      for (var element in res.docs) {
        Ad ad = Ad.fromJson(element.data());
        ads.add(ad);
      }
    }).onError((error, stackTrace) {
      log(error.toString());
    });
    return ads;
  }

  Future<bool> addAd(Ad newAd, String id) async {
    Map<String, dynamic> adMap = newAd.toJson();
    bool isSuccess = false;
    await _db
        .collection(_adsCollectionKey)
        .doc(id)
        .set(adMap)
        .then((value) => isSuccess = true)
        .onError((error, stackTrace) {
      log(error.toString());
      return false;
    });
    return isSuccess;
  }

  Future<bool> deleteAd(String id) async {
    var successFlag = false;
    successFlag =
        await _db.collection(_adsCollectionKey).doc(id).delete().then((value) {
      return true;
    });
    return successFlag;
  }
}
