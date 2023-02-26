import 'package:appproducts/screens/favs_screen.dart';
import 'package:appproducts/services/user_service.dart';
import 'package:flutter/material.dart';
import 'screens/screens.dart';
import 'package:provider/provider.dart';
import 'services/services.dart';

void main() => runApp(AppState());

class AppState extends StatelessWidget {
  const AppState({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AuthService(),
        ),
        ChangeNotifierProvider(
          create: (_) => UserService(),
        ),
        ChangeNotifierProvider(
          create: (_) => CategoryService(),
        ),
        ChangeNotifierProvider(
          create: (_) => ProductService(),
        ),
      ],
      child: MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'AppProducts',
        initialRoute: 'login',
        routes: {
          'login': (_) => LoginScreen(),
          'register': (_) => RegisterScreen(),
          'userscreen': (_) => UserScreen(),
          'admincategoryscreen': (_) => CategoryScreen(),
          'adminproductsscreen': (_) => ProductScreen(),
          'favs_screen': (_) => FavsScreen(),
        });
  }
}
