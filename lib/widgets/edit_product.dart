import 'package:chip_list/chip_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:printdesignadmin/view_model/add_products.dart';
import 'package:printdesignadmin/view_model/edit_product.dart';
import '../core/my_theme_data.dart';

abstract class EditWidgets {
  //name field
  static nameField(AddProductsVM addprovider, EditProductVM editPrivider,
      String initValue, var screnWidth) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: TextFormField(
          initialValue: initValue,
          onChanged: (input) {
            if (input != initValue) {
              editPrivider.changeName(input);
            }
          },
          validator: (input) {
            return addprovider.inputValidator(input!);
          },
          keyboardType: TextInputType.name,
          decoration: InputDecoration(
            label: const Text('اسم المنتج'),
            suffix: editPrivider.tempName != ''
                ? Icon(
                    Icons.done,
                    color: Colors.greenAccent[700],
                    size: screnWidth * .07,
                  )
                : null,
            border:
                editPrivider.tempName != '' ? const OutlineInputBorder() : null,
          ),
        ),
      ),
    );
  }

//offer
  static offerPerecentField(EditProductVM editProvider, screnWidth) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: TextFormField(
            initialValue: editProvider.prod.offerPercent.toString(),
            onChanged: (value) {
              editProvider.changeOfferPercent(double.parse(value));
            },
            keyboardType: TextInputType.number,
            decoration:
                MyThemeData.inputDeco('نسبة الخصم', screnWidth).copyWith(
              enabled: editProvider.prod.hasOffer,
            )),
      ),
    );
  }

// make prod has offer or not
  static hasOfferActions(EditProductVM editProvider) {
    return Row(
      children: [
        //right
        IconButton(
            onPressed: () {
              editProvider.changHasOffer(true);
            },
            icon: Icon(
              Icons.done,
              color: editProvider.prod.hasOffer ? Colors.green : Colors.grey,
            )),
        //wrong
        IconButton(
            onPressed: () {
              editProvider.changHasOffer(false);
            },
            icon: Icon(
              Icons.cancel_sharp,
              color: !editProvider.prod.hasOffer ? Colors.green : Colors.grey,
            )),
      ],
    );
  }

  //price field
  static priceField(AddProductsVM addprovider, EditProductVM editPrivider,
      String initValue, var screnWidth) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: TextFormField(
          initialValue: initValue,
          onChanged: (input) {
            if (input != initValue) {
              editPrivider.changePrice(input);
            }
          },
          validator: (input) {
            return addprovider.priceValidator(input!);
          },
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            label: const Text('السعر'),
            suffix: editPrivider.tempPrice != ''
                ? Icon(
                    Icons.done,
                    color: Colors.greenAccent[700],
                    size: screnWidth * .07,
                  )
                : null,
            border: editPrivider.tempPrice != ''
                ? const OutlineInputBorder()
                : null,
          ),
        ),
      ),
    );
  }

//color
  static colorField(
      String color,
      AddProductsVM addprovider,
      var screnWidth,
      screnHeight,
      EditProductVM editProv,
      int colorIndex,
      Function() changeFun) {
//change btn
    changeBtn(var screnWidth, var screnHeight, Function() changeFun) {
      return MaterialButton(
        color: Colors.green,
        elevation: 0,
        padding: const EdgeInsets.symmetric(vertical: 10),
        onPressed: changeFun,
        child: const Text(
          'حفظ',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white),
        ),
      );
    }

//delete btn
    deleteBtn(var screnWidth, var screnHeight, Function() changeFun) {
      return InkWell(
        onTap: changeFun,
        child: Container(
            color: Colors.red,
            height: 45,
            alignment: const Alignment(0, 0),
            child: const Icon(
              Icons.delete,
              color: Colors.white,
            )),
      );
    }

//img
    imgField(EditProductVM editProv, int colorIndex) {
      var imgList = editProv.getImgURLs(color);
      return ListView.builder(
        shrinkWrap: true,
        itemCount: imgList.length,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              //img
              Stack(children: [
                Container(
                  color: Colors.white,
                  height: 100,
                  width: screnWidth * .25,
                  child: Image.network(
                    imgList[index],
                    loadingBuilder: (context, child, loadingProgress) {
                      return child;
                    },
                    fit: BoxFit.fitHeight,
                  ),
                ),
                InkWell(
                  onTap: () {
                    editProv.deleteImg(colorIndex, index);
                  },
                  child: Container(
                    color: Colors.white,
                    child: const Icon(
                      Icons.cancel,
                      color: Colors.red,
                    ),
                  ),
                ),
              ]),
              //text field
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextFormField(
                      maxLines: null,
                      initialValue: imgList[index],
                      onChanged: (input) {
                        if (addprovider.inputValidator(input) == null) {
                          editProv.changeTempUrl(input);
                        }
                      },
                      validator: (input) {
                        return addprovider.inputValidator(input!);
                      },
                      keyboardType: TextInputType.url,
                      decoration:
                          MyThemeData.inputDeco('لينك الصورة', screnWidth),
                    ),
                    changeBtn(screnWidth, screnHeight, () {
                      editProv.addToImgsList(colorIndex);
                    })
                  ],
                ),
              ),
            ],
          );
        },
      );
    }

    newImgField(EditProductVM editProv, int colorIndex) {
      return Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
        //img
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                child: TextFormField(
                  maxLines: null,
                  onChanged: (input) {
                    if (addprovider.inputValidator(input) == null) {
                      editProv.changeTempUrl(input);
                    }
                  },
                  validator: (input) {
                    return addprovider.inputValidator(input!);
                  },
                  textAlign: TextAlign.end,
                  keyboardType: TextInputType.url,
                  decoration:
                      MyThemeData.inputDeco('لينك الصورة الجديدة', screnWidth),
                ),
              ),
              changeBtn(screnWidth, screnHeight, () {
                editProv.addToImgsList(colorIndex);
              })
            ],
          ),
        )
      ]);

      //text field
    }

    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            //color box
            Container(
              height: 47,
              width: screnWidth * .1,
              color: Color(int.parse(color)),
            ),
            //hexa field
            Expanded(
              flex: 1,
              child: TextFormField(
                initialValue: color,
                onChanged: (input) {
                  editProv.addPickedColor(input);
                },
                validator: (input) {
                  return addprovider.inputValidator(input!);
                },
                keyboardType: TextInputType.name,
                decoration: MyThemeData.inputDeco('اللون', screnWidth),
              ),
            ),
            //change and delete
            Expanded(
              child: Row(
                children: [
                  Expanded(
                      flex: 5,
                      child: changeBtn(screnWidth, screnHeight, changeFun)),
                  Expanded(
                      child: deleteBtn(screnWidth, screnHeight, () {
                    editProv.deleteColor(colorIndex);
                  }))
                ],
              ),
            )
          ],
        ),
        ExpansionTile(
          title: const Text("الصور"),
          children: [
            imgField(editProv, colorIndex),
            const SizedBox(
              height: 20,
            ),
            newImgField(editProv, colorIndex)
          ],
        )
      ],
    );
  }

  static showColorPalette(var screnWidth, EditProductVM editProvider) {
    return ExpansionTile(
      title: const Text("تغير اللون "),
      children: [colorPalette(screnWidth, editProvider)],
    );
  }

//color palette
  static colorPalette(var screnWidth, EditProductVM editProvider) {
    return Padding(
      padding: const EdgeInsets.all(30),
      child: ColorPicker(
          displayThumbColor: true,
          pickerColor: Colors.black,
          onColorChanged: (pickedColor) {
            editProvider.addPickedColor(pickedColor.toString());
          }),
    );
  }

//add new color field
  static TextFormField newColorField(TextEditingController colorCon,
      AddProductsVM addprovider, EditProductVM editProv, var screnWidth) {
    return TextFormField(
      maxLines: null,
      controller: colorCon..text = editProv.tempPickedColor,
      onChanged: (input) {
        editProv.changetempPickedColor(input);
        editProv.tempPickedColor = input;
      },
      validator: (input) {
        return addprovider.inputValidator(input!);
      },
      keyboardType: TextInputType.url,
      decoration: MyThemeData.inputDeco('Hexa Color', screnWidth),
    );
  }

//add new imgUrl
  static TextFormField newImg(TextEditingController imgCon, var screnWidth) {
    return TextFormField(
      maxLines: null,
      keyboardType: TextInputType.url,
      controller: imgCon,
      decoration: MyThemeData.inputDeco('Image URL', screnWidth),
    );
  }

//size guide
  static suizeGuideField(AddProductsVM addprovider, EditProductVM editPrivider,
      String initValue, var screnWidth) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextFormField(
          initialValue: initValue,
          onChanged: (input) {
            if (input != initValue) {
              editPrivider.changeSizeGuide(input);
            }
          },
          maxLines: null,
          keyboardType: TextInputType.url,
          decoration: InputDecoration(
            label: const Text('جدول المقاسات'),
            border: editPrivider.tempSizeGuide != ''
                ? const OutlineInputBorder()
                : null,
          )),
    );
  }

//material
  static materialField(
      AddProductsVM addprovider, EditProductVM editPrivider, String initValue) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextFormField(
          maxLines: null,
          initialValue: initValue,
          onChanged: (input) {
            if (input != initValue) {
              editPrivider.changeMaterial(input);
            }
          },
          validator: (input) {
            return addprovider.inputValidator(input!);
          },
          keyboardType: TextInputType.name,
          decoration: InputDecoration(
            label: const Text('الخامة'),
            border: editPrivider.tempMaterial != ''
                ? const OutlineInputBorder()
                : null,
          )),
    );
  }

//description
  static descField(
      AddProductsVM addprovider, EditProductVM editPrivider, String initValue) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextFormField(
          maxLines: null,
          initialValue: initValue,
          onChanged: (input) {
            if (input != initValue) {
              editPrivider.changeDesc(input);
            }
          },
          validator: (input) {
            return addprovider.inputValidator(input!);
          },
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            label: const Text('الوصف'),
            border:
                editPrivider.tempDesc != '' ? const OutlineInputBorder() : null,
          )),
    );
  }

//category
  static ChipList categoryChips(
      AddProductsVM addprovider, EditProductVM editProvider) {
    return ChipList(
        extraOnToggle: (selectedIndex) {
          editProvider.changeBasicHT(categoryKey, selectedIndex);
        },
        listOfChipNames: addprovider.basicOpt[categoryKey]!,
        listOfChipIndicesCurrentlySeclected: editProvider.categIndex);
  }

//plain
  static ChipList plainChips(
      AddProductsVM addprovider, EditProductVM editProvider) {
    return ChipList(
        extraOnToggle: (selectedIndex) {
          editProvider.changeBasicHT(plainOrPrintedKey, selectedIndex);
        },
        listOfChipNames: addprovider.basicOpt[plainOrPrintedKey]!,
        listOfChipIndicesCurrentlySeclected: editProvider.plainIndex);
  }

//sizedChips
  static ChipList sizeChips(
      AddProductsVM addprovider, EditProductVM editProvider) {
    return ChipList(
        extraOnToggle: (selectedIndex) {
          editProvider.changeBasicHT(sizeKey, selectedIndex);
        },
        listOfChipNames: addprovider.basicOpt[sizeKey]!,
        listOfChipIndicesCurrentlySeclected: editProvider.sizeIndex);
  }

//sleeve
  static ChipList sleeveChips(
      AddProductsVM addprovider, EditProductVM editProvider) {
    return ChipList(
        extraOnToggle: (selectedIndex) {
          editProvider.changeBasicHT(sleeveKey, selectedIndex);
        },
        listOfChipNames: addprovider.basicOpt[sleeveKey]!,
        listOfChipIndicesCurrentlySeclected: editProvider.sleeveIndex);
  }

//season
  static ChipList seasonChips(
      AddProductsVM addprovider, EditProductVM editProvider) {
    return ChipList(
        extraOnToggle: (selectedIndex) {
          editProvider.changeBasicHT(seasonKey, selectedIndex);
        },
        listOfChipNames: addprovider.basicOpt[seasonKey]!,
        listOfChipIndicesCurrentlySeclected: editProvider.seasonIndex);
  }

//optional
  static ChipList optionalChips(AddProductsVM addprovider,
      EditProductVM editProvider, List<String> hashTagList) {
    return ChipList(
        shouldWrap: true,
        supportsMultiSelect: true,
        extraOnToggle: (selectedIndex) {
          editProvider.changOptionalHT(selectedIndex);
        },
        listOfChipNames: hashTagList,
        listOfChipIndicesCurrentlySeclected: editProvider.selChipsIndex);
  }

  static sizes(EditProductVM addprovider, List<String> sizesList) {
    return ExpansionTile(
      title: const Text('المقاسات'),
      children: [
        ChipList(
            shouldWrap: true,
            supportsMultiSelect: true,
            extraOnToggle: (selectedIndex) {
              addprovider.changSizes(selectedIndex, sizesList);
            },
            listOfChipNames: sizesList,
            listOfChipIndicesCurrentlySeclected: addprovider.sizesIndex)
      ],
    );
  }

//save btn
  static saveBtn(var screnWidth, EditProductVM editProvider) {
    return MaterialButton(
      padding: MyThemeData.matBtnPadding,
      color: Colors.green,
      shape: MyThemeData.matBtnRadius25,
      onPressed: () {
        editProvider.uploadProduct();
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'تعديل',
            style: TextStyle(color: Colors.white, fontSize: screnWidth * .05),
          ),
        ],
      ),
    );
  }
}
