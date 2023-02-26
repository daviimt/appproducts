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
  List<int> listFavs = [];
  List<Product> listProductosFav = [];
  String producto = "";
  Product p = Product();
  final storage = const FlutterSecureStorage();

  getProductsfilter(String id) async {
    productos.clear();
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
  }

  Future<List> getListProducts() async {
    productos.clear();
    isLoading = true;
    notifyListeners();
    final url = Uri.http(_baseUrl, '/api/all/products');
    String? token = await AuthService().readToken();

    final resp = await http.get(
      url,
      headers: {"Authorization": "Bearer $token"},
    );
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
    productos = categoryList;

    isLoading = false;
    notifyListeners();

    return categoryList;
  }

  Future<Product> getProduct(String id) async {
    String? token = await AuthService().readToken();

    final url = Uri.http(_baseUrl, '/api/all/products/$id');

    isLoading = true;
    notifyListeners();
    final resp = await http.get(
      url,
      headers: {"Authorization": "Bearer $token"},
    );
    final Map<String, dynamic> decodedResp = json.decode(resp.body);

    Product product = Product(
      id: decodedResp['id'],
      name: decodedResp['name'],
      description: decodedResp['description'],
      idCategory: decodedResp['idCategory'],
      price: decodedResp['price'],
    );

    p = product;

    isLoading = false;
    notifyListeners();
    return product;
  }

  Future<dynamic> getListFavs() async {
    listFavs.clear();
    isLoading = true;
    notifyListeners();
    final url = Uri.http(_baseUrl, '/api/user/getFavs');
    String? token = await AuthService().readToken();

    final resp = await http.get(
      url,
      headers: {"Authorization": "Bearer $token"},
    );
    final List<dynamic> decodedResp = json.decode(resp.body);

    isLoading = false;
    notifyListeners();

    return decodedResp;
  }

  Future<List> getListProductosFav() async {
    listProductosFav.clear();
    List<dynamic> favs = await getListFavs();
    isLoading = true;
    notifyListeners();
    print("Lista de favoritos");
    print(favs);

    for (var i in favs) {
      listProductosFav.add(await getProduct(i.toString()));
      print("GET producto Favorito: ");
      print(await getProduct(i.toString()));
    }
    print("Lista de productos favoritos");
    print(listProductosFav);
    isLoading = false;
    notifyListeners();

    return listProductosFav;
  }

  Future delFav(String id) async {
    String? token = await AuthService().readToken();
    isLoading = true;
    notifyListeners();
    final url = Uri.http(_baseUrl, '/api/user/deleteFav/$id');
    final resp = await http.put(
      url,
      headers: {"Authorization": "Bearer $token"},
    );
    print(resp.statusCode);
    if (resp.statusCode == 200) {}
  }
}
