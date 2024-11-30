import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather/model/product_modal.dart';
import 'package:weather/model/user_modal.dart';

class StorageHelper {
  static const String _emailKey = 'user_email';
  static const String _passwordKey = 'user_password';
  static const String _productKey = 'products_list';

  // StorageHelper

  static Future<void> saveUser(String email, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_emailKey, email);
    await prefs.setString(_passwordKey, password);
  }

  static Future<UserModel?> getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? email = prefs.getString(_emailKey);
    String? password = prefs.getString(_passwordKey);

    if (email != null && password != null) {
      return UserModel(email: email, password: password);
    }
    return null;
  }

  static Future<void> clearUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_emailKey);
    await prefs.remove(_passwordKey);
  }

  static Future<void> saveProducts(List<Product> products) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> productStrings = products.map((product) => jsonEncode(product.toJson())).toList();
    await prefs.setStringList(_productKey, productStrings);
  }

  // add_product_screen

  static Future<List<Product>> getProducts() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? productStrings = prefs.getStringList(_productKey);

    if (productStrings != null) {
      return productStrings.map((item) => Product.fromJson(jsonDecode(item))).toList();
    }
    return [];
  }
}
