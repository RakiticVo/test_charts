import 'package:flutter/material.dart';

import 'app_constant.dart';

class Responsive {

  double screenWidth = 0;
  double screenHeight = 0;

  Responsive(BuildContext context) {
    MediaQueryData queryData = MediaQuery.of(context);
    screenWidth = queryData.size.width;
    screenHeight = queryData.size.height;
  }

  getWidthResponsive(double width) {
    return (width / AppConstant.widthDesign) * screenWidth;
  }

  getHeightResponsive(double height) {
    return (height / AppConstant.heightDesign) * screenHeight;
  }

  getRectangleSize(double size) {
    if (screenWidth < screenHeight) {
      return (size / AppConstant.widthDesign) * screenWidth;
    }
    return (size / AppConstant.heightDesign) * screenHeight;
  }

  getOtherSize(double size) {
    if (screenWidth < screenHeight) {
      return (size / AppConstant.widthDesign) * screenWidth;
    }
    return (size / AppConstant.widthDesign) * screenHeight;
  }

  getSizeBoxWidth(double width) {
    return screenWidth - width;
  }
}
