import 'package:chip_list/chip_list.dart';
import 'package:flutter/material.dart';
import 'package:printdesignadmin/view_model/add_products.dart';
import '../core/my_theme_data.dart';

abstract class AddProductsWidgets {
  static TextFormField nameField(TextEditingController nameCon,
      AddProductsVM addprovider, double screnWidth) {
    return TextFormField(
        controller: nameCon,
        maxLines: null,
        validator: (input) {
          return addprovider.inputValidator(input!);
        },
        keyboardType: TextInputType.name,
        decoration: MyThemeData.inputDeco('الاسم', screnWidth));
  }

  static TextFormField offerPerecentField(
      AddProductsVM addProvider, screnWidth) {
    return TextFormField(
        maxLines: null,
        initialValue: addProvider.offerPercent.toString(),
        onChanged: (value) {
          addProvider.changeOfferPercent(double.parse(value));
        },
        keyboardType: TextInputType.number,
        decoration: MyThemeData.inputDeco('نسبة الخصم', screnWidth).copyWith(
            enabled: addProvider.hasOffer,
            errorText: addProvider.offerPercentError != ''
                ? addProvider.offerPercentError
                : null));
  }

  static TextFormField priceField(TextEditingController priceCon,
      AddProductsVM addprovider, double screnWidth) {
    return TextFormField(
        controller: priceCon,
        maxLines: null,
        onChanged: (value) => addprovider.changePrice(value),
        validator: (input) {
          return addprovider.priceValidator(input!);
        },
        keyboardType: TextInputType.number,
        decoration: MyThemeData.inputDeco('السعر', screnWidth));
  }

  static TextFormField imgField(TextEditingController imgCon,
      AddProductsVM addprovider, double screnWidth) {
    return TextFormField(
      maxLines: null,
      controller: imgCon,
      keyboardType: TextInputType.url,
      decoration: MyThemeData.inputDeco('لينك الصورة درايف', screnWidth),
    );
  }

  static TextFormField sizeGuideimgField(TextEditingController sizeGuideimgCon,
      AddProductsVM addprovider, double screnWidth) {
    return TextFormField(
      maxLines: null,
      controller: sizeGuideimgCon,
      keyboardType: TextInputType.url,
      decoration: MyThemeData.inputDeco('صورة جدول المقاسات  ', screnWidth),
    );
  }

  static TextFormField colorField(TextEditingController colorCon,
      AddProductsVM addprovider, double screnWidth) {
    return TextFormField(
      maxLines: null,
      controller: colorCon,
      onChanged: (input) {
        addprovider.addTempPickedColor(input);
      },
      validator: (input) {
        return addprovider.inputValidator(input!);
      },
      keyboardType: TextInputType.url,
      decoration: MyThemeData.inputDeco('اللون بالهيكسا ', screnWidth),
    );
  }

  static TextFormField descField(TextEditingController desCon,
      AddProductsVM addprovider, double screnWidth) {
    return TextFormField(
      maxLines: null,
      controller: desCon,
      validator: (input) {
        return addprovider.inputValidator(input!);
      },
      keyboardType: TextInputType.emailAddress,
      decoration: MyThemeData.inputDeco('الوصف', screnWidth),
    );
  }

  static TextFormField materialField(TextEditingController materialCon,
      AddProductsVM addprovider, double screnWidth) {
    return TextFormField(
      maxLines: null,
      controller: materialCon,
      validator: (input) {
        return addprovider.inputValidator(input!);
      },
      keyboardType: TextInputType.name,
      decoration: MyThemeData.inputDeco('الخامة', screnWidth),
    );
  }

  static ChipList categoryChip(AddProductsVM addprovider) {
    return ChipList(
        extraOnToggle: (selectedIndex) {
          addprovider.changeSelOption(categoryKey, selectedIndex);
        },
        listOfChipNames: addprovider.basicOpt[categoryKey]!,
        listOfChipIndicesCurrentlySeclected:
            addprovider.SelbasicOptNum[categoryKey]!);
  }

  static ChipList printedChip(AddProductsVM addprovider) {
    return ChipList(
        extraOnToggle: (selectedIndex) {
          addprovider.changeSelOption(plainOrPrintedKey, selectedIndex);
        },
        listOfChipNames: addprovider.basicOpt[plainOrPrintedKey]!,
        listOfChipIndicesCurrentlySeclected:
            addprovider.SelbasicOptNum[plainOrPrintedKey]!);
  }

  static ChipList sizeChip(AddProductsVM addprovider) {
    return ChipList(
        extraOnToggle: (selectedIndex) {
          addprovider.changeSelOption(sizeKey, selectedIndex);
        },
        listOfChipNames: addprovider.basicOpt[sizeKey]!,
        listOfChipIndicesCurrentlySeclected:
            addprovider.SelbasicOptNum[sizeKey]!);
  }

  static ChipList seelveChip(AddProductsVM addprovider) {
    return ChipList(
        extraOnToggle: (selectedIndex) {
          addprovider.changeSelOption(sleeveKey, selectedIndex);
        },
        listOfChipNames: addprovider.basicOpt[sleeveKey]!,
        listOfChipIndicesCurrentlySeclected:
            addprovider.SelbasicOptNum[sleeveKey]!);
  }

  static ChipList seasonChip(AddProductsVM addprovider) {
    return ChipList(
        extraOnToggle: (selectedIndex) {
          addprovider.changeSelOption(seasonKey, selectedIndex);
        },
        listOfChipNames: addprovider.basicOpt[seasonKey]!,
        listOfChipIndicesCurrentlySeclected:
            addprovider.SelbasicOptNum[seasonKey]!);
  }

  static ChipList optionalChip(
      AddProductsVM addprovider, List<String> hashTagList) {
    return ChipList(
        shouldWrap: true,
        supportsMultiSelect: true,
        extraOnToggle: (selectedIndex) {
          addprovider.changeSelOptional(
              selectedIndex, hashTagList[selectedIndex]);
        },
        listOfChipNames: hashTagList,
        listOfChipIndicesCurrentlySeclected: addprovider.selOptionalNum);
  }

  static ChipList sizes(AddProductsVM addprovider, List<String> sizesList) {
    return ChipList(
        shouldWrap: true,
        supportsMultiSelect: true,
        extraOnToggle: (selectedIndex) {
          addprovider.changeSizes(selectedIndex, sizesList[selectedIndex]);
        },
        listOfChipNames: sizesList,
        listOfChipIndicesCurrentlySeclected: addprovider.selSizesNum);
  }
}
