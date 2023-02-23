// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:appproducts/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:http/http.dart' as http;

import 'services.dart';

class ProductService extends ChangeNotifier {
  final String _baseUrl = '192.168.244.99:8080';
  bool isLoading = true;
  List<Product> categorias = [];
  String categoria = "";
  final storage = const FlutterSecureStorage();

  getCategories() async {
    String? token = await AuthService().readToken();

    final url = Uri.http(_baseUrl, '/api/all/products');

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
            ))
        .toList();

    categorias = productList;

    isLoading = false;
    notifyListeners();
    return categorias;
  }
}
