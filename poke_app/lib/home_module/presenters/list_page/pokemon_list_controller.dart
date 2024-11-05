import 'package:flutter/material.dart';
import 'package:poke_app/home_module/domain/entities/pokemon_list_item_entity.dart';
import 'package:poke_app/home_module/domain/usercases/get_favorites_usercase.dart';
import 'package:poke_app/home_module/domain/usercases/get_pokemons_usercase.dart';
import 'package:poke_app/home_module/domain/usercases/set_favorites_usercase.dart';
import 'package:poke_app/home_module/presenters/list_page/pokemon_list_state.dart';
import 'package:poke_app/shared_module/stores/favorites_store.dart';

class PokemonListController extends ChangeNotifier {
  PokemonListState listState = PokemonListLoadingState();
  final FavoritesStore favoritesStore;
  final IGetPokemonsUsecase getInitialPokemonsUsecase;
  final ISetFavoritesUsercase setFavoritesUsercase;
  final IGetFavoritesUsercase getFavoritesUsercase;

  PokemonListController({
    required this.favoritesStore,
    required this.getInitialPokemonsUsecase,
    required this.setFavoritesUsercase,
    required this.getFavoritesUsercase,
  }) {
    favoritesStore.addListener(_onGlobalStoreChanged);
  }

  void _onGlobalStoreChanged() {
    notifyListeners();
  }

  @override
  void dispose() {
    favoritesStore.removeListener(_onGlobalStoreChanged);
    super.dispose();
  }

  Future<void> fetchPokemons() async {
    final currentFavorites = await getFavoritesUsercase();
    favoritesStore.setFavorites(currentFavorites);
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

  Future<void> toggleFavorite(
      PokemonListItemEntity pokemonEntity, bool isCurrentlyFavorite) async {
    if (listState is PokemonListLoadedState) {
      final currentFavorites =
          await setFavoritesUsercase(pokemonEntity, isCurrentlyFavorite);

      listState = PokemonListLoadedState(
          (listState as PokemonListLoadedState).pokemons.map((pokemon) {
        if (pokemon.id == pokemonEntity.id) {
          return pokemon.copyWith(isFavorite: !isCurrentlyFavorite);
        }
        return pokemon;
      }).toList());
      favoritesStore.setFavorites(currentFavorites);
    }
  }
}
