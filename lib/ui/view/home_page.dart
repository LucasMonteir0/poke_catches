import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:poke_caches/commons/cache_manager/cache_manager_impl.dart';
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
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.add),
            onPressed: () => CacheManagerImpl.instance.clear(),
          ),
        ),
        body: SizedBox(
          height: size.height,
          width: size.width,
          child: GridView.builder(
              controller: _scrollController,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              itemCount: _pokemons.length,
              itemBuilder: (context, index) {
                final pokemon = _pokemons[index];
                return Card(
                  child: Column(
                    children: [
                      Expanded(
                        child: CachedNetworkImage(
                          imageUrl: pokemon.pictureUrl,
                          placeholder: (context, url) => SizedBox.square( dimension: 20, child: CircularProgressIndicator()),
                          errorWidget: (context, url, error) => Icon(Icons.error),
                        ),
                      ),
                      ListTile(
                        title: Text(
                          "${pokemon.id.toString().padLeft(3, '0')} ${pokemon.name}",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                );
              }, ),
        ),
      ),
    );
  }
}
