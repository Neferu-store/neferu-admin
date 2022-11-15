import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:printdesignadmin/core/my_theme_data.dart';

abstract class Widgets {
  static var verSizedBox35 = const SizedBox(
    height: 35,
  );

  static cachedImg(String url) {
    return CachedNetworkImage(
      placeholder: (context, imageProvider) => const Center(
        child: CircularProgressIndicator(),
      ),
      errorWidget: (context, url, error) => const Center(
        child: Icon(Icons.error),
      ),
      imageUrl: url,
      fit: BoxFit.contain,
    );
  }

  static PreferredSizeWidget appBar(String name, {bool arabic = true}) {
    return AppBar(
      title: Text(
        name,
        style: arabic
            ? MyThemeData.drawerTS
            : GoogleFonts.alexBrush(fontSize: 35, fontWeight: FontWeight.w500),
      ),
      backgroundColor: primaryColor,
      centerTitle: true,
    );
  }

  static Center loading = const Center(
    child: CircularProgressIndicator(),
  );
  static SizedBox space025(double screnHeight) {
    return SizedBox(
      height: screnHeight * .025,
    );
  }

  static SizedBox space02(double screnWidth) {
    return const SizedBox(
      width: 10,
    );
  }

  static SizedBox vertSpace05(double screnHeight) {
    return SizedBox(
      height: screnHeight * .05,
    );
  }

  static SizedBox vertSpace015(double screnHeight) {
    return SizedBox(
      height: screnHeight * .015,
    );
  }

  static MaterialButton saveBTN(
    double screnWidth,
    var formKey,
  ) {
    return MaterialButton(
        padding: EdgeInsets.symmetric(
            horizontal: screnWidth * .1, vertical: screnWidth * .05),
        color: Colors.blue,
        onPressed: () {
          if (formKey.currentState!.validate()) {}
        },
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(
            'Save',
            style: TextStyle(color: Colors.white, fontSize: screnWidth * .05),
          ),
        ]));
  }

  static SizedBox registerBTN(
    double screnWidth,
    var formKey,
  ) {
    return SizedBox(
      width: screnWidth * .8,
      child: ElevatedButton(
        style: ButtonStyle(
            elevation: MaterialStateProperty.all(screnWidth * .025),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.all(Radius.circular(screnWidth * .025)))),
            backgroundColor: MaterialStateProperty.all(
              Colors.white,
            ),
            padding: MaterialStateProperty.all(
              EdgeInsets.symmetric(
                  horizontal: screnWidth * .1, vertical: screnWidth * .05),
            )),
        onPressed: () {
          if (formKey.currentState!.validate()) {}
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text(
              'Create Account.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Color.fromARGB(84, 0, 0, 0)),
            ),
            Icon(Icons.arrow_forward_sharp, color: Color.fromARGB(84, 0, 0, 0))
          ],
        ),
      ),
    );
  }

  static FormField passwordFormField(double screnWidth) {
    return TextFormField(
      obscureText: true,
      validator: (input) {
        String whithOutSpaces = input!.trim();
        if (input == null ||
            whithOutSpaces == null ||
            whithOutSpaces.length < 8) {
          return 'please insert a vaild input';
        }
      },
      keyboardType: TextInputType.visiblePassword,
      decoration: InputDecoration(
          suffixIcon: const Icon(Icons.remove_red_eye_outlined),
          contentPadding: EdgeInsets.all(screnWidth * .05),
          label: const Text('Password'),
          hintText: 'Password'),
    );
  }
}
