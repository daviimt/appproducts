import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
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
  List<Product> productosFav = [];
  
  Future<void> getListFav() async {
  productosFav.clear();
    await productService.getListProducts();
    setState(() {
      productosFav = productService.productos;
    });
  }

  @override
  void initState() {
    super.initState();
    getListFav();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lista de Favoritos'),
      backgroundColor: Colors.deepPurple,
      leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacementNamed(context, 'userscreen');
          },
        ),),
      //Sombra debajo del appbar
      body: ListView.separated(
        itemCount: productosFav.length,
        itemBuilder: (context, index) => ListTile(
            leading: const Icon(
              Icons.favorite,
              size: 30,
            ),
            contentPadding: const EdgeInsets.all(16),
            title: Text(productosFav[index].name!,style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
            subtitle: Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height:2),
                Text('Descripción: ' + productosFav[index].description!),
                Text('Precio: ' + productosFav[index].price.toString())
              ],
            )),
        separatorBuilder: (_, __) => const Divider(),
      ),
    );
  }

}
