import 'package:dartz/dartz.dart';

import '../entities/pokemon_entity.dart';
import '../exceptions/pokemon_exception.dart';

abstract class PokemonRepository{
  Future<Either<PokemonException, List<PokemonEntity>>> getAll({int page, int limit, int size});
}