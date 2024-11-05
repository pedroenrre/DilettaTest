import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:poke_app/home_module/presenters/components/favorites_badge.dart';
import 'package:poke_app/home_module/presenters/components/pokemon_card.dart';
import 'package:poke_app/home_module/presenters/favorites_page/favorites_controller.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  final controller = Modular.get<FavoritesController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('My Favorites'),
          actions: [
            AnimatedBuilder(
              animation: controller,
              builder: (context, widget) {
                return FavoritesBadge(
                  count: controller.favoritesStore.favorites.length,
                  onFavoritePressed: () {},
                );
              },
            )
          ],
        ),
        body: AnimatedBuilder(
          animation: controller,
          builder: (context, widget) {
            return ListView.builder(
              itemCount: controller.favoritesStore.favorites.length,
              padding: const EdgeInsets.all(16),
              itemBuilder: (context, index) {
                final pokemon = controller.favoritesStore.favorites[index];
                return PokemonCard(
                  pokemon: pokemon,
                  isFavorite: true,
                  onFavoritePressed: () {
                    controller.toggleFavorite(pokemon, true);
                  },
                );
              },
            );
          },
        ));
  }
}
