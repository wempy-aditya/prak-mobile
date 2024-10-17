import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/exports/controllers_exports.dart';
import '../../utils/exports/managers_exports.dart';
import '../../utils/exports/models_exports.dart';
import 'guest_user_detail_product_screen.dart';

class GuestUserScreen extends StatefulWidget {
  static const String routeName = '/guestUserScreen';

  @override
  _GuestUserScreenState createState() => _GuestUserScreenState();
}

class _GuestUserScreenState extends State<GuestUserScreen> {
  final GuestController guestController = Get.put(GuestController());
  var searchController = TextEditingController();
  RxList<Guest> filteredList = <Guest>[].obs;

  @override
  void initState() {
    super.initState();
    // Initially, show all products
    filteredList.value = guestController.guestList;
    // Add listener for search input changes
    searchController.addListener(_filterProducts);
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void _filterProducts() {
    String query = searchController.text.toLowerCase();
    if (query.isEmpty) {
      // If search input is empty, show all products
      filteredList.value = guestController.guestList;
    } else {
      // Filter products by title
      filteredList.value = guestController.guestList
          .where((guest) => guest.title.toLowerCase().contains(query))
          .toList();
    }
  }

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
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                // Search input field
                TextField(
                  controller: searchController,
                  decoration: InputDecoration(
                    hintText: 'Search products...',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                // Product grid
                Expanded(
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // 4x4 grid with 2 items per row
                      childAspectRatio:
                          0.75, // Adjust aspect ratio for a balanced look
                      crossAxisSpacing: 10, // Spacing between grid items
                      mainAxisSpacing: 10,
                    ),
                    itemCount: filteredList.length,
                    itemBuilder: (context, index) {
                      var guest = filteredList[index];
                      return GestureDetector(
                        onTap: () {
                          // Navigate to the detail screen when the card is clicked
                          Get.to(
                              () => GuestUserDetailProductScreen(guest: guest));
                        },
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          elevation: 5,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Image.network(
                                    guest.image,
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  guest.title,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: Color(0xFF0A0908)),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(height: 4),
                                Text(
                                  'Price: \$${guest.price.toString()}',
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 207, 23, 23)),
                                ),
                                Text(
                                  'Rating: ${guest.rating.rate} (${guest.rating.count} reviews)',
                                  style: TextStyle(color: Colors.grey[600]),
                                ),
                                SizedBox(height: 8),
                                ElevatedButton(
                                  onPressed: () {
                                    // Dummy buy action
                                    Get.snackbar('Purchase',
                                        'You have bought ${guest.title}');
                                  },
                                  child: Text('Buy'),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        Color.fromARGB(255, 189, 158, 121),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 20,
                                      vertical: 10,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        }
      }),
    );
  }
}
