import 'package:chip_list/chip_list.dart';
import 'package:flutter/material.dart';
import 'package:printdesignadmin/view_model/add_hash_tags.dart';
import 'package:printdesignadmin/widgets.dart';
import 'package:provider/provider.dart';

import '../core/my_theme_data.dart';

class AddHashTag extends StatefulWidget {
  const AddHashTag({Key? key}) : super(key: key);

  @override
  State<AddHashTag> createState() => _AddHashTagState();
}

class _AddHashTagState extends State<AddHashTag> {
  final formKey = GlobalKey<FormState>();
  TextEditingController controller = TextEditingController();
  String? name;
  @override
  Widget build(BuildContext context) {
    double screnHeight = MediaQuery.of(context).size.height;
    double screnWidth = MediaQuery.of(context).size.width;
    AddHashTagsVM addHTprovider = Provider.of(context);
    List<String> data = addHTprovider.hashTags;
    SizedBox nameField = SizedBox(
        width: screnWidth * .5,
        child: TextFormField(
          maxLines: null,
          controller: controller,
          onChanged: (input) async {
            name = input;
            setState(() {});
          },
          validator: (input) {
            String whithOutSpaces = input!.trim();
            if (whithOutSpaces.length < 3) {
              return 'ادخل قيمة صحيحة';
            }
            return null;
          },
          textAlign: TextAlign.center,
          keyboardType: TextInputType.name,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            label: Text(
              'الهاشتاج',
              style: MyThemeData.whiteTS,
            ),
            filled: true,
            contentPadding: const EdgeInsets.all(15),
          ),
        ));

    return Scaffold(
        appBar: Widgets.appBar('الهاشتاج'),
        floatingActionButton: Container(
          decoration: BoxDecoration(
              border: Border.all(
                color: Colors.red,
              ),
              color: Colors.white,
              shape: BoxShape.circle),
          child: IconButton(
              color: Colors.red,
              onPressed: () async {
                await addHTprovider.deleteHashTag();
              },
              icon: const Icon(Icons.delete)),
        ),
        body: addHTprovider.isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(25),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Widgets.vertSpace05(screnHeight),
                        Form(
                          key: formKey,
                          child: Column(
                            children: [
                              nameField,
                              const SizedBox(
                                height: 25,
                              ),
                              MaterialButton(
                                  color: Colors.green,
                                  shape: MyThemeData.matBtnRadius25,
                                  onPressed: () async {
                                    if (formKey.currentState!.validate()) {
                                      await addHTprovider.addHashTag(name!);
                                      controller.text = '';
                                      setState(() {});
                                    }
                                  },
                                  child:
                                      Text('Save', style: MyThemeData.whiteTS))
                            ],
                          ),
                        ),
                        Widgets.vertSpace05(screnHeight),
                        ChipList(
                            extraOnToggle: (index) {
                              addHTprovider.changeSelectedIndex(index);
                            },
                            listOfChipNames: data,
                            shouldWrap: true,
                            activeBgColorList: const [
                              Color.fromARGB(224, 242, 57, 57)
                            ],
                            listOfChipIndicesCurrentlySeclected: [
                              addHTprovider.index != null
                                  ? addHTprovider.index!
                                  : -1
                            ]),
                      ]),
                ),
              ));
  }
}
