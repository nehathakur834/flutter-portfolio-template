import 'package:flutter/widgets.dart';

class Responsive {
  static bool isMobile(BuildContext context) => MediaQuery.sizeOf(context).width < 720;

  static bool isTablet(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    return width >= 720 && width < 1080;
  }

  static double contentWidth(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    if (width >= 1280) return 1180;
    if (width >= 900) return width - 96;
    return width - 40;
  }
}
