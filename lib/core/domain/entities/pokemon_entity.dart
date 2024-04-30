import 'package:equatable/equatable.dart';

import 'pokemon_type_entity.dart';

class PokemonEntity extends Equatable{
  final String name;
  final int id;
  final String pictureUrl;
  final List<PokemonTypeEntity> types;

  const PokemonEntity({required this.name, required this.id, required this.pictureUrl, required this.types});

  @override
  List<Object?> get props => [name, id, pictureUrl, types];

}