import 'package:flutter/material.dart';

import 'Font_Manager.dart';

TextStyle _getTextStyle (double fontSize , FontWeight fontWeight , Color color )
{
  return TextStyle(
    fontSize: fontSize,
    color: color ,
    fontFamily: FontConstants.FontFamily,
    fontWeight: fontWeight
  );
}

//regular style

TextStyle getRegularStyle ({double fontSize = 12.0, required Color color})
{
  return _getTextStyle(
      fontSize,
      FontWeightManager.regular,
      color,
  );
}

//bold style

TextStyle getBoldStyle ({double fontSize = 12.0, required Color color})
{
  return _getTextStyle(
    fontSize,
    FontWeightManager.bold,
    color,
  );
}

//SemiBold style

TextStyle getSemiBoldStyle ({double fontSize = 12.0, required Color color})
{
  return _getTextStyle(
    fontSize,
    FontWeightManager.semiBold,
    color,
  );
}

//regular style

TextStyle getLightStyle ({double fontSize = 12.0, required Color color})
{
  return _getTextStyle(
    fontSize,
    FontWeightManager.light,
    color,
  );
}

//regular style

TextStyle getMediumStyle ({double fontSize = 12.0, required Color color})
{
  return _getTextStyle(
    fontSize,
    FontWeightManager.medium,
    color,
  );
}