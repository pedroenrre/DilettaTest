class PokemonListItemEntity {
  num id;
  String name;
  String url;
  List<String> types;
  bool favorite;
  PokemonListItemEntity({
    required this.name,
    required this.url,
    required this.id,
    required this.types,
    this.favorite = false,
  });

  PokemonListItemEntity copyWith({
    bool? isFavorite,
  }) {
    return PokemonListItemEntity(
      id: id,
      name: name,
      url: url,
      types: types,
      favorite: isFavorite ?? favorite,
    );
  }
}
