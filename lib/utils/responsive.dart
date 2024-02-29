import 'package:flutter/cupertino.dart';

class AppMediaQuery {
  static screenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  static screenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static textFactor(BuildContext context) {
    // ignore: deprecated_member_use
    return MediaQuery.of(context).textScaleFactor;
  }
}
