// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:appproducts/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:http/http.dart' as http;

import 'services.dart';

class ProductService extends ChangeNotifier {
  final String _baseUrl = '192.168.1.28:8080';
  bool isLoading = true;
  List<Product> productos = [];
  String producto = "";
  final storage = const FlutterSecureStorage();

  getProductsfilter(String id) async {
    String? token = await AuthService().readToken();

    final url = Uri.http(_baseUrl, 'api/user/categories/$id/products');

    isLoading = true;
    notifyListeners();
    final resp = await http.get(
      url,
      headers: {"Authorization": "Bearer $token"},
    );

    final List<dynamic> decodedResp = json.decode(resp.body);

    List<Product> productList = decodedResp
        .map((e) => Product(
              id: e['id'],
              name: e['name'],
              description: e['description'],
              price: e['price'],
              idCategory: e['idCategory'],
            ))
        .toList();

    productos = productList;
    isLoading = false;
    notifyListeners();
    return productos;
  }

  Future addFav(String id) async {
    String? token = await AuthService().readToken();

    isLoading = true;
    notifyListeners();

    final url = Uri.http(_baseUrl, '/api/user/addFav/$id');

    final resp = await http.post(
      url,
      headers: {"Authorization": "Bearer $token"},
    );

    print(resp.statusCode);

    if (resp.statusCode == 200) {}
  }

  Future<List> getListProducts() async {
    print("Entrando");
    productos.clear();
    isLoading = true;
    notifyListeners();
    final url = Uri.http(_baseUrl, '/api/all/products');
    String? token = await AuthService().readToken();
    print(token);

    final resp = await http.get(
      url,
      headers: {"Authorization": "Bearer $token"},
    );
    print("Resp " + resp.body);
    final List<dynamic> decodedResp = json.decode(resp.body);
    List<Product> categoryList = decodedResp
        .map((e) => Product(
              id: e['id'],
              name: e['name'],
              description: e['description'],
              idCategory: e['idCategory'],
              price: e['price'],
            ))
        .toList();
    print(categoryList);
    productos = categoryList;

    // var catalog = ProductModel.fromJson(decodedResp);
    // print(catalog);
    isLoading = false;
    notifyListeners();
    return categoryList;
  }
}
