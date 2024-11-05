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
    List<String> favoriteIds = await localDataSource.getFavoritePokemons();

    await for (final PokemonModel pokemon
        in dataSource.getPokemonsDetails(initialCount, maxCount)) {
      final isFavorite = favoriteIds.contains(pokemon.id.toString());
      yield pokemon.toEntity(isFavorite: isFavorite);
    }
  }

  @override
  Future<List<String>> getFavorites() {
    return localDataSource.getFavoritePokemons();
  }

  @override
  Future<bool> setFavorites(List<String> favorites) {
    return localDataSource.saveFavoritePokemons(favorites);
  }
}
