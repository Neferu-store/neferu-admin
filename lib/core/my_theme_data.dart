import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

var primaryColor = const Color(0xffFFDA44);

class MyThemeData {
  static var myTheme = ThemeData(
      colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: Colors.green,
          primary: const Color(0xffFFDA44),
          brightness: Brightness.dark));

//////////////////text style////////////////////////////
  static var drawerTS = GoogleFonts.lateef(
    textStyle: const TextStyle(
        color: Colors.black,
        letterSpacing: 1,
        shadows: [
          BoxShadow(
              color: Colors.black38,
              blurRadius: 3,
              offset: Offset(-2, 2),
              spreadRadius: 10)
        ],
        fontSize: 30),
  );
  static var whiteTS = GoogleFonts.lateef(
      color: Colors.white, fontSize: 28, fontWeight: FontWeight.w200);

  static var matBtnRadius25 = const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(25)));
  static var matBtnPadding =
      const EdgeInsets.symmetric(horizontal: 25, vertical: 15);
  static InputDecoration inputDeco(String title, double screnWidth) {
    return InputDecoration(
        //filled: true,
        fillColor: Colors.black12,
        enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(0))),
        border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(0))),
        contentPadding: const EdgeInsets.all(8),
        hintText: title);
  }
}
