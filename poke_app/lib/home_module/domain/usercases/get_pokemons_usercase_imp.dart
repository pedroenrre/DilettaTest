import 'package:poke_app/home_module/domain/entities/pokemon_list_item_entity.dart';
import 'package:poke_app/home_module/domain/repositories/pokemon_repository.dart';
import 'package:poke_app/home_module/domain/usercases/get_pokemons_usercase.dart';

class GetPokemonsUsecase implements IGetPokemonsUsecase {
  final IPokemonRepository repository;
  GetPokemonsUsecase({
    required this.repository,
  });
  @override
  Stream<PokemonListItemEntity> call(int initialCounter) {
    int maxCount = initialCounter + 8;
    return repository.getPokemons(initialCounter, maxCount);
  }
}
