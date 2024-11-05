import 'package:poke_app/home_module/data/datasources/local/local_datasource.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalDatasource implements ILocalDataSource {
  static const String key = 'favorites';
  @override
  Future<List<String>> getFavoritePokemons() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final favoriteIds = prefs.getStringList(key) ?? [];
    return favoriteIds;
  }

  @override
  Future<bool> saveFavoritePokemons(List<String> favorites) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setStringList(key, favorites);
  }
}
