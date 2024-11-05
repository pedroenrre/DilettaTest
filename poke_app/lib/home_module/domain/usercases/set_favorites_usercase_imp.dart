import 'package:poke_app/home_module/domain/entities/pokemon_list_item_entity.dart';
import 'package:poke_app/home_module/domain/repositories/pokemon_repository.dart';
import 'package:poke_app/home_module/domain/usercases/set_favorites_usercase.dart';

class SetFavoritesUsercase implements ISetFavoritesUsercase {
  final IPokemonRepository repository;
  SetFavoritesUsercase({
    required this.repository,
  });
  @override
  Future<List<PokemonListItemEntity>> call(
      PokemonListItemEntity pokemonEntity, bool isCurrentlyFavorite) async {
    final newFavoriteState = !isCurrentlyFavorite;

    List<PokemonListItemEntity> currentFavorites =
        await repository.getFavorites();

    if (newFavoriteState) {
      currentFavorites.add(pokemonEntity);
    } else {
      currentFavorites
          .removeWhere((favorite) => favorite.id == pokemonEntity.id);
    }
    currentFavorites.sort((a, b) => a.id.compareTo(b.id));
    await repository.setFavorites(currentFavorites);

    return currentFavorites;
  }
}
