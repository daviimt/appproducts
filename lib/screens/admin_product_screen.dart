import 'dart:ffi';

import 'package:flutter/material.dart';

import 'package:getwidget/components/button/gf_icon_button.dart';
import 'package:provider/provider.dart';

import '../models/models.dart';
import '../services/auth_service.dart';
import '../services/product_service.dart';
import '../services/services.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  final productService = ProductService();
  final categoryService = CategoryService();

  List<Product> productos = [];
  List<Category> categories = [];

  Future getProducts() async {
    await productService.getListProducts();
    setState(() {
      productos.clear();
      productos = productService.productos;
    });
  }

  Future getCategories() async {
    await categoryService.getCategories();
    setState(() {
      categories.clear();
      categories = categoryService.categorias;
    });
  }

  @override
  void initState() {
    super.initState();
    getProducts();
    getCategories();
  }

  @override
  Widget build(BuildContext context) {
    // ignore: no_leading_underscores_for_local_identifiers
    void _onItemTapped(int index) {
      if (index == 1) {
        Navigator.pushReplacementNamed(context, 'adminproductsscreen');
      } else {
        Navigator.pushReplacementNamed(context, 'admincategoryscreen');
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Productos'),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        leading: IconButton(
          icon: const Icon(Icons.login_outlined),
          onPressed: () {
            Provider.of<AuthService>(context, listen: false).logout();
            Navigator.pushReplacementNamed(context, 'login');
          },
        ),
      ),
      body: builListView(context, productos),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Categorias'),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart_outlined), label: 'Productos'),
        ],
        currentIndex: 1, //New
        onTap: _onItemTapped,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          int id = 0;
          String name = '';
          String description = '';
          String price = '';
          showDialog(
            context: context,
            builder: (BuildContext context) {
              // return object of type Dialog
              return AlertDialog(
                title: const Text("Crear Producto"),
                content: SizedBox(
                  height: 230,
                  child: Column(
                    children: [
                      TextFormField(
                        initialValue: name,
                        onChanged: (String textTyped) {
                          setState(() {
                            name = textTyped;
                          });
                        },
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(hintText: 'Nombre'),
                      ),
                      TextFormField(
                        initialValue: description,
                        onChanged: (String textTyped) {
                          setState(() {
                            description = textTyped;
                          });
                        },
                        keyboardType: TextInputType.text,
                        decoration:
                            const InputDecoration(hintText: 'Descripcion'),
                      ),
                      TextFormField(
                        initialValue: price,
                        onChanged: (String textTyped) {
                          setState(() {
                            price = textTyped;
                          });
                        },
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(hintText: 'Precio'),
                      ),
                      Container(
                        width: 300.0,
                        child: DropdownButtonFormField(
                          icon: Icon(Icons.keyboard_double_arrow_down_rounded),
                          hint: const Text('Selecciona una categoria'),
                          iconSize: 40,
                          items: categories.map((e) {
                            return DropdownMenuItem(
                              value: e.id,
                              child: Text(e.name.toString()),
                            );
                          }).toList(),
                          onChanged: (value) {
                            id = value ?? 0;
                          },
                          validator: (value) {
                            return (value != null && value != 0)
                                ? null
                                : 'Selecciona Categoria';
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                actions: <Widget>[
                  // usually buttons at the bottom of the dialog
                  Row(
                    children: <Widget>[
                      TextButton(
                        child: new Text("Cancelar"),
                        onPressed: () {
                          setState(() {});
                          Navigator.of(context).pop();
                        },
                      ),
                      TextButton(
                          onPressed: () {
                            productService.create(name, description, price, id);
                            getProducts();
                            Navigator.pop(context);
                            getProducts();
                          },
                          child: new Text("OK"))
                    ],
                  ),
                ],
              );
            },
          );
          // Add your onPressed code here!
        },
        backgroundColor: Colors.deepPurple,
        child: const Icon(
          Icons.add,
          size: 40,
        ),
      ),
    );
  }

  Widget builListView(BuildContext context, List articles) {
    return ListView.separated(
      padding: const EdgeInsets.all(30),
      itemCount: articles.length,
      itemBuilder: (BuildContext context, index) {
        return SizedBox(
          height: 200,
          child: Card(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            color: Color(0xFFF5F5F5),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        productos[index].name!,
                        style: const TextStyle(fontSize: 20),
                      ),
                      Text(
                        productos[index].description!,
                        style: const TextStyle(fontSize: 20),
                      ),
                      Text(
                        'Precio : ${productos[index].price}',
                        style: const TextStyle(fontSize: 20),
                      ),
                      Text('${productos[index].id}',
                          style: const TextStyle(fontSize: 20)),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      GFIconButton(
                        color: Colors.deepPurple,
                        onPressed: () {
                          String name = '${productos[index].name}' ?? '';
                          String description =
                              '${productos[index].description}' ?? '';
                          String price = '${productos[index].price}' ?? '';
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              // return object of type Dialog
                              return AlertDialog(
                                title: const Text("Modificar Producto"),
                                content: SizedBox(
                                  height: 150,
                                  child: Column(
                                    children: [
                                      TextFormField(
                                        initialValue: name,
                                        onChanged: (String textTyped) {
                                          setState(() {
                                            name = textTyped;
                                          });
                                        },
                                        keyboardType: TextInputType.text,
                                        decoration: const InputDecoration(
                                            hintText: 'Nombre'),
                                      ),
                                      TextFormField(
                                        initialValue: description,
                                        onChanged: (String textTyped) {
                                          setState(() {
                                            description = textTyped;
                                          });
                                        },
                                        keyboardType: TextInputType.text,
                                        decoration: const InputDecoration(
                                            hintText: 'Descripcion'),
                                      ),
                                      TextFormField(
                                        initialValue: price,
                                        onChanged: (String textTyped) {
                                          setState(() {
                                            price = textTyped;
                                          });
                                        },
                                        keyboardType: TextInputType.number,
                                        decoration: const InputDecoration(
                                            hintText: 'Precio'),
                                      ),
                                    ],
                                  ),
                                ),
                                actions: <Widget>[
                                  // usually buttons at the bottom of the dialog
                                  Row(
                                    children: <Widget>[
                                      TextButton(
                                        child: new Text("Cancelar"),
                                        onPressed: () {
                                          setState(() {});
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                      TextButton(
                                          onPressed: () {
                                            productService.modify(
                                                productos[index].id!,
                                                name,
                                                description,
                                                price);
                                            getProducts();
                                            Navigator.pop(context);
                                            getProducts();
                                          },
                                          child: new Text("OK"))
                                    ],
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        icon: const Icon(
                          Icons.edit,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                      GFIconButton(
                        color: Colors.deepPurple,
                        onPressed: () {
                          showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              title: const Text('Eliminar Producto'),
                              content: const Text('¿Estas seguro?'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text('No'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    productService.deleteProduct(
                                        productos[index].id.toString());
                                    setState(() {
                                      productos.removeWhere((element) =>
                                          (element == productos[index]));
                                    });
                                    Navigator.pop(context);
                                  },
                                  child: const Text('Si'),
                                ),
                              ],
                            ),
                          );
                        },
                        icon: const Icon(
                          Icons.delete_outlined,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return const Divider();
      },
    );
  }
}
