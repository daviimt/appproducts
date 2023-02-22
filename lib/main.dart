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
          // 'register': (_) => RegisterScreen(),
        });
  }
}
