class BasicHashTags {
  late List<String> size;
  late List<String> sleeve;
  late List<String> season;
  late List<String> plainOrPrinted;
  late List<String> category;

  BasicHashTags(
      {required this.size,
      required this.sleeve,
      required this.season,
      required this.plainOrPrinted,
      required this.category});

  BasicHashTags.fromJson(Map<String, dynamic> json) {
    size = json['size'].cast<String>();
    sleeve = json['sleeve'].cast<String>();
    season = json['season'].cast<String>();
    plainOrPrinted = json['plainOrPrinted'].cast<String>();
    category = json['category'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['size'] = size;
    data['sleeve'] = sleeve;
    data['season'] = season;
    data['plainOrPrinted'] = plainOrPrinted;
    data['category'] = category;
    return data;
  }
}

class Product {
  String id = DateTime.now().toString();
  late String sizeGuideImg;
  late List<String> optionalhashTags;
  late Map<String, dynamic> basicHashTags;
  late String description;
  late Map<String, dynamic> colorsAndImgURL;
  late String material;
  late String name;
  late double price;
  bool hasOffer = false;
  double offerPercent = 0;
  double priceAfterOffer = 0;
  late List<String> sizes;

  Product({
    required this.optionalhashTags,
    required this.basicHashTags,
    required this.sizeGuideImg,
    required this.description,
    required this.colorsAndImgURL,
    required this.material,
    required this.name,
    required this.price,
    required this.sizes,
    this.hasOffer = false,
    this.offerPercent = 0,
    this.priceAfterOffer = 0,
  });

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    optionalhashTags = json['hashTags'].cast<String>();
    basicHashTags = json['basicHashTags'];

    sizeGuideImg = json['sizeGuideImg'];

    colorsAndImgURL = json['colorsAndImgURL'];

    description = json['description'];
    material = json['material'];
    name = json['name'];
    hasOffer = json['hasOffer'];

    price = double.parse(json['price'].toString());

    priceAfterOffer = double.parse(json['priceAfterOffer'].toString());

    offerPercent = double.parse(json['offerPercent'].toString());
    print(json['id']);

    sizes = json['sizes'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['hashTags'] = optionalhashTags;
    data['basicHashTags'] = basicHashTags;
    data['sizeGuideImg'] = sizeGuideImg;
    data['description'] = description;
    data['colorsAndImgURL'] = colorsAndImgURL;
    data['material'] = material;
    data['name'] = name;
    data['price'] = price;
    data['hasOffer'] = hasOffer;
    data['offerPercent'] = offerPercent;
    data['priceAfterOffer'] = priceAfterOffer;
    data['sizes'] = sizes;
    return data;
  }
}
