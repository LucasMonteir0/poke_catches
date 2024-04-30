import 'package:equatable/equatable.dart';

class PokemonUrlsEntity extends Equatable {
  final List<String> urls;

  const PokemonUrlsEntity(this.urls);

  @override
  List<Object?> get props => [urls];
}