import '../../domain/entities/pokemon_urls_entity.dart';

class PokemonUrlsModel extends PokemonUrlsEntity {
  const PokemonUrlsModel(super.urls);

  factory PokemonUrlsModel.fromEntity(PokemonUrlsEntity entity) {
    return PokemonUrlsModel(entity.urls);
  }

  factory PokemonUrlsModel.fromJson(Map<String, dynamic> json) {
    final urls = json["results"]
        .map<String>((e) => (e["url"] as String))
        .toList();

    return PokemonUrlsModel(urls);
  }

  Map<String, dynamic> toJson() {
    return {
      'results': urls.map((url) => {'url': url}).toList(),
    };
  }
}