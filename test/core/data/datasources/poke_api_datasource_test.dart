
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:poke_caches/commons/http_client/poke_http_client.dart';
import 'package:poke_caches/core/data/datasources/poke_api_datasource_impl.dart';
import 'package:poke_caches/core/data/datasources/pokemon_datasource.dart';
import 'package:poke_caches/core/domain/entities/pokemon_entity.dart';
import 'package:poke_caches/core/domain/entities/pokemon_urls_entity.dart';

import '../data_mock.dart';

class ClientMock extends Mock implements PokeHttpClient {}

main() {
  late PokeHttpClient client;
  late PokemonDatasource datasource;
  const Map<String, dynamic> queryParams = {"limit": "20", "offset": "20"};
  const String urlMock = 'https://wwww.url-mock.com';

  setUpAll(() {
    client = ClientMock();
    datasource = PokeApiDatasourceImpl(client);
  });

  group('[DATA] - POKE API DATASOURCE', () {
    test(' Get Pokemon Urls - PokemonUrlsEntity', () async {
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

      final result = await datasource.getPokeUrl();

      expect(result, isA<PokemonUrlsEntity>());
    });

    test('Get Pokemon Urls - EXCEPTION', () async {
      when(() => client.get(any(), queryParameters: queryParams))
          .thenThrow(Exception());

      try {
        await datasource.getPokeUrl();
      } catch (e) {
        expect(e, isA<Exception>());
      }
    });

    test('Get Pokemon - PokemonEntity', () async {
      when(() => client.get(urlMock)).thenAnswer((_) async => Response(
            data: pokeDataMock,
            requestOptions: RequestOptions(path: ""),
          ));

      final result = await datasource.getPokemon(urlMock);

      expect(result, isA<PokemonEntity>());
    });

    test('Get Pokemon - EXCEPTION', () async {
      when(() => client.get(urlMock)).thenThrow(Exception());

      try {
        await datasource.getPokemon(urlMock);
      } catch (e) {
        expect(e, isA<Exception>());
      }
    });
  });
}
