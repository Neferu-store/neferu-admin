import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:printdesignadmin/model/hash_tags.dart';

abstract class HasghTagsSV {
  static var db = FirebaseFirestore.instance;
  static String hashTagCollectionKey = 'hashTags';
  static Future<List<String>> getHashTags() async {
    List<String> hashTagNames = [];
    var json = await db.collection('hashTags').get();
    for (var map in json.docs) {
      OptionalHashTags hashTagName = OptionalHashTags.fromJson(map.data());
      hashTagNames.add(hashTagName.name);
    }
    return hashTagNames;
  }

  static Future<DocumentReference<Map<String, dynamic>>> addHashTag(
      OptionalHashTags newHashTag) async {
    Map<String, dynamic> hashTagMap = newHashTag.toJson();
    var addedHashTag =
        await db.collection(hashTagCollectionKey).add(hashTagMap);
    return addedHashTag;
  }

  static Future<bool> deleteHashTag(String name) async {
    String id = '';
    await db
        .collection(hashTagCollectionKey)
        .where("name", isEqualTo: name)
        .get()
        .then((data) async {
      id = data.docs[0].id;
    });
    db
        .collection(hashTagCollectionKey)
        .doc(id)
        .delete()
        // ignore: void_checks
        .onError((error, stackTrace) {
      return false;
    });
    return true;
  }
}
