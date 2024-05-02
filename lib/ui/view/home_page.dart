import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:poke_caches/core/domain/entities/pokemon_entity.dart';
import 'package:poke_caches/core/domain/use_cases/get_all_pokemons_use_case.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  static const String route = '/';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final GetAllPokemonsUseCase _useCase;
  late final ScrollController _scrollController;

  final List<PokemonEntity> _pokemons = [];

  int _page = 0;
  int _limit = 20;
  final int _size = 20;
  final int _maxLimit = 151;

  result() async {
    final result = await _useCase(page: _page, limit: _limit, size: _size);
    result.fold((l) {}, (r) {
      _pokemons.addAll(r);
      setState(() {});

    });
  }

  @override
  void initState() {
    super.initState();
    _useCase = Modular.get<GetAllPokemonsUseCase>();
    _scrollController = ScrollController();
    result();

    _scrollController.addListener(() async {
      if (_scrollController.position.maxScrollExtent ==
          _scrollController.offset) {
        if (_pokemons.length < _maxLimit) {
          _page += 1;
          if (_page == (_maxLimit ~/ _size)) _limit = _maxLimit - (_page * _size);
          await result();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Material(
      child: SizedBox(
        height: size.height,
        width: size.width,
        child: ListView.builder(
            controller: _scrollController,
            itemCount: _pokemons.length,
            itemBuilder: (context, index) {
              final pokemon = _pokemons[index];
              return ListTile(
                title: Text(
                  "${pokemon.id.toString().padLeft(3, '0')} ${pokemon.name}",
                  style: TextStyle(color: Colors.black),
                ),
              );
            }),
      ),
    );
  }
}
