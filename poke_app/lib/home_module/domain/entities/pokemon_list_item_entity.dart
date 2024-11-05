class PokemonListItemEntity {
  num id;
  String name;
  String url;
  List<String> types;
  PokemonListItemEntity({
    required this.name,
    required this.url,
    required this.id,
    required this.types,
  });

  PokemonListItemEntity copyWith({
    bool? isFavorite,
  }) {
    return PokemonListItemEntity(
      id: id,
      name: name,
      url: url,
      types: types,
    );
  }
}
