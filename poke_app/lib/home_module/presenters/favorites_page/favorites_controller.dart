// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:poke_app/home_module/domain/entities/pokemon_list_item_entity.dart';

import 'package:poke_app/home_module/domain/usercases/get_favorites_usercase.dart';
import 'package:poke_app/home_module/domain/usercases/set_favorites_usercase.dart';
import 'package:poke_app/shared_module/stores/favorites_store.dart';

class FavoritesController extends ChangeNotifier {
  final FavoritesStore favoritesStore;
  final ISetFavoritesUsercase setFavoritesUsercase;
  final IGetFavoritesUsercase getFavoritesUsercase;
  FavoritesController({
    required this.favoritesStore,
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

  Future<void> toggleFavorite(
      PokemonListItemEntity pokemonEntity, bool isCurrentlyFavorite) async {
    final currentFavorites =
        await setFavoritesUsercase(pokemonEntity, isCurrentlyFavorite);

    favoritesStore.setFavorites(currentFavorites);
  }
}
