import 'package:flutter/material.dart';
import 'package:poke_app/home_module/domain/usercases/get_pokemons_usercase.dart';
import 'package:poke_app/home_module/domain/usercases/set_favorites_usercase.dart';
import 'package:poke_app/home_module/presenters/list_page/pokemon_list_state.dart';

class PokemonListController extends ChangeNotifier {
  PokemonListState listState = PokemonListLoadingState();
  final IGetPokemonsUsecase getInitialPokemonsUsecase;
  final ISetFavoritesUsercase setFavoritesUsercase;

  PokemonListController({
    required this.getInitialPokemonsUsecase,
    required this.setFavoritesUsercase,
  });

  Future<void> fetchPokemons() async {
    int initialCount;
    if (listState is PokemonListLoadedState) {
      final currentState = listState as PokemonListLoadedState;
      initialCount = currentState.offset;
      listState = PokemonListLoadedState(currentState.pokemons, loading: true);
      notifyListeners();
    } else {
      initialCount = 1;
    }
    final stream = getInitialPokemonsUsecase(initialCount);

    stream.listen(
      (pokemon) {
        if (listState is PokemonListLoadedState) {
          final currentState = listState as PokemonListLoadedState;
          listState = PokemonListLoadedState(
            [...currentState.pokemons, pokemon],
            loading: true,
          );
        } else {
          listState = PokemonListLoadedState(
            [pokemon],
            loading: true,
          );
        }
        notifyListeners();
      },
      onError: (error) {
        if (listState is! PokemonListLoadedState) {
          listState = PokemonListErrorState(
            'Erro ao carregar os pokémons.',
          );
        }
        notifyListeners();
      },
      onDone: () {
        final currentState = listState as PokemonListLoadedState;
        listState =
            PokemonListLoadedState(currentState.pokemons, loading: false);
        notifyListeners();
      },
    );
  }

  Future<void> toggleFavorite(num pokemonId, bool isCurrentlyFavorite) async {
    if (listState is PokemonListLoadedState) {
      await setFavoritesUsercase(pokemonId, isCurrentlyFavorite);

      listState = PokemonListLoadedState(
          (listState as PokemonListLoadedState).pokemons.map((pokemon) {
        if (pokemon.id == pokemonId) {
          return pokemon.copyWith(isFavorite: !isCurrentlyFavorite);
        }
        return pokemon;
      }).toList());
      notifyListeners();
    }
  }

  void dispose() {
    // listState.dispose();
  }
}
