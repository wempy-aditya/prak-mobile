import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../utils/exports/models_exports.dart';
import '../../utils/exports/controllers_exports.dart';

class guestDetailWebview extends StatelessWidget {
  final Guest guest;

  // Initialize the controller
  final GuestDetailController guestDetailController =
      Get.put(GuestDetailController());

  guestDetailWebview({Key? key, required this.guest}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("WebView"),
      ),
      body: WebViewWidget(
        controller: guestDetailController.webViewController(
          "https://noelfakestore.netlify.app/details/${guest.id}",
        ),
      ),
    );
  }
}
