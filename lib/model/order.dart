import 'dart:convert';

import 'package:printdesignadmin/model/product.dart';

class PaidOrder {
  late String amount;
  late String createdAt;
  late String neferuOrderId;
  late String neferuOrderPass;
  late List<Order> orderItems;
  String promoCode = "";
  double totalPrice = 0;
  late double originalPrice;
  late bool isGift;
  late bool useDeposite;
  late ContactInfo contactInfo;
  late ContactInfoGift contactInfoGift;
  late String orderStatus;
  late String succes;
  late DeliveryAddress address;
  PaidOrder(
      {required this.amount,
      required this.createdAt,
      required this.neferuOrderId,
      required this.neferuOrderPass,
      required this.orderItems,
      required this.isGift,
      required this.orderStatus,
      required this.originalPrice,
      this.promoCode = "",
      required this.succes,
      this.totalPrice = 0,
      required this.useDeposite,
      required this.contactInfo,
      required this.contactInfoGift,
      required this.address});

  PaidOrder.fromJson(Map<String, dynamic> json1) {
    var json = json1['body'];
    if (json['neferu_order_id'] == null) {
    } else {
      amount = json['amount'].toString();
      createdAt = json['created_at'].toString();
      neferuOrderId = json['neferu_order_id'].toString();
      neferuOrderPass = json['neferu_order_pass'].toString();
      if (jsonDecode(json['order']) != null) {
        var order = jsonDecode(json['order']);
        if (json['order'] != null) {
          orderItems = <Order>[];

          order['orderItems'].forEach((v) {
            orderItems.add(Order.fromJson(v));
          });
        }

        promoCode = order['promoCode'];
        totalPrice = double.parse(order['totalPrice'].toString());
        originalPrice = double.parse(order['originalPrice'].toString());

        isGift = order['isGift'];

        useDeposite = order['useDeposite'];

        contactInfo = ContactInfo.fromJson(order['contactInfo']);

        contactInfoGift = ContactInfoGift.fromJson(order['contactInfoGift']);
        address = DeliveryAddress.fromJson(order['address']);
      }
      orderStatus = json['order_status'];
      succes = json['succes'];
    }
  }
}

class Order {
  late String id = DateTime.now().toString();
  late Product product;
  late String productId;
  late int quantity;
  late String color;
  late String size;

  Order(
      {required this.productId,
      required this.product,
      required this.color,
      required this.size,
      this.quantity = 1});

  Order.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['prodId'];
    quantity = json['quantity'];
    color = json['color'];
    size = json['size'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['prodId'] = productId;
    data['quantity'] = quantity;
    data['color'] = color;
    data['size'] = size;
    return data;
  }
}

class Government {
  late String name;
  late double price;

  Government({required this.name, required this.price});

  Government.fromJson(Map<String, dynamic> json) {
    price = double.parse(json["price"].toString());
    name = json["name"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["name"] = name;
    _data["price"] = price;
    return _data;
  }
}

class Address {
  late String flatNum, floorNum, buildingNum, streetName, shippingNote;
  late Government government;
  Address(
      {this.flatNum = "",
      required this.floorNum,
      required this.buildingNum,
      required this.streetName,
      required this.government,
      required this.shippingNote});

  Address.fromJson(Map<String, dynamic> json) {
    flatNum = json['flatNum'];
    floorNum = json['floorNum'];
    buildingNum = json['buildingNum'];
    streetName = json['streetName'];
    shippingNote = json['shippingNote'];
    government = Government.fromJson(json['government']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['flatNum'] = flatNum;
    data['floorNum'] = floorNum;
    data['buildingNum'] = buildingNum;
    data['streetName'] = streetName;
    data['shippingNote'] = shippingNote;
    data['government'] =
        Government(name: government.name, price: government.price);
    return data;
  }
}

class ContactInfo {
  late String name, phone, whatsapp;
  ContactInfo(
      {required this.name, required this.phone, required this.whatsapp});

  ContactInfo.fromJson(Map<String, dynamic> json) {
    name = json['name'];

    phone = json['phone'];
    whatsapp = json['whatsApp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['firstName'] = name;
    data['phone'] = phone;
    data['whatsApp'] = whatsapp;
    return data;
  }
}

class DeliveryAddress {
  late Government government;
  late String streetName;
  late String buildingNum;
  late String floorNum;
  late String flatNum;
  late String shippingNote;

  DeliveryAddress(
      {required this.government,
      required this.streetName,
      required this.buildingNum,
      required this.floorNum,
      required this.flatNum,
      required this.shippingNote});

  DeliveryAddress.fromJson(Map<String, dynamic> json) {
    government = Government.fromJson(json['government']);
    streetName = json['streetName'];
    buildingNum = json['buildingNum'];
    floorNum = json['floorNum'];
    flatNum = json['flatNum'];
    shippingNote = json['shippingNote'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['government'] = government;
    data['streetName'] = streetName;
    data['buildingNum'] = buildingNum;
    data['floorNum'] = floorNum;
    data['flatNum'] = flatNum;
    data['shippingNote'] = shippingNote;
    return data;
  }
}

class ContactInfoGift {
  String? senderName;
  String? reciverName;
  String? senderPhone;
  String? recieverPhone;

  ContactInfoGift(
      {this.reciverName,
      this.recieverPhone,
      this.senderPhone,
      this.senderName});

  ContactInfoGift.fromJson(Map<String, dynamic> json) {
    senderName = json['senderName'];
    reciverName = json['RecieverName'];
    senderPhone = json['senderPhone'];
    recieverPhone = json['reciverPhone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['senderName'] = senderName;
    data['RecieverName'] = reciverName;
    data['senderPhone'] = senderPhone;
    data['reciverPhone'] = recieverPhone;
    return data;
  }
}
