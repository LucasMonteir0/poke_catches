import 'pokemon_type_entity.dart';

class PokemonEntity {
  final String name;
  final int id;
  final String pictureUrl;
  final List<PokemonTypeEntity> types;

  PokemonEntity({required this.name, required this.id, required this.pictureUrl, required this.types});

}