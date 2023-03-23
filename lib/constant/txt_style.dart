import 'package:flutter/material.dart';

import 'responsive.dart';

class TxtStyle {
  font6({required BuildContext buildContext, FontWeight? fontWeight, required Color color}) {

    Responsive responsive = Responsive(buildContext);

    return TextStyle(
        color: color,
        fontSize: responsive.getOtherSize(6.0),
        fontFamily: 'Inter',
        fontWeight: fontWeight ?? FontWeight.normal
    );
  }

  font8({required BuildContext buildContext, FontWeight? fontWeight, required Color color}) {

    Responsive responsive = Responsive(buildContext);

    return TextStyle(
        color: color,
        fontSize: responsive.getOtherSize(8.0),
        fontFamily: 'Inter',
        fontWeight: fontWeight ?? FontWeight.normal
    );
  }

  font10({required BuildContext buildContext, FontWeight? fontWeight, required Color color}) {

    Responsive responsive = Responsive(buildContext);

    return TextStyle(
      color: color,
      fontSize: responsive.getOtherSize(10.0),
      fontFamily: 'Inter',
      fontWeight: fontWeight ?? FontWeight.normal
    );
  }

  font12({required BuildContext buildContext, FontWeight? fontWeight, required Color color}) {

    Responsive responsive = Responsive(buildContext);

    return TextStyle(
      color: color,
      fontSize: responsive.getOtherSize(12.0),
      fontFamily: 'Inter',
      fontWeight: fontWeight ?? FontWeight.normal,
    );
  }

  font13({required BuildContext buildContext, FontWeight? fontWeight, required Color color}) {

    Responsive responsive = Responsive(buildContext);

    return TextStyle(
        color: color,
        fontSize: responsive.getOtherSize(13.0),
        fontFamily: 'Inter',
        fontWeight: fontWeight ?? FontWeight.normal
    );
  }


  font14({required BuildContext buildContext, FontWeight? fontWeight, required Color color}) {

    Responsive responsive = Responsive(buildContext);

    return TextStyle(
      color: color,
      fontSize: responsive.getOtherSize(14.0),
      fontFamily: 'Inter',
      fontWeight: fontWeight ?? FontWeight.normal,
    );
  }

  font15({required BuildContext buildContext, FontWeight? fontWeight, required Color color}) {

    Responsive responsive = Responsive(buildContext);

    return TextStyle(
        color: color,
        fontSize: responsive.getOtherSize(15.0),
        fontFamily: 'Inter',
        fontWeight: fontWeight ?? FontWeight.normal
    );
  }

  font16({required BuildContext buildContext, FontWeight? fontWeight, required Color color}) {

    Responsive responsive = Responsive(buildContext);

    return TextStyle(
        color: color,
        fontSize: responsive.getOtherSize(16.0),
        fontFamily: 'Inter',
        fontWeight: fontWeight ?? FontWeight.normal
    );
  }

  font18({required BuildContext buildContext, FontWeight? fontWeight, required Color color}) {

    Responsive responsive = Responsive(buildContext);

    return TextStyle(
        color: color,
        fontSize: responsive.getOtherSize(18.0),
        fontFamily: 'Inter',
        fontWeight: fontWeight ?? FontWeight.normal
    );
  }

  font20({required BuildContext buildContext, FontWeight? fontWeight, required Color color}) {

    Responsive responsive = Responsive(buildContext);

    return TextStyle(
        color: color,
        fontSize: responsive.getOtherSize(20.0),
        fontFamily: 'Inter',
        fontWeight: fontWeight ?? FontWeight.normal
    );
  }

  font24({required BuildContext buildContext, FontWeight? fontWeight, required Color color}) {

    Responsive responsive = Responsive(buildContext);

    return TextStyle(
      color: color,
      fontSize: responsive.getOtherSize(24.0),
      fontFamily: 'Inter',
      fontWeight: fontWeight ?? FontWeight.normal
    );
  }

  font32({required BuildContext buildContext, FontWeight? fontWeight, required Color color}) {

    Responsive responsive = Responsive(buildContext);

    return TextStyle(
      color: color,
      fontSize: responsive.getOtherSize(32.0),
      fontFamily: 'Inter',
      fontWeight: fontWeight ?? FontWeight.normal
    );
  }

  font80({required BuildContext buildContext, FontWeight? fontWeight, required Color color}) {

    Responsive responsive = Responsive(buildContext);

    return TextStyle(
      color: color,
      fontSize: responsive.getOtherSize(80.0),
      fontFamily: 'Inter',
      fontWeight: fontWeight ?? FontWeight.normal
    );
  }
}