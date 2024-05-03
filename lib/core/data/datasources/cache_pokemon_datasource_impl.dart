import 'dart:convert';

import 'package:poke_caches/commons/cache_manager/cache_manager.dart';
import 'package:poke_caches/commons/cache_manager/cache_manager_impl.dart';
import 'package:poke_caches/core/data/datasources/pokemon_datasource.dart';
import 'package:poke_caches/core/data/models/pokrmon_urls_model.dart';
import 'package:poke_caches/core/domain/entities/pokemon_entity.dart';
import 'package:poke_caches/core/domain/entities/pokemon_urls_entity.dart';

import '../models/pokemon_model.dart';

class CachePokemonDatasourceImpl implements PokemonDatasource {
  final PokemonDatasource external;

  CachePokemonDatasourceImpl(this.external);

  @override
  Future<PokemonUrlsEntity> getPokeUrl({int page = 0, int limit = 20, int size = 20}) async {
    final String reference = '$page$limit$size';
    final Map<String, dynamic>? cache = CacheManagerImpl.instance.getMap(reference);
    if(cache != null) {
      return PokemonUrlsModel.fromJson(cache);
    } else {
      final urls = await  external.getPokeUrl(page: page, limit: limit, size: size);
      final model = PokemonUrlsModel.fromEntity(urls);

      await CacheManagerImpl.instance.setMap(reference, model.toJson());
      return urls;
    }

  }

  @override
  Future<PokemonEntity> getPokemon(String url) async {
    final Map<String, dynamic>? cache = CacheManagerImpl.instance.getMap(url);
    if(cache != null) {
      final pokemon = PokemonModel.fromJson(cache);
       return pokemon;
    } else {
    final pokemon = await external.getPokemon(url);
    final model = PokemonModel.fromEntity(pokemon);
    await CacheManagerImpl.instance.setMap(url, model.toJson());
    return pokemon;
    }
  }
}
