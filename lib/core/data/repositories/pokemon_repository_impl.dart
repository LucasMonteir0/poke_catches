import 'package:dartz/dartz.dart';
import 'package:poke_caches/core/data/datasources/pokemon_datasource.dart';
import 'package:poke_caches/core/domain/entities/pokemon_entity.dart';
import 'package:poke_caches/core/domain/exceptions/pokemon_exception.dart';
import 'package:poke_caches/core/domain/repositories/pokemon_repository.dart';

class PokemonRepositoryImpl implements PokemonRepository{
  final PokemonDatasource _datasource;

  PokemonRepositoryImpl(this._datasource);

  @override
  Future<Either<PokemonException, List<PokemonEntity>>> getAll({int page = 0, int limit = 20, size = 20}) async {
    try {
      final List<PokemonEntity> pokemons = [];
      final urls = await _datasource.getPokeUrl(page: page, limit: limit);
      for (String url in urls.urls) {
        final pokemon = await _datasource.getPokemon(url);
        pokemons.add(pokemon);
      }
      return Right(pokemons);
    } on GetAllPokemonsException catch (e) {
      return Left(e);
    } catch (e) {
      return Left(GetAllPokemonsException());
    }
  }

}