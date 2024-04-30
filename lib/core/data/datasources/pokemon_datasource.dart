import 'package:poke_caches/core/domain/entities/pokemon_urls_entity.dart';

import '../../domain/entities/pokemon_entity.dart';

abstract class PokemonDatasource{
  Future<PokemonUrlsEntity> getPokeUrl();

  Future<PokemonEntity> getPokemon(String url);
}