import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:printdesignadmin/model/hash_tags.dart';
import 'package:printdesignadmin/services/hash_tags.dart';

class AddHashTagsVM extends ChangeNotifier {
  List<String> hashTags = [];
  bool isLoading = false;
  String? errorMess;

  AddHashTagsVM() {
    getHashTags();
  }

  void changeIsLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  getHashTags() async {
    changeIsLoading(true);
    hashTags = await HasghTagsSV.getHashTags();
    changeIsLoading(false);
  }

  Future<DocumentReference<Map<String, dynamic>>> addHashTag(
      String name) async {
    changeIsLoading(true);

    OptionalHashTags newHashTag = OptionalHashTags(name: name);
    var res = await HasghTagsSV.addHashTag(newHashTag);
    hashTags.add(name);
    changeIsLoading(false);
    return res;
  }

//////////////delete//////////
  int? index;
  changeSelectedIndex(int clickedIndex) {
    index = clickedIndex;
    notifyListeners();
  }

  deleteHashTag() async {
    if (index == null) {
    } else {
      changeIsLoading(true);
      if (await HasghTagsSV.deleteHashTag(hashTags[index!])) {
        hashTags.removeWhere((element) => element == hashTags[index!]);
      }
      changeIsLoading(false);
    }
  }
}
