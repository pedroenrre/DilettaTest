import 'package:poke_app/home_module/domain/repositories/pokemon_repository.dart';
import 'package:poke_app/home_module/domain/usercases/set_favorites_usercase.dart';

class SetFavoritesUsercase implements ISetFavoritesUsercase {
  final IPokemonRepository repository;
  SetFavoritesUsercase({
    required this.repository,
  });
  @override
  Future<bool> call(num pokemonId, bool isCurrentlyFavorite) async {
    final newFavoriteState = !isCurrentlyFavorite;

    final currentFavorites = await repository.getFavorites();

    if (newFavoriteState) {
      currentFavorites.add(pokemonId.toString());
    } else {
      currentFavorites.remove(pokemonId.toString());
    }

    return repository.setFavorites(currentFavorites);
  }
}
