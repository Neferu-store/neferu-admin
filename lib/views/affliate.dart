import 'package:flutter/material.dart';
import 'package:printdesignadmin/model/affilate.dart';
import 'package:printdesignadmin/view_model/affliate.dart';
import 'package:printdesignadmin/widgets.dart';
import 'package:printdesignadmin/widgets/affilate.dart';
import 'package:provider/provider.dart';
import '../model/order.dart';
import 'our_drawer.dart';

// ignore: must_be_immutable
class AddAffliate extends StatefulWidget {
  List<PaidOrder> ordersList;

  AddAffliate(this.ordersList, {Key? key}) : super(key: key);
  @override
  State<AddAffliate> createState() => _AddAffliateState();
}

class _AddAffliateState extends State<AddAffliate> {
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    double screnHeight = MediaQuery.of(context).size.height;
    double screnWidth = MediaQuery.of(context).size.width;

    return ChangeNotifierProvider(
        create: (context) => AffliateVM(ordersList: widget.ordersList),
        builder: (context, child) {
          AffliateVM affProv = Provider.of(context);
          List<Affliate> affilatesList = affProv.affliates;
          return Scaffold(
              floatingActionButton: FloatingActionButton(
                  onPressed: () {
                    AffilateWidgets.addPersonBottomSheet(
                        context, formKey, affProv, screnWidth);
                  },
                  child: const Icon(Icons.add)),
              appBar: Widgets.appBar('المسوقين'),
              drawer: const OurDrawer(),
              body: affProv.isLoading
                  ? Widgets.loading
                  : SingleChildScrollView(
                      child: Column(
                        children: [
                          ListView.separated(
                            shrinkWrap: true,
                            separatorBuilder: (context, index) =>
                                const Divider(),
                            itemCount: affilatesList.length,
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  ListTile(
                                    onTap: () {
                                      personInfoDialog(
                                          screnWidth,
                                          affilatesList,
                                          index,
                                          screnHeight,
                                          affProv);
                                    },
                                    //code
                                    leading: CircleAvatar(
                                      child: Text(index.toString()),
                                    ),
                                    //name
                                    title: Text(affilatesList[index].name),
                                    //discount percent

                                    subtitle: Text(
                                        '${affilatesList[index].discountPercent.toString()} %'),
                                    //items num
                                    trailing: Text(
                                        '${affilatesList[index].orderNum} items'),
                                  ),
                                ],
                              );
                            },
                          )
                        ],
                      ),
                    ));
        });
  }

  personInfoDialog(double screnWidth, List<Affliate> affilatesList, int index,
      double screnHeight, AffliateVM affProvider) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
                actions: [
                  //delete
                  MaterialButton(
                      padding: const EdgeInsets.all(5),
                      color: Colors.red,
                      onPressed: () {
                        affProvider.deletePerson(affilatesList[index].code);
                        Navigator.pop(context);
                      },
                      child: const Icon(
                        Icons.delete,
                        color: Colors.white,
                      )),
                  //ok
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('OK'))
                ],
                content: SizedBox(
                  height: screnWidth * .5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      //code
                      SelectableText(affilatesList[index].code),
                      Text(
                          "عدد الاوردرات ${affilatesList[index].orderNum.toString()}"),
                      Text(
                          "اجمالي المبلغ ${affilatesList[index].totalAmount.toStringAsFixed(2)}"),

                      //phone
                      affilatesList[index].phone != ''
                          ? SelectableText(
                              'الهاتف : ${affilatesList[index].phone}')
                          : const Text('لا يوجد رقم هاتف'),
                      //whats app
                      affilatesList[index].whatsApp != ''
                          ? SelectableText(
                              'واتس : ${affilatesList[index].whatsApp}',
                              style:
                                  const TextStyle(overflow: TextOverflow.fade),
                            )
                          : const Text("لا يوجد واتس اب"),
                      //social media link
                      affilatesList[index].socialMediaLink != ''
                          ? SelectableText(
                              'موقع التواصل الاجتماعي : ${affilatesList[index].socialMediaLink}',
                              textDirection: TextDirection.rtl,
                            )
                          : const Text("لا يوجد حساب لموقع التواصل الاجتماعي")
                    ],
                  ),
                )));
  }
}
