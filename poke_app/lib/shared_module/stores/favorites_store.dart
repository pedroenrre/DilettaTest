import 'package:flutter/material.dart';
import 'package:poke_app/home_module/domain/entities/pokemon_list_item_entity.dart';

class FavoritesStore extends ChangeNotifier {
  List<PokemonListItemEntity> _favorites = [];

  List<PokemonListItemEntity> get favorites => _favorites;

  setFavorites(List<PokemonListItemEntity> newList) {
    _favorites = [...newList];
    notifyListeners();
  }

  isFavorite(PokemonListItemEntity pokemon) {
    return _favorites.any((favorite) => favorite.id == pokemon.id);
  }
}
