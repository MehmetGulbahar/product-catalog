import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';

class PriceText extends StatelessWidget {
  final double price;
  final double? fontSize;
  final FontWeight fontWeight;
  final Color color;

  const PriceText({
    super.key,
    required this.price,
    this.fontSize,
    this.fontWeight = FontWeight.w700,
    this.color = AppColors.navy,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      '\$${price.toStringAsFixed(2)}',
      style: TextStyle(
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight,
        letterSpacing: 0.2,
      ),
    );
  }
}
