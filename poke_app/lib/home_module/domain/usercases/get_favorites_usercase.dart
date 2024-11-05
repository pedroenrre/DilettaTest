import 'package:poke_app/home_module/domain/entities/pokemon_list_item_entity.dart';

abstract class IGetFavoritesUsercase {
  Future<List<PokemonListItemEntity>> call();
}
