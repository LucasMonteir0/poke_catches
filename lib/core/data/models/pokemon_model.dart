import 'dart:convert';

import 'package:poke_caches/core/data/models/pokemon_types_model.dart';
import 'package:poke_caches/core/data/models/pokrmon_urls_model.dart';
import 'package:poke_caches/core/domain/entities/pokemon_entity.dart';

class PokemonModel extends PokemonEntity {
  const PokemonModel(
      {required super.name,
      required super.id,
      required super.pictureUrl,
      required super.types});

  factory PokemonModel.fromEntity(PokemonEntity entity) {
    final types =
        entity.types.map((e) => PokemonTypeModel.fromEntity(e)).toList();
    return PokemonModel(
        name: entity.name,
        id: entity.id,
        pictureUrl: entity.pictureUrl,
        types: types);
  }

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

  Map<String, dynamic> toJson() {
    final formattedPictureUrl = {
        "other": {
          "official-artwork": {
            "front_default": pictureUrl,
          }
        }
    };
    final formattedTypes = types
        .map((e) => {
              "type": {"name": e.name}
            })
        .toList();

    return {
      'name': name,
      'sprites': formattedPictureUrl,
      'types': formattedTypes,
      'id': id,
    };
  }

  @override
  String toString() => jsonEncode(toJson());
}
