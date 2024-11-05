abstract class ILocalDataSource {
  Future<List<String>> getFavoritePokemons();
  Future<bool> saveFavoritePokemons(List<String> favorites);
}
