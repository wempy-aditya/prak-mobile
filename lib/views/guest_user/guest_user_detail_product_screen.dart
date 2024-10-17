import 'package:e_commerce_shopping_app/views/guest_user/guest_detail_webview.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utils/exports/models_exports.dart';

class GuestUserDetailProductScreen extends StatelessWidget {
  final Guest guest;

  const GuestUserDetailProductScreen({Key? key, required this.guest})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(guest.title),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(guest.image),
              const SizedBox(height: 20),
              Text(
                guest.title,
                style: Theme.of(context).textTheme.headline6,
              ),
              const SizedBox(height: 10),
              Text(
                'Harga: \$${guest.price}',
                style: Theme.of(context).textTheme.subtitle1,
              ),
              const SizedBox(height: 10),
              Text(
                'Category: ${guest.category}',
                style: Theme.of(context).textTheme.subtitle1,
              ),
              const SizedBox(height: 10),
              Text(
                'Rating: ${guest.rating.rate} (${guest.rating.count} reviews)',
                style: Theme.of(context).textTheme.subtitle1,
              ),
              const SizedBox(height: 10),
              Text(
                guest.description,
                style: Theme.of(context).textTheme.bodyText2,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Dummy add to cart action
                  Get.snackbar('Add to Cart',
                      '${guest.title} has been added to your cart');
                },
                child: Text('Add to Cart'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Dummy add to cart action
                  Get.to(() => guestDetailWebview(guest: guest));
                },
                child: Text('Read More'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
