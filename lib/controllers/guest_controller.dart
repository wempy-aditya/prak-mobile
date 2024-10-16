import 'package:get/get.dart';
import 'package:dio/dio.dart';
import '../models/guest_model.dart';

class GuestController extends GetxController {
  var isLoading = true.obs;
  var guestList = <Guest>[].obs;

  @override
  void onInit() {
    fetchGuests();
    super.onInit();
  }

  void fetchGuests() async {
    try {
      isLoading(true);
      var response =
          await Dio().get('https://fakestoreapi.com/products?limit=10');
      if (response.statusCode == 200) {
        var jsonResponse = response.data as List;
        guestList.value =
            jsonResponse.map((item) => Guest.fromJson(item)).toList();
      }
    } finally {
      isLoading(false);
    }
  }
}
