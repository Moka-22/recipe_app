import 'package:flutter/material.dart';
import 'package:recipe/utils/colors.dart';

import 'widgets/splash_view_widget.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backGroundColor,
      body: SafeArea(
        child: SplashViewWidget(),
      ),
    );
  }
}




