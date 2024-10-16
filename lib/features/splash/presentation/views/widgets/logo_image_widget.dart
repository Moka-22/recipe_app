import 'package:flutter/material.dart';
import 'package:recipe/generated/assets.dart';

class LogoImageWidget extends StatelessWidget {
  const LogoImageWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      Assets.imagesLogoo,
      width: 200,
      height: 200,
    );
  }
}