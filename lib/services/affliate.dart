import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:printdesignadmin/model/affilate.dart';

abstract class AffliateSV {
  static var db = FirebaseFirestore.instance;
  static String affliateCollectionKey = 'Affliate';
  static String affilatePersonsColKey = 'AffliatePersons';
  static String lastCodeKey = 'lastCode';

////////last code function///////////////
  ///Be Neferu(last  code)
  static Future<LastCode> getLastCode() async {
    var addedPerson =
        await db.collection(affliateCollectionKey).doc(lastCodeKey).get();
    return LastCode.fromJson(addedPerson.data()!);
  }

  static Future<bool> updateLastCode(int codeValue) async {
    var json = LastCode(codeValue).toJson();
    bool isSuccess = false;
    await db
        .collection(affliateCollectionKey)
        .doc(lastCodeKey)
        .update(json)
        .then((value) => isSuccess = true);
    return isSuccess;
  }

//get all affilates////////////////////////////////////////
  static Future<List<Affliate>> getAffilate() async {
    List<Affliate> affilatteList = [];
    await db.collection(affilatePersonsColKey).get().then((res) {
      for (var element in res.docs) {
        Affliate person = Affliate.fromJson(element.data());

        affilatteList.add(person);
      }
    }).onError((error, stackTrace) {
      log(error.toString());
    });
    return affilatteList;
  }

  static Future<bool> addPerson(Affliate newPerson, int lastCode) async {
    Map<String, dynamic> personMap = newPerson.toJson();
    bool isSuccess = false;
    await db
        .collection(affilatePersonsColKey)
        .doc("Be Neferu ${lastCode.toString()}")
        .set(personMap)
        .then((value) => isSuccess = true);
    return isSuccess;
  }

  static Future<bool> deletePerson(String id) async {
    bool isSuccess = false;
    await db.collection(affilatePersonsColKey).doc(id).delete().then((value) {
      isSuccess = true;
    });
    return isSuccess;
  }
}
