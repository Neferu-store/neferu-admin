import 'package:flutter/cupertino.dart';
import 'package:printdesignadmin/model/affilate.dart';
import 'package:printdesignadmin/services/affliate.dart';

import '../model/order.dart';

class AffliateVM extends ChangeNotifier {
  List<Affliate> affliates = [];
  late List<PaidOrder> ordersList;
  int lastCode = 0;

  AffliateVM({required this.ordersList}) {
    getLastCode();
    getAffilates();
  }
  //////input controllers
  ///dont forget to search for dispose
  TextEditingController nameCon = TextEditingController();
  TextEditingController phoneCon = TextEditingController();
  TextEditingController whatsCon = TextEditingController();
  TextEditingController socialCon = TextEditingController();
  TextEditingController disCon = TextEditingController();

  /////loading////////
  bool isLoading = false;
  void changeIsLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  // List<Affliate> affilatesList = [];
////get all affilates///////
  void getAffilates() async {
    changeIsLoading(true);
    affliates = await AffliateSV.getAffilate();
    for (var order in ordersList) {
      if (order.promoCode.replaceAll(" ", "") != "") {
        int foundAtIndex = affliates.indexWhere((person) {
          return person.code == order.promoCode;
        });
        affliates[foundAtIndex].orderNum++;
        affliates[foundAtIndex].totalAmount += order.totalPrice / 100;
      }
    }
    changeIsLoading(false);
  }

////////Affliate///////////////////////////////
  Future<bool> addAffliate(Affliate newPerson) async {
    changeIsLoading(true);
    bool isSuccess = false;
    await AffliateSV.addPerson(newPerson, lastCode).then((value) async {
      affliates.add(newPerson);
      await updateCode();
      clearAffilatteBottomSheet();
      isSuccess = true;
    });
    changeIsLoading(false);
    return isSuccess;
  }

////get last code (first method compiled)//////
  void getLastCode() async {
    changeIsLoading(true);
    var res = await AffliateSV.getLastCode();
    lastCode = res.value;
    changeIsLoading(false);
  }

  Future<bool> updateCode() async {
    lastCode++;
    return await AffliateSV.updateLastCode(lastCode);
  }

////////delete///
  void deletePerson(String id) async {
    changeIsLoading(true);
    bool isSuccess = await AffliateSV.deletePerson(id);
    if (isSuccess) {
      affliates.removeWhere((element) => element.code == id);
    }
    changeIsLoading(false);
  }

//////validate input//////////////////////////
  ///1-name
  nameValidator(String name) {
    name = name.replaceAll(' ', '');
    if (name.isEmpty || name.length < 3) {
      return 'the name must contain at least 3 letters.';
    }
  }

//2-phone and whats app validator
  phoneValidator(String phone) {
    phone = phone.replaceAll(' ', '');
    if (phone.isNotEmpty && (phone.length < 11 || !phone.startsWith('01'))) {
      return 'the phone number must contain 11 numbers.';
    }
  }

//3-social media validation
  socialValidtor(String link) {
    link = link.replaceAll(' ', '');
    if (link.isNotEmpty && (!link.startsWith('http') || link.length < 10)) {
      return 'enter a valid link';
    }
  }

//4-discount validator
  discountValid(String percent) {
    percent = percent.replaceAll(' ', '');
    if (percent.isNotEmpty) {
      double num = double.parse(percent);
      if (num < 0) {
        return 'the value must be positive';
      }
    }
  }

//clear content of bottom sheet
  void clearAffilatteBottomSheet() {
    nameCon.text = '';
    phoneCon.text = '';
    whatsCon.text = '';
    disCon.text = '';
    socialCon.text = '';
    notifyListeners();
  }

////show widgets
//1-bottom sheet
  bool showBottomSheet = false;
  void changeShowBottomSheet() {
    showBottomSheet = !showBottomSheet;
    notifyListeners();
  }
}
