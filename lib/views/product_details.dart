import 'package:flutter/material.dart';
import 'package:printdesignadmin/model/product.dart';
import 'package:printdesignadmin/widgets.dart';

// ignore: must_be_immutable
class ProductDetalis extends StatelessWidget {
  Product product;
  ProductDetalis(this.product, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.name),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Widgets.cachedImg(product.colorsAndImgURL.values.first[0]),
            product.hasOffer
                ? Text(product.priceAfterOffer.toString())
                : Text(product.price.toString()),
            Text(product.material),
            product.optionalhashTags.isNotEmpty
                ? Column(
                    children: [
                      const Text('optional hashTags'),
                      Text(product.optionalhashTags.toString())
                    ],
                  )
                : const SizedBox()
          ],
        )),
      ),
    );
  }
}
