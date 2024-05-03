import 'package:poke_caches/core/domain/entities/pokemon_type_entity.dart';

class PokemonTypeModel extends PokemonTypeEntity {
  const PokemonTypeModel({required super.name});

  factory PokemonTypeModel.fromEntity(PokemonTypeEntity entity) {
    return PokemonTypeModel(name: entity.name);
  }

  factory PokemonTypeModel.fromJson(Map<String, dynamic> json) {
    return PokemonTypeModel(name: json['name']);
  }

  Map<String, dynamic> toJson() => {
        'name': name,
      };
}
