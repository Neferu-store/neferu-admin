import 'package:chip_list/chip_list.dart';
import 'package:flutter/material.dart';
import 'package:printdesignadmin/core/my_theme_data.dart';
import 'package:printdesignadmin/view_model/add_size.dart';
import 'package:printdesignadmin/widgets.dart';
import 'package:provider/provider.dart';

class AddSize extends StatefulWidget {
  const AddSize({Key? key}) : super(key: key);

  @override
  State<AddSize> createState() => _AddSizeState();
}

class _AddSizeState extends State<AddSize> {
  final formKey = GlobalKey<FormState>();
  TextEditingController controller = TextEditingController();
  String? name;
  @override
  Widget build(BuildContext context) {
    double screnHeight = MediaQuery.of(context).size.height;
    double screnWidth = MediaQuery.of(context).size.width;
    AddSizeVM addSizesprovider = Provider.of(context);
    List<String> data = addSizesprovider.sizes;
    SizedBox nameField = SizedBox(
        width: screnWidth * .5,
        child: TextFormField(
          textAlign: TextAlign.center,
          controller: controller,
          onChanged: (input) async {
            name = input;
            setState(() {});
          },
          validator: (input) {
            String whithOutSpaces = input!.trim();
            if (whithOutSpaces.isEmpty) {
              return 'ادخل قيمة ';
            }
            return null;
          },
          keyboardType: TextInputType.name,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            label: Text(
              'المقاس',
              style: MyThemeData.whiteTS,
              textAlign: TextAlign.center,
            ),
            filled: true,
            contentPadding: const EdgeInsets.all(20),
          ),
        ));

    return Scaffold(
        appBar: Widgets.appBar('المقاسات'),
        floatingActionButton: Container(
          decoration: BoxDecoration(
              border: Border.all(
                color: Colors.red,
              ),
              color: Colors.white,
              shape: BoxShape.circle),
          width: screnWidth * .15,
          height: screnWidth * .15,
          child: IconButton(
              color: Colors.red,
              onPressed: () async {
                await addSizesprovider.deleteHashTag();
              },
              icon: const Icon(Icons.delete)),
        ),
        body: addSizesprovider.isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20),
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
                                      await addSizesprovider.addSize(name!);
                                      controller.text = '';
                                      setState(() {});
                                    }
                                  },
                                  child:
                                      Text('حفظ', style: MyThemeData.whiteTS))
                            ],
                          ),
                        ),
                        Widgets.vertSpace05(screnHeight),
                        ChipList(
                            extraOnToggle: (index) {
                              addSizesprovider.changeSelectedIndex(index);
                            },
                            listOfChipNames: data,
                            shouldWrap: true,
                            activeBgColorList: const [
                              Color.fromARGB(224, 242, 57, 57)
                            ],
                            listOfChipIndicesCurrentlySeclected: [
                              addSizesprovider.index != null
                                  ? addSizesprovider.index!
                                  : -1
                            ]),
                      ]),
                ),
              ));
  }
}
