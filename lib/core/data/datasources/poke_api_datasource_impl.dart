import 'package:poke_caches/commons/config/urls.dart';
import 'package:poke_caches/commons/http_client/poke_http_client.dart';
import 'package:poke_caches/core/data/datasources/pokemon_datasource.dart';
import 'package:poke_caches/core/data/models/pokemon_model.dart';

import '../../domain/entities/pokemon_urls_entity.dart';
import '../models/pokrmon_urls_model.dart';

class PokeApiDatasourceImpl implements PokemonDatasource {
  final PokeHttpClient _client;

  PokeApiDatasourceImpl(this._client);
  @override
  Future<PokemonUrlsEntity> getPokeUrl({int page = 0, int limit = 20, int size = 20}) async {
    final response = await _client.get('${Urls.pokeApiRoot}/pokemon',
        queryParameters: {"limit": "$limit", "offset": "${page * size}"});
    final Map<String, dynamic> data = (response.data as Map<String, dynamic>);
    return PokemonUrlsModel.fromJson(data);
  }

  @override
  Future<PokemonModel> getPokemon(String url) async {
    final response = await _client.get(url);
    final data = (response.data as Map<String, dynamic>);
    return PokemonModel.fromJson(data);
  }
}
