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
  List<Category> categorias = [];
  String categoria = "";
  final storage = const FlutterSecureStorage();

  getCategories() async {
    String? token = await AuthService().readToken();

    final url = Uri.http(_baseUrl, '/api/all/categories');

    isLoading = true;
    notifyListeners();
    final resp = await http.get(
      url,
      headers: {"Authorization": "Bearer $token"},
    );
    final List<dynamic> decodedResp = json.decode(resp.body);

    List<Category> categoryList = decodedResp
        .map((e) => Category(
              id: e['id'],
              name: e['name'],
              description: e['description'],
            ))
        .toList();

    categorias = categoryList;

    isLoading = false;
    notifyListeners();
    return categorias;
  }

  Future deleteCategory(String id) async {
    final url = Uri.http(_baseUrl, '/api/admin/categories/$id');
    String? token = await AuthService().readToken();
    print(url);
    isLoading = true;
    notifyListeners();
    // ignore: unused_local_variable
    final resp = await http.delete(
      url,
      headers: {"Authorization": "Bearer $token"},
    );
  }

  Future updateCategory(String id, String name, String description) async {
    String? token = await AuthService().readToken();
    print(id);
    print(name);
    print(description);

    isLoading = true;
    notifyListeners();

    // ignore: unused_local_variable

    var request = http.MultipartRequest('PUT',
        Uri.parse('http://192.168.244.99:8080/api/admin/categories/$id'));

    request.fields['name'] = name;
    request.fields['description'] = description;
    request.headers.addAll({"Accept":"application/json","Authorization": "Bearer $token"});

    var response = await request.send();
    print(response.statusCode);

    if (response.statusCode == 200) {
      // String values = "";
      // await response.stream.transform(utf8.decoder).listen((value) {
      //   values = value;
      // });
      print('FUNSIONA PERRO');
    }
  }
}
