import 'package:flutter/material.dart';
import 'package:printdesignadmin/view_model/affliate.dart';

import '../model/affilate.dart';
import '../core/my_theme_data.dart';

abstract class AffilateWidgets {
  static nameField(AffliateVM affProv, var screnWidth) {
    return TextFormField(
        controller: affProv.nameCon,
        validator: (input) {
          return affProv.nameValidator(input!);
        },
        keyboardType: TextInputType.name,
        decoration: MyThemeData.inputDeco('Name', screnWidth));
  }

  static phoneField(AffliateVM affProv, var screnWidth) {
    return TextFormField(
        controller: affProv.phoneCon,
        validator: (input) {
          if (input!.isNotEmpty) return affProv.phoneValidator(input);
        },
        keyboardType: TextInputType.number,
        decoration: MyThemeData.inputDeco('Phone Number', screnWidth));
  }

  static disField(AffliateVM affProv, var screnWidth) {
    return TextFormField(
        controller: affProv.disCon,
        validator: (input) {
          if (input!.isNotEmpty) return affProv.discountValid(input);
          affProv.disCon.text = '0';
        },
        keyboardType: TextInputType.number,
        decoration: MyThemeData.inputDeco('Discount Percent', screnWidth));
  }

  static whatsField(AffliateVM affProv, var screnWidth) {
    return TextFormField(
        controller: affProv.whatsCon,
        // ignore: body_might_complete_normally_nullable
        validator: (input) {
          if (input!.isNotEmpty) return affProv.phoneValidator(input);
        },
        keyboardType: TextInputType.number,
        decoration: MyThemeData.inputDeco('WhatsApp Number', screnWidth));
  }

  static socialField(AffliateVM affProv, var screnWidth) {
    return TextFormField(
        controller: affProv.socialCon,
        // ignore: body_might_complete_normally_nullable
        validator: (input) {
          if (input!.isNotEmpty) return affProv.socialValidtor(input);
        },
        keyboardType: TextInputType.url,
        decoration: MyThemeData.inputDeco('SocialMedia Account', screnWidth));
  }

  static saveBtn(AffliateVM affProv, GlobalKey<FormState> formKey) {
    return ElevatedButton(
        onPressed: () async {
          if (formKey.currentState!.validate()) {
            await affProv.addAffliate(Affliate(
                name: affProv.nameCon.text,
                code: "Be Neferu ${affProv.lastCode.toString()}",
                discountPercent: double.parse(affProv.disCon.text),
                phone: affProv.phoneCon.text,
                socialMediaLink: affProv.socialCon.text,
                whatsApp: affProv.whatsCon.text));
          }
        },
        child: const Text('Add'));
  }

  static addPersonBottomSheet(BuildContext context,
      GlobalKey<FormState> formKey, AffliateVM affProv, var screnWidth) {
    return showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      //name
                      nameField(affProv, screnWidth)
                      //phone
                      ,
                      phoneField(affProv, screnWidth)
                      //whatsApp
                      ,
                      whatsField(affProv, screnWidth)
                      //socialMedia Account
                      ,
                      socialField(affProv, screnWidth)
                      //discount percent
                      ,
                      disField(affProv, screnWidth),

                      saveBtn(affProv, formKey)
                    ]),
              ),
            ),
          );
        });
  }
}
