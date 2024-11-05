import 'package:poke_app/home_module/data/datasources/local/local_datasource.dart';
import 'package:poke_app/home_module/data/models/pokemon_model.dart';

class LocalDatasourceSqfliteImp implements ILocalDataSource {
  @override
  Future<List<String>> getFavoritePokemons() {
    // TODO: implement getFavoritePokemons
    throw UnimplementedError();
  }

  @override
  Future<bool> saveFavoritePokemons(List<PokemonModel> favorites) {
    // TODO: implement saveFavoritePokemons
    throw UnimplementedError();
  }
}
