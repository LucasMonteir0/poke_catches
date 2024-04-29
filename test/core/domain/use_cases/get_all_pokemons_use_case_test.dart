import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:poke_caches/core/domain/entities/pokemon_entity.dart';
import 'package:poke_caches/core/domain/repositories/pokemon_repository.dart';
import 'package:poke_caches/core/domain/use_cases/get_all_pokemons_use_case_impl.dart';

class PokemonRepositoryMock extends Mock implements PokemonRepository {}

main() {
  final repository = PokemonRepositoryMock();
  final useCase = GetAllPokemonsUseCaseImpl(repository);

  test('deve retornar uma lista de PokemonEntity', () async {
    when(repository.getAll)
        .thenAnswer((_) async => const Right(<PokemonEntity>[]));

    final result = await useCase();
    expect(result, isA<Right>());
  });

}
