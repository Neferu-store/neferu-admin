class LastCode {
  late int value;
  LastCode(this.value);
  LastCode.fromJson(Map<String, dynamic> json) {
    value = json['code'];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['code'] = value;
    return json;
  }
}

class Affliate {
  late String name, code;
  String socialMediaLink = '', phone = '', whatsApp = '';
  double discountPercent = 0;
  int orderNum = 0;
  double totalAmount = 0;
  Affliate(
      {required this.name,
      required this.code,
      this.discountPercent = 0,
      this.socialMediaLink = '',
      this.phone = '',
      this.whatsApp = '',
      this.orderNum = 0,
      this.totalAmount = 0});

  Affliate.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    code = json['code'];
    discountPercent = double.parse(json['discountPercent'].toString());
    orderNum = json['orderNum'];
    socialMediaLink = json['socialMediaLink'];
    phone = json['phone'];
    orderNum = json['orderNum'];
    totalAmount = double.parse(json['totalAmount'].toString());
  }
  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['name'] = name;
    json['code'] = code;
    json['discountPercent'] = discountPercent;
    json['orderNum'] = orderNum;
    json['socialMediaLink'] = socialMediaLink;
    json['phone'] = phone;
    json['orderNum'] = orderNum;
    json['totalAmount'] = totalAmount;
    return json;
  }
}
