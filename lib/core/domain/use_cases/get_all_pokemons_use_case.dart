import 'package:dartz/dartz.dart';
import 'package:poke_caches/core/domain/exceptions/pokemon_exception.dart';

import '../entities/pokemon_entity.dart';

abstract class GetAllPokemonsUseCase {
  Future<Either<PokemonException, List<PokemonEntity>>> call();
}
