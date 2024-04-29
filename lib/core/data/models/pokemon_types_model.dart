import 'package:poke_caches/core/domain/entities/pokemon_type_entity.dart';

class PokemonTypeModel extends PokemonTypeEntity {
  PokemonTypeModel({required super.name});

  factory PokemonTypeModel.fromJson(Map<String, dynamic> json) {
    return PokemonTypeModel(name: json['type']['name']);
  }

  Map<String, dynamic> toJson() => {
        'name': name,
      };
}
