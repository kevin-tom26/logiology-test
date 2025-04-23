import 'package:flutter/material.dart';
import 'package:prodex/core/storage/local_storage.dart';
import 'package:prodex/routes.dart';
import 'package:prodex/utils/constants/image.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  //late StartupService _startupService;
  bool runOnce = true;

  @override
  void initState() {
    // _startupService = StartupService();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (runOnce) {
      runOnce = false;
      Future.delayed(const Duration(seconds: 3), () {
        _navigate();
      });
    }
  }

  _navigate() async {
    final bool isFirst = LocalStorage().readData('isFirstTime') ?? true;
    if (!isFirst) {
      _executeHomePageStatement();
    } else {
      _executeLoginBoardStatement();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0xffFFFFFF),
      child: Container(
        width: context.width,
        height: context.height,
        decoration: const BoxDecoration(
          color: Colors.white,
          image: DecorationImage(
            image: AssetImage(PImages.splashScreenImg),
            fit: BoxFit.fill,
            // alignment: Alignment.topCenter,
          ),
        ),
        alignment: Alignment.center,
      ),
    );
  }

  void _executeHomePageStatement() {
    Get.offAllNamed(AppRoutes.product);
  }

  void _executeLoginBoardStatement() {
    Get.offAllNamed(AppRoutes.auth);
  }
}
