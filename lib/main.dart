import 'package:custom_shop/features/auth/screen/login.dart';
import 'package:custom_shop/providers/user_provider.dart';
import 'package:custom_shop/router.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [ChangeNotifierProvider(create: (context) => UserProvider())],
    child: const MainApp(),
  ));
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'IndieFlower',
        ),
        onGenerateRoute: (settings) => generateRoute(settings),
        home: const Login());
  }
}
