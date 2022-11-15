abstract class HashTagsOptions {
  static String categoryKey = 'category';
  static String plainOrPrintedKey = 'plainOrPrinted';
  static String sizeKey = 'size';
  static String sleeveKey = 'sleeve';
  static String seasonKey = 'season';

  static Map<String, List<String>> basicOptions = {
    categoryKey: ['Men', 'Women', 'Children'],
    plainOrPrintedKey: ['Printed', 'Plain', 'Stripped', 'Checks'],
    sizeKey: ['Over Size', 'Slim Fit'],
    sleeveKey: ['Sleeveless', 'LongSleeve', 'ShortSleeve'],
    seasonKey: ['Summer', 'Winter']
  };
  static Map<String, List<int>> selBasicOptNum = {
    categoryKey: [0],
    plainOrPrintedKey: [0],
    sizeKey: [0],
    sleeveKey: [0],
    seasonKey: [0]
  };
  static Map<String, List<String>> selBasicOpt = {
    categoryKey: ['Men'],
    plainOrPrintedKey: ['Printed'],
    sizeKey: ['Over Size'],
    sleeveKey: ['Sleeveless'],
    seasonKey: ['Summer']
  };
}

class OptionalHashTags {
  late String name;

  OptionalHashTags({required this.name});

  OptionalHashTags.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    return data;
  }
}
