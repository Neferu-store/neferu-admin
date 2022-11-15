import 'package:flutter/material.dart';
import 'package:printdesignadmin/model/ads.dart';
import 'package:printdesignadmin/view_model/ads.dart';
import 'package:printdesignadmin/widgets.dart';
import 'package:provider/provider.dart';
import '../core/my_theme_data.dart';
import 'our_drawer.dart';

class Ads extends StatefulWidget {
  const Ads({Key? key}) : super(key: key);

  @override
  State<Ads> createState() => _AdsState();
}

class _AdsState extends State<Ads> {
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    //  double screnHeight = MediaQuery.of(context).size.height;
    double screnWidth = MediaQuery.of(context).size.width;

    return ChangeNotifierProvider(
        create: (context) => AdsVM(),
        builder: (context, child) {
          AdsVM adsProvider = Provider.of(context);
          List<Ad> adsList = adsProvider.ads;
          return Scaffold(
              //add
              floatingActionButton: FloatingActionButton(
                  onPressed: () {
                    addAdBottomSheet(context, screnWidth, adsProvider);
                  },
                  child: const Icon(Icons.add)),
              appBar: Widgets.appBar('الاعلانات'),
              drawer: const OurDrawer(),
              body: adsProvider.isLoading
                  ? Widgets.loading
                  : SingleChildScrollView(
                      child: Column(
                        children: [
                          ListView.separated(
                            shrinkWrap: true,
                            separatorBuilder: (context, index) =>
                                const Divider(),
                            itemCount: adsList.length,
                            itemBuilder: (context, index) {
                              return adItem(adsProvider, adsList, index,
                                  context, screnWidth);
                            },
                          )
                        ],
                      ),
                    ));
        });
  }
}

deleteBtn(AdsVM adsProvider, String id, int index) {
  return TextButton(
      onPressed: () async {
        adsProvider.deleteAd(id, index);
      },
      child: const Text(
        'مسح',
        style: TextStyle(color: Colors.red),
      ));
}

editBtn(BuildContext context, screnWidth, AdsVM adProvider, int index) {
  return TextButton(
      onPressed: () {
        adProvider.changeAd(adProvider.ads[index]);
        editAdBottomSheet(context, screnWidth, adProvider, index);
      },
      child: const Text('تعديل'));
}

adItem(AdsVM adProvider, List<Ad> adsList, int index, BuildContext context,
    screenWidth) {
  return Column(
    children: [
      ListTile(
        //Radius
        leading: CircleAvatar(
          child: Widgets.cachedImg(adsList[index].imgURL),
          radius: 25,
        ),
        //title
        title: Text(adsList[index].title),
        //disc

        subtitle: Text(adsList[index].content),
      ),
      Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            editBtn(context, screenWidth, adProvider, index),
            const Spacer(),
            deleteBtn(adProvider, adsList[index].id, index)
          ],
        ),
      )
    ],
  );
}

////////////////add///////////////////////
titleField(var screnWidth, AdsVM prov) {
  return TextFormField(
      maxLines: null,
      initialValue: prov.title,
      onChanged: (value) {
        prov.changeTitle(value);
      },
      keyboardType: TextInputType.name,
      decoration: MyThemeData.inputDeco('العنوان', screnWidth));
}

contentField(var screnWidth, AdsVM prov) {
  return TextFormField(
      maxLines: null,
      onChanged: (value) => prov.changeContent(value),
      keyboardType: TextInputType.name,
      decoration: MyThemeData.inputDeco('الوصف القصير', screnWidth));
}

imgField(var screnWidth, AdsVM prov) {
  return TextFormField(
      maxLines: null,
      onChanged: (value) => prov.changeUrl(value),
      keyboardType: TextInputType.url,
      decoration: MyThemeData.inputDeco('لينك درايف', screnWidth));
}

saveBtn(AdsVM adProvider) {
  return Padding(
    padding: const EdgeInsets.all(25),
    child: MaterialButton(
      color: primaryColor,
      onPressed: () async {
        await adProvider.addAd();
      },
      child: Text('حفظ', style: MyThemeData.drawerTS),
    ),
  );
}

addAdBottomSheet(BuildContext context, var screnWidth, AdsVM adProvider) {
  return showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: SingleChildScrollView(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  //title
                  titleField(screnWidth, adProvider),
                  //content
                  contentField(screnWidth, adProvider),
                  //img
                  imgField(screnWidth, adProvider),
                  saveBtn(adProvider)
                ]),
          ),
        );
      });
}

///////////edit///////////////////////////////////////
titleEditField(var screnWidth, AdsVM prov, String init) {
  return TextFormField(
      maxLines: null,
      initialValue: init,
      onChanged: (value) {
        prov.editTitle(value);
      },
      keyboardType: TextInputType.name,
      decoration: MyThemeData.inputDeco('العنوان', screnWidth));
}

contentEditField(var screnWidth, AdsVM prov, String init) {
  return TextFormField(
      maxLines: null,
      initialValue: init,
      onChanged: (value) {
        prov.editContent(value);
      },
      keyboardType: TextInputType.name,
      decoration: MyThemeData.inputDeco('الوصف القصير', screnWidth));
}

imgEditField(var screnWidth, AdsVM prov, String init) {
  return TextFormField(
      maxLines: null,
      initialValue: init,
      onChanged: (value) {
        prov.editUrl(value);
      },
      keyboardType: TextInputType.url,
      decoration: MyThemeData.inputDeco('لينك درايف', screnWidth));
}

saveEditBtn(AdsVM adProvider, int index) {
  return Padding(
    padding: const EdgeInsets.all(25),
    child: MaterialButton(
      color: primaryColor,
      onPressed: () async {
        await adProvider.editAdToFirebase(index);
      },
      child: Text('حفظ', style: MyThemeData.drawerTS),
    ),
  );
}

editAdBottomSheet(
    BuildContext context, var screnWidth, AdsVM adProvider, int index) {
  return showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: SingleChildScrollView(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  //title
                  titleEditField(
                      screnWidth, adProvider, adProvider.ads[index].title),
                  //content
                  contentEditField(
                      screnWidth, adProvider, adProvider.ads[index].content),
                  //img
                  imgEditField(
                      screnWidth, adProvider, adProvider.ads[index].imgURL),
                  saveEditBtn(adProvider, index)
                ]),
          ),
        );
      });
}
