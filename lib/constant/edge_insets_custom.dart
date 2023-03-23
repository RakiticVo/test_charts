import 'package:flutter/cupertino.dart';

import 'responsive.dart';

class EdgeInsetsCustom {

  only ({
    required BuildContext context,
    double? top,
    double? bottom,
    double? left,
    double? right,}) {

    Responsive responsive = Responsive(context);

    return EdgeInsets.only(
      top: responsive.getHeightResponsive(top ?? 0),
      bottom: responsive.getHeightResponsive(bottom ?? 0),
      left: responsive.getWidthResponsive(left ?? 0),
      right: responsive.getWidthResponsive(right ?? 0),
    );
  }

  symmetric ({required BuildContext context, double? horizontal, double? vertical}) {

    Responsive responsive = Responsive(context);

    return EdgeInsets.symmetric(
      horizontal: responsive.getWidthResponsive(horizontal ?? 0),
      vertical: responsive.getHeightResponsive(vertical ?? 0),
    );
  }

  all ({required BuildContext context, double? value}) {

    Responsive responsive = Responsive(context);

    return EdgeInsets.all(responsive.getOtherSize(value ?? 0),);
  }
}