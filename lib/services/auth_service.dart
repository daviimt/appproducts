import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthService extends ChangeNotifier {
  final String _baseUrl = '10.10.1.22:8080';
  final storage = const FlutterSecureStorage();
  bool isLoading = true;

  readToken() async {
    return await storage.read(key: 'token') ?? '';
  }

  readId() async {
    return await storage.read(key: 'id') ?? '';
  }

  Future<String?> login(String user, String password) async {
    final Map<String, dynamic> authData = {'user': user, 'password': password};

    final url = Uri.http(_baseUrl, '/login', {});

    var request = http.MultipartRequest(
        'POST', Uri.parse('http://10.10.1.22:8080/login'));

    request.fields['user'] = user;
    request.fields['password'] = password;

    var response = await request.send();

    if (response.statusCode == 200) {
      String values = "";
      await response.stream.transform(utf8.decoder).listen((value) {
        values = value;
      });

      final Map<String, dynamic> decodedResp = json.decode(values);
      print(decodedResp);

      await storage.write(key: 'token', value: decodedResp['token']);
      await storage.write(key: 'id', value: decodedResp['id'].toString());
      return decodedResp['role'] +
          ',' +
          response.statusCode.toString() +
          ',' +
          decodedResp['enabled'].toString();
    } else {
      return '' + ',' + response.statusCode.toString();
    }
  }

  Future logout() async {
    await storage.deleteAll();
    return;
  }
}
