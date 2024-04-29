import 'package:dartz/dartz.dart';
import 'package:poke_caches/core/data/datasources/pokemon_datasource.dart';
import 'package:poke_caches/core/domain/entities/pokemon_entity.dart';
import 'package:poke_caches/core/domain/exceptions/pokemon_exception.dart';
import 'package:poke_caches/core/domain/repositories/pokemon_repository.dart';

class PokemonRepositoryImpl implements PokemonRepository{

  final PokemonDatasource datasource;

  PokemonRepositoryImpl(this.datasource);

  @override
  Future<Either<PokemonException, List<PokemonEntity>>> getAll() {
    // TODO: implement getAll
    throw UnimplementedError();
  }

}