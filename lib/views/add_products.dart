import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:printdesignadmin/core/my_theme_data.dart';
import 'package:printdesignadmin/model/product.dart';
import 'package:printdesignadmin/view_model/add_hash_tags.dart';
import 'package:printdesignadmin/view_model/add_products.dart';
import 'package:printdesignadmin/view_model/add_size.dart';
import 'package:printdesignadmin/view_model/products.dart';
import 'package:printdesignadmin/widgets/add_products.dart';
import 'package:provider/provider.dart';
import '../widgets.dart';

class AddProducts extends StatefulWidget {
  const AddProducts({Key? key}) : super(key: key);

  @override
  State<AddProducts> createState() => _AddProductsState();
}

class _AddProductsState extends State<AddProducts> {
  final formKey = GlobalKey<FormState>();
  TextEditingController nameCon = TextEditingController();
  TextEditingController priceCon = TextEditingController();
  TextEditingController imgCon = TextEditingController();
  TextEditingController colorCon = TextEditingController();
  TextEditingController desCon = TextEditingController();
  TextEditingController sizeGuideimgCon = TextEditingController();
  TextEditingController materialCon = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    nameCon.dispose();
    priceCon.dispose();
    imgCon.dispose();
    sizeGuideimgCon.dispose();
    colorCon.dispose();
    desCon.dispose();
    materialCon.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AddProductsVM addprovider = Provider.of(context);
    //to get hash tags
    AddHashTagsVM addHashProvider = Provider.of(context);
    ProductsVM productsProvider = Provider.of(context);
    var hashTagList = addHashProvider.hashTags;
    AddSizeVM addSizeProvider = Provider.of(context);
    double screnHeight = MediaQuery.of(context).size.height;
    double screnWidth = MediaQuery.of(context).size.width;

    return addprovider.isLoading
        ? Widgets.loading
        : Scaffold(
            appBar: Widgets.appBar("منتج جديد"),
            body: SingleChildScrollView(
                child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Form(
                            key: formKey,
                            child: Column(children: [
                              ExpansionTile(
                                title: const Text('بيانات المنتج '),
                                children: [
                                  //product name
                                  Row(
                                    children: [
                                      //price
                                      Expanded(
                                          child: AddProductsWidgets.priceField(
                                              priceCon,
                                              addprovider,
                                              screnWidth)),
                                      Widgets.space02(screnWidth),
                                      Expanded(
                                          child: AddProductsWidgets.nameField(
                                              nameCon,
                                              addprovider,
                                              screnWidth)),
                                    ],
                                  ),
                                  //offer
                                  Row(
                                    children: [
                                      Expanded(
                                          child: AddProductsWidgets
                                              .offerPerecentField(
                                                  addprovider, screnWidth)),
                                      Widgets.space02(screnWidth),
                                      Padding(
                                        padding: const EdgeInsets.all(25),
                                        child: Column(
                                          children: [
                                            const Text('لديه خصم'),
                                            hasOfferActions(addprovider)
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  addprovider.hasOffer
                                      ? Text(
                                          'السعر بعد الخصم ${addprovider.priceAfterOffer}')
                                      : const SizedBox(),

                                  //sizeGuide
                                  AddProductsWidgets.sizeGuideimgField(
                                      sizeGuideimgCon, addprovider, screnWidth),
                                  //material
                                  AddProductsWidgets.materialField(
                                      materialCon, addprovider, screnWidth),
                                  //product description
                                  AddProductsWidgets.descField(
                                      desCon, addprovider, screnWidth),
                                ],
                              ),

                              ExpansionTile(
                                title: const Text('المقاسات'),
                                children: [
                                  AddProductsWidgets.sizes(
                                      addprovider, addSizeProvider.sizes)
                                ],
                              ),

                              ExpansionTile(
                                title: const Text('الالوان والصور'),
                                children: [
                                  AddProductsWidgets.colorField(
                                      colorCon, addprovider, screnWidth),
                                  Row(
                                    children: [
                                      Expanded(
                                          child: AddProductsWidgets.imgField(
                                              imgCon, addprovider, screnWidth)),
                                      Container(
                                        decoration: BoxDecoration(
                                            color: Colors.blue,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(
                                                    screnWidth * .5))),
                                        child: IconButton(
                                            onPressed: () {
                                              addprovider.addImgURL(imgCon.text,
                                                  addprovider.tempPickedColor);
                                              imgCon.text = '';
                                              setState(() {});
                                            },
                                            icon: const Icon(
                                              Icons.add,
                                              color: Colors.white,
                                            )),
                                      )
                                    ],
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(screnWidth * .1),
                                    child: ColorPicker(
                                        displayThumbColor: true,
                                        pickerColor: Colors.black,
                                        onColorChanged: (pickedColor) {
                                          pickedColor = pickedColor;
                                          addprovider.addTempPickedColor(
                                              pickedColor.toString());
                                          colorCon.text = addprovider
                                              .tempPickedColor
                                              .toString();
                                        }),
                                  )
                                ],
                              ),
                              //product img url // color

                              //hashTagsText
                              ExpansionTile(
                                title: const Text('هاشتاج اجباري'),
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      //category
                                      AddProductsWidgets.categoryChip(
                                          addprovider),
                                      Widgets.space025(screnHeight),
                                      //printed or plain
                                      AddProductsWidgets.printedChip(
                                          addprovider),
                                      Widgets.space025(screnHeight),
                                      //size
                                      AddProductsWidgets.sizeChip(addprovider),
                                      Widgets.space025(screnHeight),
                                      //sleeve
                                      AddProductsWidgets.seelveChip(
                                          addprovider),
                                      Widgets.space025(screnHeight),
                                      //season
                                      AddProductsWidgets.seasonChip(addprovider)
                                    ],
                                  )
                                ],
                              ),

                              ExpansionTile(
                                title: const Text("هاشتاج اختياري"),
                                children: [
                                  Column(
                                    children: [
                                      AddProductsWidgets.optionalChip(
                                          addprovider, hashTagList),
                                      Widgets.space025(screnHeight),
                                    ],
                                  )
                                ],
                              ),

                              MaterialButton(
                                padding: MyThemeData.matBtnPadding,
                                color: Colors.green,
                                shape: MyThemeData.matBtnRadius25,
                                onPressed: () async {
                                  if (formKey.currentState!.validate()) {
                                    Product newProduct =
                                        await addprovider.makeProduct(
                                            desCon.text,
                                            materialCon.text,
                                            nameCon.text,
                                            sizeGuideimgCon.text,
                                            double.parse(priceCon.text));
                                    productsProvider.updataProducts(newProduct);
                                    desCon.text = '';
                                    imgCon.text = '';
                                    sizeGuideimgCon.text = '';
                                    materialCon.text = '';
                                    nameCon.text = '';
                                    priceCon.text = '';
                                    colorCon.text = '';
                                    setState(() {});
                                  }
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Text(
                                      'Save',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20),
                                    ),
                                  ],
                                ),
                              ),
                            ]),
                          )
                        ]))),
          );
  }
}

hasOfferActions(AddProductsVM addprovider) {
  return Row(
    children: [
      //right
      IconButton(
          onPressed: () {
            addprovider.changeHasOffer(true);
          },
          icon: Icon(
            Icons.done,
            color: addprovider.hasOffer ? Colors.green : Colors.grey,
          )),
      //wrong
      IconButton(
          onPressed: () {
            addprovider.changeHasOffer(false);
          },
          icon: Icon(
            Icons.cancel_sharp,
            color: !addprovider.hasOffer ? Colors.green : Colors.grey,
          )),
    ],
  );
}
