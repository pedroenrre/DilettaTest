import 'package:poke_app/home_module/domain/entities/pokemon_list_item_entity.dart';

abstract class IPokemonRepository {
  Stream<PokemonListItemEntity> getPokemons(int initialCount, int maxCount);
  Future<bool> setFavorites(List<String> favorites);
  Future<List<String>> getFavorites();
}
