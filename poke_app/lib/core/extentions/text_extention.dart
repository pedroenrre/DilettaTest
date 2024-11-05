import 'package:flutter/material.dart';
import 'package:poke_app/core/constants/app_colors.dart';

extension TextModifier on Text {
  Text cardTitle({Color? color, TextAlign? textAlign}) {
    return Text(
      data ?? '',
      textAlign: textAlign ?? TextAlign.start,
      style: TextStyle(
        fontWeight: FontWeight.w600,
        color: color ?? AppColors.darkGreyFont,
        fontSize: 20,
      ),
    );
  }

  Text cardRegular({Color? color, TextAlign? textAlign}) {
    return Text(
      data ?? '',
      textAlign: textAlign ?? TextAlign.start,
      style: TextStyle(
        fontWeight: FontWeight.w600,
        color: color ?? AppColors.darkGreyFont,
        fontSize: 16,
      ),
    );
  }
}
