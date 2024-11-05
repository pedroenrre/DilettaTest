import 'dart:convert';

import 'package:poke_app/home_module/data/datasources/local/local_datasource.dart';
import 'package:poke_app/home_module/data/datasources/remote/remote_datasource.dart';
import 'package:poke_app/home_module/data/models/pokemon_model.dart';
import 'package:poke_app/home_module/domain/entities/pokemon_list_item_entity.dart';
import 'package:poke_app/home_module/domain/repositories/pokemon_repository.dart';

class PokemonRespository implements IPokemonRepository {
  final IRemoteDataSource dataSource;
  final ILocalDataSource localDataSource;
  PokemonRespository({
    required this.dataSource,
    required this.localDataSource,
  });
  @override
  Stream<PokemonListItemEntity> getPokemons(
      int initialCount, int maxCount) async* {
    await for (final PokemonModel pokemon
        in dataSource.getPokemonsDetails(initialCount, maxCount)) {
      yield pokemon.toEntity();
    }
  }

  @override
  Future<List<PokemonListItemEntity>> getFavorites() async {
    List<String> favoritesStringList =
        await localDataSource.getFavoritePokemons();
    List<PokemonListItemEntity> favoritePokemons = favoritesStringList
        .map(
          (item) =>
              PokemonModel.fromJson(jsonDecode(item) as Map<String, dynamic>)
                  .toEntity(),
        )
        .toList();
    return favoritePokemons;
  }

  @override
  Future<bool> setFavorites(List<PokemonListItemEntity> favorites) {
    final List<PokemonModel> pokemonModelList =
        favorites.map((item) => PokemonModel.fromEntity(item)).toList();
    return localDataSource.saveFavoritePokemons(pokemonModelList);
  }
}
