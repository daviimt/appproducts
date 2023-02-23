// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:appproducts/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:http/http.dart' as http;

import 'services.dart';

class CategoryService extends ChangeNotifier {
  final String _baseUrl = '192.168.244.99:8080';
  bool isLoading = true;
  final List<Category> categorias = [];
  String categoria = "";
  final storage = const FlutterSecureStorage();

  getCategories() async {
    String? token = await AuthService().readToken();

    final url = Uri.http(_baseUrl, '/api/all/categories');
    print(url);
    isLoading = true;
    notifyListeners();
    final resp = await http.get(
      url,
      headers: {"Authorization": "Bearer $token"},
    );
    final List<dynamic> decodedResp = json.decode(resp.body);
    print("DECODED RESP");
    print(decodedResp);
    
    isLoading = false;
    notifyListeners();
    return null;
  }
}
