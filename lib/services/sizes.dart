import 'package:cloud_firestore/cloud_firestore.dart';

abstract class SizesSV {
  static var db = FirebaseFirestore.instance;
  static String sizesCollectionKey = 'sizes';
  static Future<List<String>> getSizes() async {
    List<String> sizesNames = [];
    var json = await db.collection(sizesCollectionKey).get();

    for (var docData in json.docs) {
      sizesNames.add(docData.data()['size'].toString());
    }
    return sizesNames;
  }

  static Future<DocumentReference<Map<String, dynamic>>> addSize(
      String value) async {
    Map<String, dynamic> sizeMap = {"size": value};
    var addedHashTag = await db.collection(sizesCollectionKey).add(sizeMap);
    return addedHashTag;
  }

  static Future<bool> deleteHashTag(String name) async {
    String id = '';
    await db
        .collection(sizesCollectionKey)
        .where("size", isEqualTo: name)
        .get()
        .then((data) async {
      id = data.docs[0].id;
    });
    db
        .collection(sizesCollectionKey)
        .doc(id)
        .delete()
        // ignore: void_checks
        .onError((error, stackTrace) {
      return false;
    });
    return true;
  }
}
