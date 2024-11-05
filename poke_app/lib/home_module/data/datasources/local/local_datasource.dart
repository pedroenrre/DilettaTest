import 'package:poke_app/home_module/data/models/pokemon_model.dart';

abstract class ILocalDataSource {
  Future<List<String>> getFavoritePokemons();
  Future<bool> saveFavoritePokemons(List<PokemonModel> favorites);
}
