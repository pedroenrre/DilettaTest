import 'package:flutter/material.dart';
import 'package:poke_app/home_module/domain/usercases/get_pokemons_usercase.dart';
import 'package:poke_app/home_module/domain/usercases/set_favorites_usercase.dart';
import 'package:poke_app/home_module/presenters/list_page/pokemon_list_state.dart';

class PokemonListController {
  final ValueNotifier<PokemonListState> listState =
      ValueNotifier(PokemonListLoadingState());
  final IGetPokemonsUsecase getInitialPokemonsUsecase;
  final ISetFavoritesUsercase setFavoritesUsercase;

  PokemonListController({
    required this.getInitialPokemonsUsecase,
    required this.setFavoritesUsercase,
  });

  Future<void> fetchPokemons() async {
    int initialCount;
    if (listState.value is PokemonListLoadedState) {
      final currentState = listState.value as PokemonListLoadedState;
      initialCount = currentState.offset;
      listState.value = PokemonListPartialState(currentState.pokemons);
    } else {
      initialCount = 1;
    }
    final stream = getInitialPokemonsUsecase(initialCount);

    stream.listen(
      (pokemon) {
        if (listState.value is PokemonListPartialState) {
          final currentState = listState.value as PokemonListPartialState;
          listState.value = PokemonListPartialState(
            [...currentState.pokemons, pokemon],
          );
        } else {
          listState.value = PokemonListPartialState(
            [pokemon],
          );
        }
      },
      onError: (error) {
        if (listState.value is! PokemonListPartialState ||
            listState.value is! PokemonListLoadedState) {
          listState.value = PokemonListErrorState(
            'Erro ao carregar os pokémons.',
          );
        }
      },
      onDone: () {
        final currentState = listState.value as PokemonListPartialState;
        listState.value = PokemonListLoadedState(currentState.pokemons);
      },
    );
  }

  Future<void> toggleFavorite(num pokemonId, bool isCurrentlyFavorite) async {
    if (listState.value is PokemonListLoadedState) {
      await setFavoritesUsercase(pokemonId, isCurrentlyFavorite);

      listState.value = PokemonListLoadedState(
          (listState.value as PokemonListLoadedState).pokemons.map((pokemon) {
        if (pokemon.id == pokemonId) {
          return pokemon.copyWith(isFavorite: !isCurrentlyFavorite);
        }
        return pokemon;
      }).toList());
    }
  }

  void dispose() {
    listState.dispose();
  }
}