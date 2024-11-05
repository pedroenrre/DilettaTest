import 'package:poke_app/home_module/domain/entities/pokemon_list_item_entity.dart';
import 'package:poke_app/home_module/domain/repositories/pokemon_repository.dart';
import 'package:poke_app/home_module/domain/usercases/get_favorites_usercase.dart';

class GetFavoritesUsercase implements IGetFavoritesUsercase {
  final IPokemonRepository repository;
  GetFavoritesUsercase({
    required this.repository,
  });
  @override
  Future<List<PokemonListItemEntity>> call() async {
    return repository.getFavorites();
  }
}
