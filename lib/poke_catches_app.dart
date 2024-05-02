import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:poke_caches/ui/view/home_page.dart';

class PokeCatchesApp extends StatelessWidget {
  const PokeCatchesApp({super.key});

  @override
  Widget build(BuildContext context) {
    Modular.setInitialRoute(HomePage.route);

    return MaterialApp.router(
      title: 'Poke Catches App',
      theme: ThemeData(primarySwatch: Colors.red),
      routerConfig: Modular.routerConfig,
    );
  }
}
