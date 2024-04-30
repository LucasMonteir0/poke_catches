import 'dart:convert';

import 'package:poke_caches/core/data/models/pokemon_types_model.dart';
import 'package:poke_caches/core/domain/entities/pokemon_entity.dart';

class PokemonModel extends PokemonEntity {
  const PokemonModel(
      {required super.name,
      required super.id,
      required super.pictureUrl,
      required super.types});

  factory PokemonModel.fromJson(Map<String, dynamic> json) {
    final List<PokemonTypeModel> types = json['types']
        .map((e) => PokemonTypeModel.fromJson(e['type']))
        .toList()
        .cast<PokemonTypeModel>();

    return PokemonModel(
        name: json['name'],
        pictureUrl: json['sprites']['other']['official-artwork']['front_default'],
        types: types,
        id: json['id']);
  }

  Map<String, dynamic> toJson() => {
    'name': name,
    'pictureUrl': pictureUrl,
    'types': types,
    'id': id,
  };

  @override
  String toString() => jsonEncode(toJson());
}
