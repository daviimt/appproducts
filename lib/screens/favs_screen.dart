import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:provider/provider.dart';
import '../models/models.dart';
import '../services/services.dart';

class FavsScreen extends StatefulWidget {
  const FavsScreen({Key? key}) : super(key: key);

  @override
  State<FavsScreen> createState() => _FavsScreenState();
}

class _FavsScreenState extends State<FavsScreen> {
  final authService = AuthService();
  final productService = ProductService();
  List<dynamic> favs = [];
  List<Product> products = [];
  Future refresh() async {
    setState(() {
      favs = Provider.of<AuthService>(context, listen: false).Favs;
      for (var i in favs) {
        productService.getProduct(i.toString());
        print(productService.p);
        products.add(productService.p);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    refresh();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lista de Favoritos')),
      //Sombra debajo del appbar
      body: ListView.separated(
        itemCount: products.length,
        itemBuilder: (context, index) => ListTile(
            leading: const Icon(
              Icons.favorite,
              size: 50,
            ),
            contentPadding: const EdgeInsets.all(16),
            title: Text(products[index].name!),
            subtitle: Text(products[index].description!)),
        separatorBuilder: (_, __) => const Divider(),
      ),
    );
  }

  void customToast(String message, BuildContext context) {
    showToast(
      message,
      textStyle: const TextStyle(
        fontSize: 14,
        wordSpacing: 0.1,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
      textPadding: const EdgeInsets.all(23),
      fullWidth: true,
      toastHorizontalMargin: 25,
      borderRadius: BorderRadius.circular(15),
      backgroundColor: Colors.deepPurple[500],
      alignment: Alignment.topCenter,
      position: StyledToastPosition.bottom,
      duration: const Duration(seconds: 3),
      animation: StyledToastAnimation.slideFromBottom,
      context: context,
    );
  }
}
