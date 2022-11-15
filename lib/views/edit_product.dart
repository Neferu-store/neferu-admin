import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:printdesignadmin/model/product.dart';
import 'package:printdesignadmin/view_model/add_size.dart';
import 'package:printdesignadmin/view_model/edit_product.dart';
import 'package:printdesignadmin/view_model/products.dart';
import 'package:printdesignadmin/widgets/edit_product.dart';
import 'package:provider/provider.dart';
import '../view_model/add_hash_tags.dart';
import '../view_model/add_products.dart';
import '../widgets.dart';

// ignore: must_be_immutable
class EditProduct extends StatefulWidget {
  Product product;

  EditProduct(this.product, {Key? key}) : super(key: key);

  @override
  State<EditProduct> createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  final formKey = GlobalKey<FormState>();
  TextEditingController colorCon = TextEditingController();
  TextEditingController imgCon = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    colorCon.dispose();
    imgCon.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AddProductsVM addprovider = Provider.of(context);
    AddHashTagsVM addHashProvider = Provider.of(context);
    // (dont remove)
    // ignore: unused_local_variable
    ProductsVM productsProvider = Provider.of(context);
    var hashTagList = addHashProvider.hashTags;
    AddSizeVM addSizeProvider = Provider.of(context);
    var sizesList = addSizeProvider.sizes;

    double screnHeight = MediaQuery.of(context).size.height;
    double screnWidth = MediaQuery.of(context).size.width;

    return addSizeProvider.isLoading ||
            productsProvider.isLoading ||
            addSizeProvider.isLoading
        ? Widgets.loading
        : Scaffold(
            appBar: Widgets.appBar(widget.product.name),
            body: ChangeNotifierProvider(
                create: (context) =>
                    EditProductVM(widget.product, hashTagList, sizesList),
                builder: (context, child) {
                  EditProductVM editProvider = Provider.of(context);
                  return editProvider.isLoading
                      ? Widgets.loading
                      : SingleChildScrollView(
                          child: Form(
                          key: formKey,
                          child: Column(children: [
                            ExpansionTile(
                                title: const Text('بيانات المنتج '),
                                children: [
                                  Row(
                                    children: [
                                      //product name
                                      EditWidgets.nameField(
                                          addprovider,
                                          editProvider,
                                          widget.product.name,
                                          screnWidth),
                                      Widgets.space02(screnWidth),
                                      //price
                                      EditWidgets.priceField(
                                          addprovider,
                                          editProvider,
                                          widget.product.price.toString(),
                                          screnWidth),
                                    ],
                                  ), //offer
                                  Row(
                                    children: [
                                      EditWidgets.offerPerecentField(
                                          editProvider, screnWidth),
                                      Widgets.space02(screnWidth),
                                      Padding(
                                        padding: const EdgeInsets.all(25),
                                        child: Column(
                                          children: [
                                            const Text('لديه خصم'),
                                            EditWidgets.hasOfferActions(
                                                editProvider)
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  editProvider.prod.hasOffer
                                      ? Text(
                                          'السعر بعد الخصم ${editProvider.prod.priceAfterOffer}')
                                      : const SizedBox(),
                                  Widgets.vertSpace05(screnHeight),

                                  //size guide
                                  EditWidgets.suizeGuideField(
                                      addprovider,
                                      editProvider,
                                      widget.product.sizeGuideImg,
                                      screnWidth),

                                  //material
                                  EditWidgets.materialField(
                                    addprovider,
                                    editProvider,
                                    widget.product.material,
                                  ),
                                  //product description
                                  EditWidgets.descField(
                                    addprovider,
                                    editProvider,
                                    widget.product.description,
                                  ),
                                ]),

                            EditWidgets.sizes(
                                editProvider, addSizeProvider.sizes),
                            //product img url // color
                            Column(
                              children: [
                                ExpansionTile(
                                  title: const Text('اضافة لون وصور'),
                                  children: [
                                    //add new color img
                                    Column(
                                      children: [
                                        Column(
                                          children: [
                                            EditWidgets.newColorField(
                                                colorCon,
                                                addprovider,
                                                editProvider,
                                                screnWidth),
                                            Widgets.vertSpace05(screnHeight),
                                            //img field
                                            Row(
                                              children: [
                                                Expanded(
                                                    child: EditWidgets.newImg(
                                                        imgCon, screnWidth)),
                                                //add btn
                                                Container(
                                                  decoration:
                                                      const BoxDecoration(
                                                          color: Colors.blue,
                                                          shape:
                                                              BoxShape.circle),
                                                  child: IconButton(
                                                      onPressed: () {
                                                        editProvider
                                                            .addNewColorAndImg(
                                                                imgCon.text);
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
                                            //color picker
                                            Padding(
                                              padding: const EdgeInsets.all(50),
                                              child: ColorPicker(
                                                  pickerColor: Colors.black,
                                                  onColorChanged:
                                                      (pickedColor) {
                                                    colorCon.text =
                                                        pickedColor.toString();
                                                    editProvider
                                                        .changetempPickedColor(
                                                            pickedColor
                                                                .toString());
                                                  }),
                                            ),
                                          ],
                                        )
                                      ],
                                    )
                                  ],
                                ),
                                ExpansionTile(
                                  title: const Text("الالوان والصور القديمة"),
                                  children: [
                                    ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: editProvider.colors.length,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemBuilder: (context, index) {
                                        return Column(
                                          children: [
                                            //color text field
                                            EditWidgets.colorField(
                                                editProvider.colors[index],
                                                addprovider,
                                                screnWidth,
                                                screnHeight,
                                                editProvider,
                                                index, () {
                                              editProvider.changeColor(
                                                  editProvider.colors[index],
                                                  editProvider.pickedColor,
                                                  index);
                                            }),
                                            EditWidgets.showColorPalette(
                                              screnWidth,
                                              editProvider,
                                            ),
                                          ],
                                        );
                                      },
                                    )
                                  ],
                                )
                              ],
                            ),

                            //hashTagsText
                            ExpansionTile(
                              title: const Text("هاشتاج اجباري"),
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    //category
                                    EditWidgets.categoryChips(
                                        addprovider, editProvider),
                                    Widgets.space025(screnHeight),
                                    //printed or plain
                                    EditWidgets.plainChips(
                                        addprovider, editProvider),
                                    Widgets.space025(screnHeight),
                                    //size
                                    EditWidgets.sizeChips(
                                        addprovider, editProvider),
                                    Widgets.space025(screnHeight),
                                    //sleeve
                                    EditWidgets.sleeveChips(
                                        addprovider, editProvider),
                                    Widgets.space025(screnHeight),
                                    //season
                                    EditWidgets.seasonChips(
                                        addprovider, editProvider)
                                  ],
                                ),
//optional hashtags
                              ],
                            ),

                            ExpansionTile(
                              title: const Text('هاشتاج اختياري'),
                              children: [
                                Column(
                                  children: [
                                    EditWidgets.optionalChips(
                                      addprovider,
                                      editProvider,
                                      hashTagList,
                                    ),
                                    Widgets.space025(screnHeight),
                                  ],
                                )
                              ],
                            ),
                            //save btn
                            EditWidgets.saveBtn(screnWidth, editProvider)
                          ]),
                        ));
                }),
          );
  }
}
