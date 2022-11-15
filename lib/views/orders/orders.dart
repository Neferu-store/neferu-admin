import 'package:chip_list/chip_list.dart';
import 'package:flutter/material.dart';

import 'package:printdesignadmin/model/order.dart';
import 'package:printdesignadmin/view_model/orders.dart';
import 'package:printdesignadmin/views/orders/order_details.dart';
import 'package:printdesignadmin/views/our_drawer.dart';
import 'package:printdesignadmin/widgets.dart';
import 'package:provider/provider.dart';

class Orders extends StatefulWidget {
  const Orders({Key? key}) : super(key: key);

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  @override
  Widget build(BuildContext context) {
    OrdersVM ordersProvider = Provider.of(context);
    List<PaidOrder> ordersList = ordersProvider.orders;
    return Scaffold(
        drawer: const OurDrawer(),
        appBar: Widgets.appBar("الاوردرات"),
        body: ordersProvider.isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemCount: ordersList.length,
                itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          ListTile(
                            onTap: () async {
                              await ordersProvider
                                  .getOrderItems(ordersList[index].orderItems);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => OrderDetails(
                                        ordersList[index],
                                        ordersProvider.orderItems),
                                  ));
                            },
                            leading: Text(index.toString()),
                            title: Row(
                              children: [
                                Text(ordersList[index].neferuOrderId),
                                const SizedBox(
                                  width: 10,
                                ),
                                ordersList[index].isGift
                                    ? Icon(
                                        Icons.card_giftcard,
                                        color: Colors.yellow[900],
                                      )
                                    : const SizedBox()
                              ],
                            ),
                            trailing: Text(ordersList[index].orderStatus),
                            //عدد القطع والاجمالي
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    ' ${ordersList[index].neferuOrderPass.toString()} الباسورد'),
                                Row(
                                  children: [
                                    //عدد القطع
                                    Text(
                                        '${ordersList[index].orderItems.length.toString()} قطعة'),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    //الاجمالي
                                    Text(
                                        '${(ordersList[index].totalPrice / 100).toString()} جنية'),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              deleteBTN(ordersProvider, ordersList, index),
                              editBTN(ordersProvider, ordersList, index)
                            ],
                          )
                        ],
                      ),
                    )));
  }

  deleteBTN(OrdersVM ordersProvider, List<PaidOrder> ordersList, int index) {
    return TextButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    content: const Text("متأكد من مسح الاوردر"),
                    actions: [
                      //confirm deleting
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                              onPressed: () {
                                ordersProvider.deleteOrder(
                                    ordersList[index].neferuOrderId);
                                Navigator.pop(context);
                              },
                              child: const Text('متأكد',
                                  style: TextStyle(
                                    color: Colors.red,
                                  ))),

                          //not agree
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('لا')),
                        ],
                      )
                    ],
                  ));
        },
        child: (const Text('مسح',
            style: TextStyle(
              color: Colors.red,
            ))));
  }

  editBTN(OrdersVM ordersProvider, List<PaidOrder> ordersList, int index) {
    return TextButton(
        onPressed: () {
          ordersProvider.getSelectedStatusIndex(ordersList[index].orderStatus);
          showDialog(
              context: context,
              builder: (context) {
                return StatefulBuilder(
                  builder: (context, setState) => AlertDialog(
                    content: ChipList(
                      extraOnToggle: ((chipsIndex) {
                        ordersProvider.changeTempOrderStatus(chipsIndex, index);
                        setState((() {}));
                      }),
                      borderRadiiList: const [0],
                      shouldWrap: true,
                      listOfChipNames: ordersProvider.orderStatus,
                      listOfChipIndicesCurrentlySeclected: [
                        ordersProvider.statusSelected
                      ],
                    ),
                    actions: [
                      //confirm deleting

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                              onPressed: () {
                                ordersProvider.changeTempOrderStatus(
                                    index, index,
                                    newTemp: '');
                                Navigator.pop(context);
                              },
                              child: const Text('الغاء')),
                          TextButton(
                              onPressed: () async {
                                await ordersProvider.changeOrderStatus(index);
                                Navigator.pop(context);
                              },
                              child: const Text(
                                'حفظ',
                                style: TextStyle(color: Colors.red),
                              )),
                        ],
                      ),
                    ],
                  ),
                );
              });
        },
        child: (const Text(
          'تعديل',
        )));
  }
}
