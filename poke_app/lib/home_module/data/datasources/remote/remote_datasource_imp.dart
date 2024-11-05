import 'dart:convert';

import 'package:poke_app/shared_module/http_client/http_client_adapter.dart';
import 'package:poke_app/shared_module/http_client/http_response.dart';
import 'package:poke_app/home_module/data/datasources/remote/remote_datasource.dart';
import 'package:poke_app/home_module/data/models/pokemon_model.dart';

class RemoteDataSource extends IRemoteDataSource {
  final IHttpClientAdapter httpCLient;

  RemoteDataSource({
    required this.httpCLient,
  });

  @override
  Future<List<PokemonModel>> getPokemons() async {
    final queryParameters = {
      'limit': '20',
    };
    final HttpResponse response = await httpCLient.get(
      '/pokemon',
      queryParameters: queryParameters,
    );
    if (response.statusCode == 200) {
      final data = json.decode(response.data) as Map<String, dynamic>;
      final results = data['results'] as List;
      return results.map((json) => PokemonModel.fromJson(json)).toList();
    } else {
      throw Exception('Erro ao buscar pokemons');
    }
  }

  @override
  Stream<PokemonModel> getPokemonsDetails(
      int initialCount, int maxCount) async* {
    for (int i = initialCount; i <= maxCount; i++) {
      final response = await httpCLient.get('/pokemon/$i');
      if (response.statusCode == 200) {
        final data = json.decode(response.data) as Map<String, dynamic>;
        yield PokemonModel.fromJson(data);
      } else {
        throw Exception('Erro ao buscar dados do Pokémon de ID $i');
      }
    }
  }
}
