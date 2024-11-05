import 'package:poke_app/home_module/domain/entities/pokemon_list_item_entity.dart';

abstract class PokemonListState {}

class PokemonListLoadingState extends PokemonListState {
  final int index = 1;
}

class PokemonListLoadedState extends PokemonListState {
  final List<PokemonListItemEntity> pokemons;
  final int offset;
  final bool loading;

  PokemonListLoadedState(this.pokemons, {this.loading = false})
      : offset = pokemons.length + 1;
}

class PokemonListErrorState extends PokemonListState {
  final String message;

  PokemonListErrorState(this.message);
}
