import 'dart:convert';
import 'package:appproducts/services/services.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class RegisterService extends ChangeNotifier {
  final String _baseUrl = 'localhost:8080/api/';

  Future<String?> register(String username, String password) async {
    final Map<String, dynamic> authData = {
      'username': username,
      'password': password,
    };
    final url = Uri.http(_baseUrl, 'register', {});

    final resp = await http.post(url,
        body: json.encode(authData));

    return null;
  }
}
