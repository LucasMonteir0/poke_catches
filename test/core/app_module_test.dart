import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:poke_caches/app_module.dart';
import 'package:poke_caches/commons/http_client/dio_client_impl.dart';
import 'package:poke_caches/commons/http_client/poke_http_client.dart';
import 'package:poke_caches/core/data/datasources/poke_api_datasource_impl.dart';
import 'package:poke_caches/core/data/datasources/pokemon_datasource.dart';
import 'package:poke_caches/core/domain/entities/pokemon_entity.dart';
import 'package:poke_caches/core/domain/use_cases/get_all_pokemons_use_case.dart';
import 'package:poke_caches/core/domain/use_cases/get_all_pokemons_use_case_impl.dart';

import 'data/data_mock.dart';

class DioMock extends Mock implements Dio{}
class ClientMock extends Mock implements PokeHttpClient {}

main() {
  final PokeHttpClient client = ClientMock();
  late int page, limit, size;
  late final Map<String, dynamic> queryParams;
  Modular.bindModule(AppModule());
  Modular.replaceInstance<PokeHttpClient>(client);

  setUpAll(() {
    page = 0;
    limit = 2;
    size = 2;
    queryParams = {"limit": "$limit", "offset": "${page * size}"};
  });

  test('Deve recuperar o useCase sem erro', () {
    final userCase = Modular.get<GetAllPokemonsUseCase>();
    expect(userCase, isA<GetAllPokemonsUseCaseImpl>());
  });

  test('Deve trazer uma lista de Pokemon Entity', () async {
    when(() => client.get(any())).thenAnswer((_) async =>
        Response(data: pokeDataMock, requestOptions: RequestOptions()));

    when(() => client.get(any(), queryParameters: queryParams)).thenAnswer(
      (_) async => Response(
        data: {
          "results": [
            {"url": ""},
          ]
        },
        requestOptions: RequestOptions(path: ""),
      ),
    );

    final useCase = Modular.get<GetAllPokemonsUseCase>();
    final result = await useCase(page: page, limit: limit, size: size);
    expect(result, isA<Right>());
  });
}
