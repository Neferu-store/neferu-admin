import 'package:flutter/cupertino.dart';
import 'package:printdesignadmin/model/order.dart';
import 'package:printdesignadmin/model/product.dart';

import '../services/orders.dart';

class OrdersVM extends ChangeNotifier {
  OrdersVM() {
    getOrders();
  }
///////////loading//////////////////
  bool isLoading = false;
  void changeIsLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

/////////////orders////////////////////
  List<PaidOrder> orders = [];
  getOrders() async {
    changeIsLoading(true);
    orders = await OrdersSV().getOrders({});
    changeIsLoading(false);
  }
  ///////////////order items///////////

  List<Product> orderItems = [];
  getOrderItems(List<Order> orders) async {
    orderItems = await OrdersSV().getProducts(orders);
  }

  deleteOrder(String id) async {
    changeIsLoading(true);
    bool isSucces = await OrdersSV().deleteOrders(id);
    if (isSucces) {
      orders.removeWhere((element) => element.neferuOrderId == id);
    }
    changeIsLoading(false);
  }

////////////////////////edit order status///////////////////////
  List<String> orderStatus = [
    "ordered",
    "inProgress",
    "shippingCallDone",
    "shippingCallWrong",
    "delivered",
    "notDelivered"
  ];

////////////////get index of order status currently selected////////
  int statusSelected = 0;
  getSelectedStatusIndex(String status) {
    statusSelected = orderStatus.indexWhere((element) => element == status);
//    notifyListeners();
  }

/////////////final change for order status///////////////
  String tempOrderStatus = '';
  void changeTempOrderStatus(int index, int orderIndex,
      {String newTemp = '0'}) {
    if (newTemp == '') {
      tempOrderStatus = '';
    } else {
      // changeIsLoading(true);
      tempOrderStatus = orderStatus[index];
    }
    getSelectedStatusIndex(orderStatus[index]);
  }

/////////////final change for order status///////////////
  changeOrderStatus(int orderIndex) async {
    changeIsLoading(true);

    if (tempOrderStatus != '') {
      bool isSuccess = await OrdersSV()
          .editOrderStatus(orders[orderIndex].neferuOrderId, tempOrderStatus);
      if (isSuccess) {
        orders[orderIndex].orderStatus = tempOrderStatus;
      }
    }
    changeIsLoading(false);
  }
}
