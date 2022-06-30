import 'package:first_app/screens/cart.dart';
import 'package:first_app/screens/details.dart';
import 'package:first_app/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

import './widgets/themes.dart';

import 'core/store.dart';
import 'screens/initial_screen.dart';
import 'screens/home_screen.dart';
import 'package:url_strategy/url_strategy.dart';

void main() {
  setPathUrlStrategy();
  runApp(VxState(store: MyStore(), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'First App',
      debugShowCheckedModeBanner: false,
      theme: MyTheme.lightTheme(context),
      darkTheme: ThemeData(),
      themeMode: ThemeMode.light,
      routeInformationParser: VxInformationParser(),
      routerDelegate: VxNavigator(routes: {
        "/": (_, __) => const MaterialPage(child: Initial()),
        "/login": (_, __) => const MaterialPage(child: Login()),
        "/home": (_, __) => const MaterialPage(child: Home()),
        "/details": (uri, _) {
          final catalogId = int.parse(uri.queryParameters["id"].toString());
          final catalog =
              (VxState.store as MyStore).cart.catalog.getById(catalogId);
          return MaterialPage(
            child: Details(item: catalog),
          );
        },
        "/cart": (_, __) => const MaterialPage(child: Cart()),
      }),
      // initialRoute: "/home",
      // routes: {
      //   "/": (context) => const Initial(),
      //   "/login": (context) => const Login(),
      //   "/home": (context) => const Home(),
      //   "/cart": (context) => const Cart(),
      // },
    );
  }
}
