import 'package:flutter/material.dart';
import 'package:printdesignadmin/core/my_theme_data.dart';
import 'package:printdesignadmin/model/order.dart';
import 'package:printdesignadmin/model/product.dart';
import 'package:printdesignadmin/widgets.dart';

// ignore: must_be_immutable
class OrderDetails extends StatelessWidget {
  PaidOrder order;
  List<Product> orderItems;
  OrderDetails(this.order, this.orderItems, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Widgets.appBar("${order.neferuOrderId}-${order.neferuOrderPass}"),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            titleContainer('معلومات التواصل'),
            order.isGift ? contactGift() : contact(),
            titleContainer('الفلوس'),
            haveDeposite(),
            paidAmount(),
            titleContainer('العنوان'),
            address(),
            titleContainer('الاوردر'),
            items()
          ],
        ),
      )),
    );
  }

//////////////////mutual/////////////////////////
  titleContainer(String title) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          color: const Color.fromARGB(80, 255, 255, 255),
          child: Text(title, style: MyThemeData.whiteTS)),
    );
  }

/////////////////////////////cash//////////////////
  haveDeposite() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        order.useDeposite
            ? const Icon(
                Icons.done,
                color: Colors.green,
              )
            : const Icon(
                Icons.cancel,
                color: Colors.red,
              ),
        const SizedBox(
          width: 10,
        ),
        const Text('يوجد دفع عند الاستلام '),
      ],
    );
  }

  paidAmount() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        //سعر القطع الاصلي
        Text(
          '${order.originalPrice / 100} : سعر القطع  ',
        ),
        //سعر بعد الخصم
        order.promoCode != ''
            ? Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    '(${order.promoCode})',
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    '${order.totalPrice / 100} : بعد الخصم  ',
                  ),
                ],
              )
            : const SizedBox(),
        //سعر الشحن
        Text(
          '${order.address.government.price} : الشحن  ',
        ),
        //المدفوع في باي موب
        Text(
          '${int.parse(order.amount) / 100} : المدفوع  ',
        ),
        //مبلغ الدفع عند الاستلام
        order.useDeposite
            ? Text(
                '${order.totalPrice / 100 - double.parse(order.amount) / 100} : المتبقي ',
                style: const TextStyle(color: Colors.red),
              )
            : const SizedBox()
      ],
    );
  }

///////////////////////contact information///////////////
  contactGift() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        //المرسل
        Column(
          children: [
            const Text(':  المرسل '),
            SelectableText(
              '${order.contactInfoGift.senderName}  ',
            ),
            const SizedBox(
              height: 10,
            ),
            SelectableText(
              '${order.contactInfoGift.senderPhone}  ',
            ),
          ],
        ),
        Column(
          children: [
            const Text(':  المستلم  '),
            //لمستلم
            SelectableText(
              '${order.contactInfoGift.reciverName} ',
            ),
            const SizedBox(
              height: 10,
            ),

            SelectableText(
              '${order.contactInfoGift.recieverPhone} ',
            ),
          ],
        ),
        //names
      ],
    );
  }

  contact() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        //names

        SelectableText(
          '${order.contactInfo.name} :  الاسم  ',
        ),
        //لمستلم
        SelectableText(
          '${order.contactInfo.phone} :  الرقم  ',
        ),
        SelectableText(
          '${order.contactInfo.whatsapp} :  واتس  ',
        ),
      ],
    );
  }

///////////////////////////address////////////////////////
  address() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        //شقة الدور العمارة
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            order.address.flatNum != ''
                ? Text(
                    '${order.address.flatNum} : شقة   ',
                  )
                : const SizedBox(),
            Text(
              '${order.address.floorNum} : الدور ',
            ),
            Text(
              '${order.address.buildingNum} : عمارة   ',
            ),
          ],
        ),
        Text(
          '${order.address.streetName} : شارع',
        ),
        Text(
          '${order.address.government.name} : محافظة   ',
        ),
        order.address.shippingNote != ''
            ? Text(
                '${order.address.shippingNote} : ملاحظة   ',
              )
            : const SizedBox(),
      ],
    );
  }

////////////////////order///////////////////////////
  items() {
    return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: orderItems.length,
        itemBuilder: (context, index) => InkWell(
              child: Row(
                children: [
                  //    img
                  SizedBox(
                    height: 250,
                    width: 250,
                    child: Widgets.cachedImg(
                        orderItems[index].colorsAndImgURL.values.first[0]),
                  ),
                  Column(
                    children: [
                      //name
                      Text(orderItems[index].name),
                      Text(orderItems[index].material),

                      Text('${order.orderItems[index].quantity} : الكمية'),
                      //size
                      Text('${order.orderItems[index].size} : المقاس'),
                      //color
                      Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: Color(
                                    int.parse(order.orderItems[index].color)),
                                boxShadow: const [
                                  BoxShadow(
                                      offset: Offset(-2, 2),
                                      blurRadius: 3,
                                      color: Color.fromARGB(147, 255, 255, 255))
                                ],
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(50))),
                            height: 20,
                            width: 20,
                          ),
                          const Text(' : اللون'),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ));
  }
}
