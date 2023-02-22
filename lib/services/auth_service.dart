import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthService extends ChangeNotifier {
  final String _baseUrl = '192.168.1.28:8080';
  final storage = const FlutterSecureStorage();
  bool isLoading = true;

  readToken() async {
    return await storage.read(key: 'token') ?? '';
  }

  readId() async {
    return await storage.read(key: 'id') ?? '';
  }

  Future<String?> login(String email, String password) async {
    final Map<String, dynamic> authData = {'user': email, 'password': password};
    print(authData);
    final url = Uri.http(_baseUrl, '/login', {});
    print(url);
    final resp = await http.post(url, headers: {}, body: json.encode(authData));
    print(resp);
    final Map<String, dynamic> decodedResp = json.decode(resp.body);
    print(decodedResp);
    if (decodedResp['id'] != null) {
      await storage.write(key: 'token', value: decodedResp['token']);
      await storage.write(key: 'id', value: decodedResp['id'].toString());
      return decodedResp['role'] + ',' + decodedResp['listFavs'];
    }
  }

  Future logout() async {
    await storage.deleteAll();
    return;
  }
}
