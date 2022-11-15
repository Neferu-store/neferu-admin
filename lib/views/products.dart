import 'package:flutter/material.dart';
import 'package:printdesignadmin/model/product.dart';
import 'package:printdesignadmin/view_model/products.dart';
import 'package:printdesignadmin/views/add_products.dart';
import 'package:printdesignadmin/views/edit_product.dart';
import 'package:printdesignadmin/widgets.dart';
import 'package:provider/provider.dart';

class Products extends StatelessWidget {
  const Products({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screnHeight = MediaQuery.of(context).size.height;
    double screnWidth = MediaQuery.of(context).size.width;
    ProductsVM productsProvider = Provider.of(context);
    List<Product> productsList = productsProvider.productsList;
    return productsProvider.isLoading
        ? Widgets.loading
        : Scaffold(
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                showModalBottomSheet(
                  isScrollControlled: true,
                  context: context,
                  builder: (context) => const AddProducts(),
                );
              },
              child: const Icon(Icons.add),
            ),
            appBar: Widgets.appBar('المنتجات'),
            body: GridView.builder(
                padding: const EdgeInsets.symmetric(vertical: 30),
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    mainAxisSpacing: 15,
                    crossAxisSpacing: 10,
                    mainAxisExtent: 300,
                    maxCrossAxisExtent: 230),
                itemCount: productsList.length,
                itemBuilder: (context, index) {
                  return productItem(productsProvider, context, productsList,
                      index, screnWidth, screnHeight);
                }),
          );
  }

  Container offerContainer(double percent) {
    return Container(
      padding: const EdgeInsets.all(5),
      color: Colors.red,
      child: Text(
        '- $percent ',
        style: const TextStyle(color: Colors.white),
      ),
    );
  }

  productItem(
    ProductsVM productsProvider,
    context,
    List<Product> productsList,
    int index,
    double screnWidth,
    double screnHeight,
  ) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EditProduct(productsList[index]),
            ));
      },
      child: Column(
        children: [
          //img

          Stack(
            alignment: AlignmentDirectional.topEnd,
            children: [
              Container(
                color: Colors.white,
                width: 150,
                height: 200,
                child: Widgets.cachedImg(
                  productsProvider.getFirstImg(index),
                ),
              ),
              productsList[index].hasOffer
                  ? offerContainer(productsList[index].offerPercent)
                  : const SizedBox(),
            ],
          ),
          Widgets.space02(screnWidth),
          //name price description
          const SizedBox(
            height: 10,
          ),
          detailsRow(productsList[index], screnWidth),
          Row(
            children: [
              //edit

              editBtn(context, productsList, index, screnWidth),
              const Spacer(),
              deleteBtn(
                  context, productsProvider, productsList, index, screnWidth)
            ],
          ),
        ],
      ),
    );
  }

  detailsRow(Product currentProduct, double screenWidth) {
    return Padding(
      padding: EdgeInsets.only(left: screenWidth * .02),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(currentProduct.name),
          const SizedBox(
            width: 10,
          ),
          Text(currentProduct.price.toString()),
        ],
      ),
    );
  }

  editBtn(context, List<Product> productsList, int index, double screenWidth) {
    return IconButton(
      onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EditProduct(productsList[index]),
            ));
      },
      icon: const Icon(
        Icons.edit_outlined,
        color: Colors.blue,
      ),
    );
  }

  deleteBtn(BuildContext context, ProductsVM productsProvider,
      List<Product> productsList, int index, double screnWidth) {
    return IconButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    content: const Text(
                      'متأكد ؟؟',
                      textAlign: TextAlign.center,
                    ),
                    actions: [
                      Row(
                        children: [
                          MaterialButton(
                              color: Colors.red,
                              onPressed: () {
                                productsProvider
                                    .deleteProduct(productsList[index].id);

                                Navigator.pop(context);
                              },
                              child: const Text(
                                'متأكد',
                                style: TextStyle(color: Colors.white),
                              )),
                          const Spacer(),
                          ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('لا')),
                        ],
                      )
                    ],
                  ));
        },
        icon: Icon(
          Icons.delete,
          color: Colors.red,
          size: screnWidth * .05,
        ));
  }
}
