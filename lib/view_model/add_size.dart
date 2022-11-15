import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import '../services/sizes.dart';

class AddSizeVM extends ChangeNotifier {
  List<String> sizes = [];
  bool isLoading = false;
  String? errorMess;

  AddSizeVM() {
    getSizes();
  }

  void changeIsLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  getSizes() async {
    changeIsLoading(true);
    sizes = await SizesSV.getSizes();
    changeIsLoading(false);
  }

  Future<DocumentReference<Map<String, dynamic>>> addSize(String name) async {
    changeIsLoading(true);

    var res = await SizesSV.addSize(name);
    sizes.add(name);
    changeIsLoading(false);
    return res;
  }

////////////////////////select size to delete////////////////////
  int? index;
  changeSelectedIndex(int clickedIndex) {
    index = clickedIndex;
    notifyListeners();
  }

  deleteHashTag() async {
    if (index == null) {
    } else {
      changeIsLoading(true);
      if (await SizesSV.deleteHashTag(sizes[index!])) {
        sizes.removeWhere((element) => element == sizes[index!]);
      }
      changeIsLoading(false);
    }
  }
}
