import 'dart:io';

import 'package:e_commerce_shopping_app/views/product_overview_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import '../managers/firebase_manager.dart';
import '../models/product_model.dart';

class ProductController extends GetxController {
  final RxList<Product> _products = RxList<Product>([]);
  List<Product> get products => _products;

  final RxList<Product> _myProducts = RxList<Product>([]);
  List<Product> get myProducts => _myProducts;

  final RxList<Product> _favProducts = RxList<Product>([]);
  List<Product> get favProducts => _favProducts;

  final productNameController = TextEditingController();
  final productDescriptionController = TextEditingController();
  final productPriceController = TextEditingController();
  final productStockQuantityController = TextEditingController();
  final productCategoryController = TextEditingController();

  Rx<bool> isLoading = false.obs;
  final addFormKey = GlobalKey<FormState>();

  final Rx<File?> _pickedImage = Rx<File?>(null);
  File? get posterPhoto => _pickedImage.value;

  final Rx<String> _productNameRx = "".obs;
  final Rx<String> _productDescriptionRx = "".obs;

  String get productName => _productNameRx.value;
  String get productDescription => _productDescriptionRx.value;

  @override
  void onInit() {
    super.onInit();
    fetchProducts();
    fetchFavoriteProducts(firebaseAuth.currentUser!.uid);
  }

  void fetchProducts() {
    isLoading.value = true;
    firestore.collection('products').get().then((querySnapshot) {
      final products = querySnapshot.docs.map((doc) {
        final productData = doc.data();
        final product = Product.fromMap(productData);

        if (product.ownerId == firebaseAuth.currentUser!.uid) {
          _myProducts.add(product);
        }
        return product;
      }).toList();

      _products.value = products;
    });
  }

  void toggleLoading() {
    isLoading.value = !isLoading.value;
  }

  Future<String> _uploadToStorage(File image, String id) async {
    Reference ref = firebaseStorage.ref().child('products').child(id);

    UploadTask uploadTask = ref.putFile(image);
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }

  Future<String> getUniqueId() async {
    var allDocs = await firestore.collection('products').get();
    int len = allDocs.docs.length;
    return len.toString();
  }

  void pickImage() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      Get.snackbar('Product Picture Added!',
          'Anda telah berhasil menambahkan gambar produk!');
    }
    _pickedImage.value = File(pickedImage!.path);
    update();
  }

  Future<void> addProduct(
      String name, String description, String price, String stockQty) async {
    if (addFormKey.currentState!.validate()) {
      addFormKey.currentState!.save();
      toggleLoading();
      String id = await getUniqueId();
      String imageUrl = await _uploadToStorage(_pickedImage.value!, id);
      name = name.toLowerCase();
      Product product = Product(
        id: id,
        name: name,
        description: description,
        price: int.parse(price),
        imageUrl: imageUrl,
        stockQuantity: int.parse(stockQty),
        ownerId: firebaseAuth.currentUser!.uid,
      );
      await firestore.collection('products').doc(id).set(product.toJson());
      toggleLoading();
      _myProducts.add(product);
      Get.back();
      Get.snackbar(
        'Success!',
        'Produk berhasil ditambahkan.',
      );
      resetFields();
    }
  }

  Future<String> _updateToStorage(File newImage, String id) async {
    Reference ref = firebaseStorage.ref().child('products').child(id);

    await ref.delete();

    UploadTask uploadTask = ref.putFile(newImage);
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }

  Future<String> getImageFromStorage(String id) async {
    Reference ref = firebaseStorage.ref().child('products').child(id);
    String downloadUrl = await ref.getDownloadURL();
    return downloadUrl;
  }

  Future<void> updateProduct(
    String id,
    String name,
    String description,
    String price,
    String stockQty,
    String oldImageUrl,
    File? image,
    ProductController controller,
  ) async {
    toggleLoading();
    String imageUrl = "";
    if (image != null) {
      imageUrl = await _updateToStorage(image, id);
    } else {
      imageUrl = oldImageUrl;
    }

    Product product = Product(
      id: id,
      name: name,
      description: description,
      ownerId: firebaseAuth.currentUser!.uid,
      imageUrl: imageUrl,
      price: int.parse(price),
      stockQuantity: int.parse(stockQty),
    );

    await firestore
        .collection('products')
        .doc(id)
        .update(product.toJson())
        .whenComplete(() {
      _productNameRx.value = product.name;
      _productDescriptionRx.value = product.description;

      toggleLoading();
      Get.offAll(
          ProductOverviewScreen(product: product, controller: controller));
      Get.snackbar(
        'Product Updated.',
        'Anda telah berhasil memperbarui produk.',
      );
      resetFields();
    });
  }

  Future<void> deleteProduct(String productId) async {
    await firestore.collection('products').doc(productId).delete();
    await firebaseStorage.ref().child('products').child(productId).delete();
  }

  Future<void> toggleFavoriteStatus(Product product) async {
    try {
      var userDocRef =
          firestore.collection('favorites').doc(firebaseAuth.currentUser!.uid);
      var userDoc = await userDocRef.get();

      if (userDoc.exists) {
        var productIds = userDoc.data()?['productIds'] ?? [];

        if (productIds.contains(product.id)) {
          productIds.remove(product.id);
          Get.snackbar('Success!', 'Produk dihapus dari favorit.');
        } else {
          productIds.add(product.id);
          Get.snackbar('Success!', 'Produk ditambahkan ke favorit.');
        }

        await userDocRef.update({'productIds': productIds});
      } else {
        await userDocRef.set({
          'productIds': [product.id]
        });
        Get.snackbar('Success!', 'Produk ditambahkan ke favorit.');
      }

      fetchFavoriteProducts(firebaseAuth.currentUser!.uid);
    } catch (error) {
      Get.snackbar('Failure!', error.toString());
    }
  }

  Future<bool> getFavoriteStatus(String productId) async {
    try {
      var userDocRef =
          firestore.collection('favorites').doc(firebaseAuth.currentUser!.uid);
      var userDoc = await userDocRef.get();

      if (userDoc.exists) {
        var favoritesData = userDoc.data();
        var productIds = favoritesData?['productIds'] ?? [];

        return productIds.contains(productId);
      } else {
        return false;
      }
    } catch (error) {
      Get.snackbar('Error', error.toString());
      return false;
    }
  }

  Future<List<Product>> fetchFavoriteProducts(String userId) async {
    try {
      var userDocRef = firestore.collection('favorites').doc(userId);
      var userDoc = await userDocRef.get();

      if (userDoc.exists) {
        var favoritesData = userDoc.data();
        var productIds = favoritesData!['productIds'] as List<dynamic>;

        var favoriteProducts = <Product>[];

        for (var productId in productIds) {
          var productDocRef = firestore.collection('products').doc(productId);
          var productDoc = await productDocRef.get();

          if (productDoc.exists) {
            var productData = productDoc.data();
            var product = Product.fromMap(productData!);
            favoriteProducts.add(product);
          }
        }
        isLoading.value = false;
        return favoriteProducts;
      } else {
        isLoading.value = false;
        return [];
      }
    } catch (error) {
      isLoading.value = false;
      Get.snackbar('Failure!', error.toString());
      return [];
    }
  }

  void resetFields() {
    productCategoryController.clear();
    productPriceController.clear();
    productNameController.clear();
    productDescriptionController.clear();
    productStockQuantityController.clear();
    _pickedImage.value = null;
  }
}
