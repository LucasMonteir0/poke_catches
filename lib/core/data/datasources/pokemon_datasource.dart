import '../models/pokemon_model.dart';

abstract class PokemonDatasource{
  Future<List<PokemonModel>> getAllPokemons();
}