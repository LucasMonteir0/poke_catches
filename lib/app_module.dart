import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:poke_caches/commons/http_client/dio_client_impl.dart';
import 'package:poke_caches/commons/http_client/poke_http_client.dart';
import 'package:poke_caches/core/data/datasources/cache_pokemon_datasource_impl.dart';
import 'package:poke_caches/core/data/datasources/poke_api_datasource_impl.dart';
import 'package:poke_caches/core/data/datasources/pokemon_datasource.dart';
import 'package:poke_caches/core/data/repositories/pokemon_repository_impl.dart';
import 'package:poke_caches/core/domain/repositories/pokemon_repository.dart';
import 'package:poke_caches/core/domain/use_cases/get_all_pokemons_use_case.dart';
import 'package:poke_caches/core/domain/use_cases/get_all_pokemons_use_case_impl.dart';
import 'package:poke_caches/ui/view/home_page.dart';

class AppModule implements Module {
  @override
  void binds(Injector i) {
    i.addLazySingleton<PokeHttpClient>(() => DioClientImpl(Dio()));
    // i.add<PokemonDatasource>(PokeApiDatasourceImpl.new);
    i.addLazySingleton<PokemonDatasource>(
        () => CachePokemonDatasourceImpl(PokeApiDatasourceImpl(i.get<PokeHttpClient>())));
    i.add<PokemonRepository>(PokemonRepositoryImpl.new);
    i.add<GetAllPokemonsUseCase>(GetAllPokemonsUseCaseImpl.new);
  }

  @override
  void exportedBinds(Injector i) {
  }

  @override
  List<Module> get imports => [];

  @override
  void routes(RouteManager r) {
    r.child(HomePage.route, child: (context) => const HomePage());
  }
}
