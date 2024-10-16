import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/exports/controllers_exports.dart';
import '../utils/exports/managers_exports.dart';
import '../utils/exports/models_exports.dart';
import 'guest_user_detail_product_screen.dart';

class GuestUserScreen extends StatelessWidget {
  static const String routeName = '/guestUserScreen';

  final GuestController guestController = Get.put(GuestController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Guest User Screen'),
      ),
      body: Obx(() {
        if (guestController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        } else {
          return ListView.builder(
            itemCount: guestController.guestList.length,
            itemBuilder: (context, index) {
              var guest = guestController.guestList[index];
              return Card(
                margin: const EdgeInsets.all(10),
                child: ListTile(
                  leading: Image.network(guest.image, width: 50, height: 50),
                  title: Text(guest.title),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Price: \$${guest.price.toString()}'),
                      Text(
                          'Rating: ${guest.rating.rate} (${guest.rating.count} reviews)'),
                    ],
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          // Dummy buy action
                          Get.snackbar(
                              'Purchase', 'You have bought ${guest.title}');
                        },
                        child: Text('Buy'),
                      ),
                      SizedBox(width: 8),
                      ElevatedButton(
                        onPressed: () {
                          // Navigate to the detail screen
                          Get.to(
                              () => GuestUserDetailProductScreen(guest: guest));
                        },
                        child: Text('Open'),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }
      }),
    );
  }
}
