import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:poke_caches/core/data/datasources/pokemon_datasource.dart';
import 'package:poke_caches/core/data/models/pokemon_model.dart';
import 'package:poke_caches/core/data/models/pokrmon_urls_model.dart';
import 'package:poke_caches/core/data/repositories/pokemon_repository_impl.dart';
import 'package:poke_caches/core/domain/entities/pokemon_entity.dart';
import 'package:poke_caches/core/domain/entities/pokemon_urls_entity.dart';
import 'package:poke_caches/core/domain/exceptions/pokemon_exception.dart';
import 'package:poke_caches/core/domain/repositories/pokemon_repository.dart';

import '../data_mock.dart';

class PokemonDatasourceMock extends Mock implements PokemonDatasource {}

main() {

  late PokemonDatasource datasource;
  late PokemonRepository repository;
  late PokemonEntity entity;
  late PokemonUrlsEntity urls;

  setUpAll(() {
     datasource = PokemonDatasourceMock();
     repository = PokemonRepositoryImpl(datasource);
     entity = PokemonModel.fromJson(pokeDataMock);
     urls = PokemonUrlsModel.fromJson(urlsDataMock);
  });
  

  group('[DATA] - PokemonRepository', () {
    test('deve retornar uma lista de PokemonEntity', () async {

      when(() => datasource.getPokeUrl()).thenAnswer((_) async => urls);
      when(() => datasource.getPokemon(any())).thenAnswer((_) async => entity);

      final result = await repository.getAll();

      expect(result, isA<Right>());
    });

    test('deve retornar um erro se o datasource falhar', () async {
      when(() => datasource.getPokeUrl()).thenThrow(Exception());
      when(() => datasource.getPokemon(any())).thenThrow(Exception());

      final result = await repository.getAll();

      expect(result.fold(id, id), isA<GetAllPokemonsException>());
    });
  });

}
