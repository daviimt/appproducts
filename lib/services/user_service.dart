// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:appproducts/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:http/http.dart' as http;

import 'services.dart';

class UserService extends ChangeNotifier {
  final String _baseUrl = '172.20.10.5:8080';
  bool isLoading = true;
  final List<User> usuarios = [];
  String usuario = "";
  final storage = const FlutterSecureStorage();

  getCategories() async {
    String? token = await AuthService().readToken();
    String? id = await AuthService().readId();

    final url = Uri.http(_baseUrl, '/api/user/$id');
    isLoading = true;
    notifyListeners();
    final resp = await http.get(
      url,
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        "Authorization": "Bearer $token"
      },
    );
    final Map<String, dynamic> decodedResp = json.decode(resp.body);
    await storage.write(
        key: 'company_id', value: decodedResp['data']['company_id'].toString());
    isLoading = false;
    notifyListeners();
    return decodedResp['data']['company_id'].toString();
  }

  readCompany_id() async {
    return await storage.read(key: 'company_id') ?? '';
  }

  Future postActivate(String id) async {
    final url = Uri.http(_baseUrl, '/public/api/activate', {'user_id': id});
    String? token = await AuthService().readToken();
    isLoading = true;
    notifyListeners();
    final resp = await http.post(
      url,
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        "Authorization": "Bearer $token"
      },
    );
  }

  Future postDeactivate(String id) async {
    final url = Uri.http(_baseUrl, '/public/api/deactivate', {'user_id': id});
    String? token = await AuthService().readToken();
    isLoading = true;
    notifyListeners();
    final resp = await http.post(
      url,
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        "Authorization": "Bearer $token"
      },
    );
  }

  Future postDelete(String id) async {
    final url = Uri.http(_baseUrl, '/public/api/delete', {'user_id': id});
    String? token = await AuthService().readToken();
    isLoading = true;
    notifyListeners();
    final resp = await http.post(
      url,
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        "Authorization": "Bearer $token"
      },
    );
  }
}
