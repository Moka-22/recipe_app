import 'package:flutter/material.dart';
import 'package:recipe/features/home/presentation/views/home_view.dart';
import 'package:recipe/features/splash/presentation/views/widgets/logo_image_widget.dart';

class SplashViewWidget extends StatefulWidget {
  const SplashViewWidget({
    super.key,
  });

  @override
  State<SplashViewWidget> createState() => _SplashViewWidgetState();
}

class _SplashViewWidgetState extends State<SplashViewWidget> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
      Duration(seconds: 3),
      () {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (_) => HomeView(),
          ),
          (route) => false,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: LogoImageWidget(),
        ),
      ],
    );
  }
}
