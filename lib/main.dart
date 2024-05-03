import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:poke_caches/app_module.dart';
import 'package:poke_caches/commons/cache_manager/cache_manager_impl.dart';
import 'package:poke_caches/poke_catches_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheManagerImpl.instance.init();
  runApp(ModularApp(module: AppModule(), child: const PokeCatchesApp()));
}
