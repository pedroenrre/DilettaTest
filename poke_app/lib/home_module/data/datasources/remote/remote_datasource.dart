import 'package:poke_app/home_module/data/models/pokemon_model.dart';

abstract class IRemoteDataSource {
  Future<List<PokemonModel>> getPokemons();
  Stream<PokemonModel> getPokemonsDetails(int initialCount, int maxCount);
}
