import 'dart:convert';

import 'package:poke_app/home_module/data/datasources/local/local_datasource.dart';
import 'package:poke_app/home_module/data/models/pokemon_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalDatasource implements ILocalDataSource {
  static const String key = 'favorites';
  @override
  Future<List<String>> getFavoritePokemons() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(key) ?? [];
  }

  @override
  Future<bool> saveFavoritePokemons(List<PokemonModel> favorites) async {
    final List<String> favoritesStringList =
        favorites.map((item) => jsonEncode(item.toMap())).toList();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setStringList(key, favoritesStringList);
  }
}
