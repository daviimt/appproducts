import 'package:flutter/material.dart';

class UserScreen extends StatelessWidget {
   
  const UserScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
         child: Text('UserScreen'),
      ),
    );
  }
}


// import 'package:flutter/material.dart';
// import 'package:flutter_styled_toast/flutter_styled_toast.dart';
// import '../models/models.dart';
// import '../providers/providers.dart';
// import 'package:provider/provider.dart';
// class UserScreen extends StatelessWidget {
//   const UserScreen({Key? key}) : super(key: key);
  
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('New Order'),
//       ),
//       body: SizedBox(
//         height: MediaQuery.of(context).size.height,
//         child: Center(
//             child: Form(
//           child: Column(children: [
//             ChangeNotifierProvider(
//               create: (_) => RegisterFormProvider(),
//               child: const _RegisterForm(),
//             ),
//           ]),
//         )),
//       ),
//     );
//   }
// }

// class _RegisterForm extends StatefulWidget {
//   const _RegisterForm({key});

//   @override
//   State<_RegisterForm> createState() => _RegisterFormState();
// }

// class _RegisterFormState extends State<_RegisterForm> {
//   bool buttonState = false;
//   List<Product> products = [];
//   final categoryService = CategoryService();

//   Future getListCategories() async {
//     List<Product> listProductos = await categoryService.getCategories();
//     setState(() {
//       products = listProductos;
//     });
//   }

//   @override
//   void initState() {
//     super.initState();
//     getListCategories();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final registerForm = Provider.of<RegisterFormProvider>(context);
//     final categoryService = Provider.of<CiclesService>(context);
//     final userService = Provider.of<UserService>(context);
//     List<Product> productos = userService.listProductos;
//     List<Data> aux = [];

//     Data miEmpresa = Data();
//     double precioTotal = 0;
//     getPrecio(int cant, double precio) {
//       double preci = cant * precio;
//       precioTotal += preci;
//       return preci;
//     }

//     for (var i in productos) {
//       if (i.id.toString() != company_id) {
//         aux.add(i);
//       }
//       print(i.id.toString() + ' ' + company_id.toString());
//     }
//     for (var i in ciclos) {
//       if (i.id.toString() == company_id) {
//         miEmpresa = i;
//       }
//     }

//     DateTime now = new DateTime.now();
//     DateTime date = DateTime(now.year, now.month, now.day);
//     final DateFormat formatter = DateFormat('yyyy-MM-dd');
//     final String fechaFormat = formatter.format(date);
//     Future<String> getlocalPath() async {
//       final directory = await getApplicationDocumentsDirectory();

//       return directory.path;
//     }

//     getList() async {
//       products.clear();
//       await productsService.getCatalog(registerForm.cicleid);
//       setState(() {
//         products = productsService.aux;
//         isChecked = List<bool>.filled(products.length, false);
//       });
//     }

//     return Column(
//       children: [
//         const SizedBox(
//           height: 20,
//         ),
//         Container(
//           width: 300.0,
//           child: DropdownButtonFormField(
//             icon: Icon(Icons.keyboard_double_arrow_down_rounded),
//             hint: const Text('Select a company'),
//             iconSize: 40,
//             items: aux.map((e) {
//               return DropdownMenuItem(
//                 value: e.id,
//                 child: Text(e.name.toString()),
//               );
//             }).toList(),
//             onChanged: (value) {
//               registerForm.cicleid = value! as int;
//               buttonState = true;
//               getList();
//             },
//             validator: (value) {
//               return (value != null && value != 0) ? null : 'Select a Company';
//             },
//           ),
//         ),
//         const SizedBox(
//           height: 20,
//         ),
//         const SizedBox(
//           height: 10,
//         ),
//         SizedBox(
//           height: MediaQuery.of(context).size.height * 0.60,
//           child: ListView.builder(
//             scrollDirection: Axis.vertical,
//             itemCount: products.length,
//             itemBuilder: (BuildContext ctxt, int index) {
//               double valorPrueba = 0;
//               return Padding(
//                   padding: const EdgeInsets.fromLTRB(9, 10, 9, 10),
//                   child: Container(
//                       height: 70,
//                       decoration: BoxDecoration(
//                         border: Border.all(color: Colors.black),
//                       ),
//                       child: Row(
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Checkbox(
//                             checkColor: Colors.black,
//                             value: isChecked[index],
//                             onChanged: (bool? value) {
//                               setState(() {
//                                 isChecked[index] = value!;
//                                 if (!isChecked[index]) {
//                                   pedido.remove(
//                                       products[index].articleId.toString());
//                                 }
//                               });
//                             },
//                           ),
//                           SizedBox(
//                             width: MediaQuery.of(context).size.width * 0.35,
//                             child: Text(
//                               products[index].compamyDescription.toString(),
//                               style: const TextStyle(color: Colors.black),
//                             ),
//                           ),
//                           SizedBox(
//                             width: MediaQuery.of(context).size.width * 0.45,
//                             child: Container(
//                               padding: const EdgeInsets.symmetric(
//                                   horizontal: 25, vertical: 10),
//                               child: Visibility(
//                                 visible: isChecked[index],
//                                 child: SpinBox(
//                                     min: 1,
//                                     max: 40,
//                                     step: 1,
//                                     readOnly: true,
//                                     decimals: 0,
//                                     value: valorPrueba,
//                                     onChanged: (value) {
//                                       valorPrueba = value;
//                                       print(pedido);
//                                       pedido[products[index]
//                                               .articleId
//                                               .toString()] =
//                                           value.toInt().toString();
//                                     }),
//                               ),
//                             ),
//                           ),
//                         ],
//                       )));
//             },
//           ),
//         ),
//         if (buttonState == true && ciclesService.isLoading == false)
//           Container(
//             child: MaterialButton(
//               disabledColor: Colors.white,
//               color: Colors.blue[900],
//               onPressed: () async {
//                 if (pedido.isEmpty) {
//                   customToast('You must select one product', context);
//                 } else {
//                   final newOrderService =
//                       Provider.of<NewOrderService>(context, listen: false);
//                   int num = 1 + Random().nextInt((99999 + 1) - 1);
//                   newOrderService.getNewOrder(num.toString(), pedido, date,
//                       company_id!, registerForm.cicleid.toString());
//                   final pdf = pw.Document();
//                   Data targetCompany = Data();
//                   for (var i in ciclos) {
//                     if (i.id.toString() == registerForm.cicleid.toString()) {
//                       targetCompany = i;
//                     }
//                   }
//                   pdf.addPage(pw.Page(
//                       pageFormat: PdfPageFormat.a4,
//                       build: (pw.Context context) {
//                         return pw.Column(children: [
//                           pw.Row(
//                               mainAxisAlignment:
//                                   pw.MainAxisAlignment.spaceBetween,
//                               children: [
//                                 pw.Table(
//                                     border: pw.TableBorder.symmetric(),
//                                     children: [
//                                       pw.TableRow(children: [
//                                         pw.Column(
//                                             crossAxisAlignment:
//                                                 pw.CrossAxisAlignment.start,
//                                             children: [
//                                               pw.SizedBox(height: 10),
//                                               pw.Text(targetCompany.name
//                                                   .toString()),
//                                               pw.Text(targetCompany.address
//                                                   .toString()),
//                                               pw.Text(targetCompany.city
//                                                   .toString()),
//                                               pw.Text(
//                                                   targetCompany.cif.toString()),
//                                               pw.Text(targetCompany.email
//                                                   .toString()),
//                                               pw.SizedBox(height: 10),
//                                             ]),
//                                       ]),
//                                     ]),
//                                 pw.Table(children: [
//                                   pw.TableRow(children: [
//                                     pw.Column(
//                                         crossAxisAlignment:
//                                             pw.CrossAxisAlignment.start,
//                                         children: [
//                                           pw.SizedBox(height: 10),
//                                           pw.Row(children: [
//                                             pw.Text('Order Nº: ',
//                                                 style: pw.TextStyle(
//                                                     fontWeight:
//                                                         pw.FontWeight.bold)),
//                                             pw.Text(num.toString())
//                                           ]),
//                                           pw.SizedBox(height: 10),
//                                           pw.Row(children: [
//                                             pw.Text('DATE: ',
//                                                 style: pw.TextStyle(
//                                                     fontWeight:
//                                                         pw.FontWeight.bold)),
//                                             pw.Text(fechaFormat)
//                                           ]),
//                                           pw.SizedBox(height: 10),
//                                           pw.Row(children: [
//                                             pw.Text("SHIPPING ADDRESS: ",
//                                                 style: pw.TextStyle(
//                                                     fontWeight:
//                                                         pw.FontWeight.bold)),
//                                             pw.Text(
//                                                 miEmpresa.address.toString())
//                                           ]),
//                                           pw.SizedBox(height: 10),
//                                         ]),
//                                   ]),
//                                 ]),
//                               ]),
//                           pw.SizedBox(height: 25),
//                           pw.Table(border: pw.TableBorder.all(), children: [
//                             pw.TableRow(children: [
//                               pw.Column(
//                                   crossAxisAlignment:
//                                       pw.CrossAxisAlignment.center,
//                                   mainAxisAlignment:
//                                       pw.MainAxisAlignment.center,
//                                   children: [
//                                     pw.Text("REF. COD",
//                                         style: pw.TextStyle(
//                                             fontWeight: pw.FontWeight.bold)),
//                                   ]),
//                               pw.Column(
//                                   crossAxisAlignment:
//                                       pw.CrossAxisAlignment.center,
//                                   mainAxisAlignment:
//                                       pw.MainAxisAlignment.center,
//                                   children: [
//                                     pw.Text("DESCRIPTION",
//                                         style: pw.TextStyle(
//                                             fontWeight: pw.FontWeight.bold)),
//                                   ]),
//                               pw.Column(
//                                   crossAxisAlignment:
//                                       pw.CrossAxisAlignment.center,
//                                   mainAxisAlignment:
//                                       pw.MainAxisAlignment.center,
//                                   children: [
//                                     pw.Text("QUANTITY",
//                                         style: pw.TextStyle(
//                                             fontWeight: pw.FontWeight.bold)),
//                                   ]),
//                               pw.Column(
//                                   crossAxisAlignment:
//                                       pw.CrossAxisAlignment.center,
//                                   mainAxisAlignment:
//                                       pw.MainAxisAlignment.center,
//                                   children: [
//                                     pw.Text("PRICE",
//                                         style: pw.TextStyle(
//                                             fontWeight: pw.FontWeight.bold)),
//                                   ]),
//                               pw.Column(
//                                   crossAxisAlignment:
//                                       pw.CrossAxisAlignment.center,
//                                   mainAxisAlignment:
//                                       pw.MainAxisAlignment.center,
//                                   children: [
//                                     pw.Text("TOTAL AMOUNT",
//                                         style: pw.TextStyle(
//                                             fontWeight: pw.FontWeight.bold)),
//                                   ]),
//                             ]),
//                             for (var producto in products)
//                               for (var entry in pedido.entries)
//                                 if (producto.articleId.toString() == entry.key)
//                                   pw.TableRow(children: [
//                                     pw.Column(
//                                         crossAxisAlignment:
//                                             pw.CrossAxisAlignment.center,
//                                         mainAxisAlignment:
//                                             pw.MainAxisAlignment.center,
//                                         children: [
//                                           pw.Text(
//                                               producto.articleId.toString()),
//                                         ]),
//                                     pw.Column(
//                                         crossAxisAlignment:
//                                             pw.CrossAxisAlignment.center,
//                                         mainAxisAlignment:
//                                             pw.MainAxisAlignment.center,
//                                         children: [
//                                           pw.Text(producto.compamyDescription
//                                               .toString()),
//                                         ]),
//                                     pw.Column(
//                                         crossAxisAlignment:
//                                             pw.CrossAxisAlignment.center,
//                                         mainAxisAlignment:
//                                             pw.MainAxisAlignment.center,
//                                         children: [
//                                           pw.Text(pedido[producto.articleId
//                                                   .toString()] ??
//                                               '-'),
//                                         ]),
//                                     pw.Column(
//                                         crossAxisAlignment:
//                                             pw.CrossAxisAlignment.center,
//                                         mainAxisAlignment:
//                                             pw.MainAxisAlignment.center,
//                                         children: [
//                                           pw.Text(producto.price.toString()),
//                                         ]),
//                                     pw.Column(
//                                         crossAxisAlignment:
//                                             pw.CrossAxisAlignment.center,
//                                         mainAxisAlignment:
//                                             pw.MainAxisAlignment.center,
//                                         children: [
//                                           pw.Text(getPrecio(
//                                                   int.parse(pedido[producto
//                                                           .articleId
//                                                           .toString()] ??
//                                                       "1"),
//                                                   double.parse(producto.price!))
//                                               .toStringAsFixed(2)),
//                                         ]),
//                                   ]),
//                           ]),
//                           pw.SizedBox(height: 30),
//                           pw.Row(children: [
//                             pw.Column(
//                                 crossAxisAlignment: pw.CrossAxisAlignment.start,
//                                 children: [
//                                   pw.Row(children: [
//                                     pw.Text(
//                                         "TOTAL: " +
//                                             precioTotal.toStringAsFixed(2),
//                                         style: pw.TextStyle(
//                                             fontWeight: pw.FontWeight.bold)),
//                                   ]),
//                                 ])
//                           ])
//                         ]);
//                       }));

//                   String? path = await FilesystemPicker.open(
//                     title: 'Save to folder',
//                     context: context,
//                     rootDirectory: Directory("/storage/emulated/0/"),
//                     fsType: FilesystemType.folder,
//                     pickText: 'Save file to this folder',
//                   );
//                   DateTime dateToday = new DateTime.now();
//                   String dateT = dateToday.toString().substring(0, 10);

//                   final file = File("${"$path/$dateT-$num"}.pdf");
//                   await file.writeAsBytes(await pdf.save());

//                   final Email email = Email(
//                     body: 'Order Receipt',
//                     subject: 'Order',
//                     recipients: ['raulreyes@cadiz.salesianos.edu'],
//                     attachmentPaths: [file.path],
//                     isHTML: false,
//                   );
//                   String emailResponse;

//                   try {
//                     print('trying');
//                     await FlutterEmailSender.send(email);
//                     emailResponse = 'success';
//                   } catch (error) {
//                     print('error');
//                     emailResponse = error.toString();
//                   }

//                   print('test ' + emailResponse);
//                   customToast('Order placed', context);
//                 }
//               },
//               child: Container(
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
//                 child: const Text(
//                   'Place Order',
//                   style: TextStyle(color: Colors.white),
//                 ),
//               ),
//             ),
//           ),
//       ],
//     );
//   }

//   void customToast(String message, BuildContext context) {
//     showToast(
//       message,
//       textStyle: const TextStyle(
//         fontSize: 14,
//         wordSpacing: 0.1,
//         color: Colors.white,
//         fontWeight: FontWeight.bold,
//       ),
//       textPadding: const EdgeInsets.all(23),
//       fullWidth: true,
//       toastHorizontalMargin: 25,
//       borderRadius: BorderRadius.circular(15),
//       backgroundColor: Colors.deepPurple,
//       alignment: Alignment.topCenter,
//       position: StyledToastPosition.bottom,
//       duration: const Duration(seconds: 3),
//       animation: StyledToastAnimation.slideFromBottom,
//       context: context,
//     );
//   }
// }

//   @override
//   void initState() {
//     print('INICIO DE INIT');
//     super.initState();
//     getListProducts();
//   }
  

  

