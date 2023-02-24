import 'dart:ffi';
import 'dart:io';
import 'dart:math';
import 'package:appproducts/models/models.dart';

import 'package:intl/intl.dart';

import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:intl/intl.dart';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import '../providers/register_form_provider.dart';
import '../services/services.dart';
import '../services/user_service.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
        leading: IconButton(
          icon: const Icon(Icons.login_outlined),
          onPressed: () {
            Provider.of<AuthService>(context, listen: false).logout();
            Navigator.pushReplacementNamed(context, 'login');
          },
        ),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Center(
            child: Form(
          child: Column(children: [
            ChangeNotifierProvider(
              create: (_) => RegisterFormProvider(),
              child: const _UserForm(),
            ),
          ]),
        )),
      ),
    );
  }
}

class _UserForm extends StatefulWidget {
  const _UserForm({key});

  @override
  State<_UserForm> createState() => _UserFormState();
}

class _UserFormState extends State<_UserForm> {
  bool buttonState = false;
  List<Product> products = [];
  List<Category> categories = [];
  List<bool> isChecked = [];
  List<int> listFavs = [];

  final categoryService = CategoryService();
  final authService = AuthService();
  final productService = ProductService();
  final userservice = UserService();

  List<Product> productos = [];

  Future getCategories() async {
    await categoryService.getCategories();
    setState(() {
      categories = categoryService.categorias;
    });
  }

  Future<void> getListFav() async {
    Future<dynamic> futureData = authService.readListFav();
    List<int> intList = await futureData.then((data) {
      List<int> resultList = List<int>.from(data);
      return resultList;
    });
    setState(() {
      listFavs = intList;
      print(intList);
    });
  }

  Future getAllProducts() async {
    products.clear();
    await productService.getListProducts();
    print(products);
    setState(() {
      products = productService.productos;
      isChecked = List<bool>.filled(products.length, false);
    });
  }

  @override
  void initState() {
    super.initState();
    getCategories();
    getAllProducts();
    getListFav();
  }

  @override
  Widget build(BuildContext context) {
    final categoryService = Provider.of<CategoryService>(context);
    final productService = Provider.of<ProductService>(context);

    print(products);

    getProducts(String id) async {
      products.clear();
      await productService.getProductsfilter(id);
      setState(() {
        products = productService.productos;
        isChecked = List<bool>.filled(products.length, false);
      });
    }

    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        Container(
          width: 300.0,
          child: DropdownButtonFormField(
            icon: Icon(Icons.keyboard_double_arrow_down_rounded),
            hint: const Text('Select a Category'),
            iconSize: 40,
            items: categories.map((e) {
              return DropdownMenuItem(
                value: e.id,
                child: Text(e.name.toString()),
              );
            }).toList(),
            onChanged: (value) {
              buttonState = true;
              getProducts(value.toString());
            },
            validator: (value) {
              return (value != null && value != 0) ? null : 'Select Category';
            },
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.60,
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: products.length,
            itemBuilder: (BuildContext ctxt, int index) {
              return Padding(
                  padding: const EdgeInsets.fromLTRB(9, 10, 9, 10),
                  child: Container(
                      height: 70,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.35,
                            child: Text(
                              products[index].name.toString(),
                              style: const TextStyle(color: Colors.black),
                            ),
                          ),
                          Checkbox(
                            shape: StarBorder(),
                            checkColor: Colors.black,
                            value: isChecked[index],
                            onChanged: (bool? value) {
                              setState(() {
                                isChecked[index] = value!;
                                if (!isChecked[index]) {
                                  getProducts(products[index].id.toString());
                                }
                              });
                            },
                          ),
                        ],
                      )));
            },
          ),
        ),
      ],
    );
  }

  void customToast(String s, BuildContext context) {
    showToast(
      s,
      context: context,
      animation: StyledToastAnimation.scale,
      reverseAnimation: StyledToastAnimation.fade,
      position: StyledToastPosition.top,
      animDuration: const Duration(seconds: 1),
      duration: const Duration(seconds: 4),
      curve: Curves.elasticOut,
      reverseCurve: Curves.linear,
    );
  }
}
