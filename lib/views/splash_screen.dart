import 'dart:async';

import '../controllers/auth_controller.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../utils/exports/managers_exports.dart';
import '../widgets/custom_text.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  static const String routeName = '/splashScreen';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final authController = Get.put(AuthenticateController());

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () => authController.checkLoginStatus());
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return SafeArea(
      child: Scaffold(
        body: Stack(
          fit: StackFit.expand, // Membuat gambar sesuai dengan ukuran layar
          children: [
            // Gambar background
            Image.asset(
              'assets/images/bg2.jpg', // Ganti dengan path gambar yang ingin digunakan
              fit: BoxFit.cover, // Menyesuaikan gambar dengan ukuran layar
            ),
            // Konten di atas gambar
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    'assets/images/logo_rm_bg.svg', // Ganti dengan path gambar SVG
                    height: SizeManager.sizeXL * 8, // Atur ukuran gambar
                    width: SizeManager.sizeXL * 8,
                  ),
                  Txt(
                    text: StringsManager.appName,
                    color: isDarkMode
                        ? DarkColorsManager.primaryColor.withOpacity(0.8)
                        : Color.fromARGB(255, 255, 255, 255),
                    fontFamily: FontsManager.fontFamilyPoppins,
                    fontSize: FontSize.headerFontSize * 1.5,
                    fontWeight: FontWeightManager.bold,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
