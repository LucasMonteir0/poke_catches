

import 'package:dartz/dartz.dart';

import '../entities/pokemon_entity.dart';
import '../exceptions/pokemon_exception.dart';
import '../repositories/pokemon_repository.dart';
import 'get_all_pokemons_use_case.dart';

class GetAllPokemonsUseCaseImpl implements GetAllPokemonsUseCase {

  final PokemonRepository _repository;

  GetAllPokemonsUseCaseImpl( this._repository);

  @override
  Future<Either<PokemonException, List<PokemonEntity>>> call() {
    return _repository.getAll();
  }
}
