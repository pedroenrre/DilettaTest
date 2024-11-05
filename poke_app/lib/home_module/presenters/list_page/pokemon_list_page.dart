import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:poke_app/home_module/presenters/components/favorites_badge.dart';
import 'package:poke_app/home_module/presenters/components/modal_loading.dart';
import 'package:poke_app/home_module/presenters/components/pokemon_card.dart';
import 'package:poke_app/home_module/presenters/list_page/pokemon_list_controller.dart';
import 'package:poke_app/home_module/presenters/list_page/pokemon_list_state.dart';

class PokeListPage extends StatefulWidget {
  const PokeListPage({super.key});

  @override
  State<PokeListPage> createState() => _PokeListPageState();
}

class _PokeListPageState extends State<PokeListPage> {
  final controller = Modular.get<PokemonListController>();

  @override
  void initState() {
    super.initState();
    controller.fetchPokemons();
  }

  onFavoritePressed() {
    Modular.to.pushNamed('/favorites');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Poke App'),
        actions: [
          AnimatedBuilder(
            animation: controller,
            builder: (context, widget) {
              return FavoritesBadge(
                count: controller.favoritesStore.favorites.length,
                onFavoritePressed: onFavoritePressed,
              );
            },
          )
        ],
      ),
      body: AnimatedBuilder(
        animation: controller,
        builder: (context, widget) {
          if (controller.listState is PokemonListLoadingState) {
            return Stack(
              children: [
                ModalBarrier(
                  color: Colors.black.withOpacity(0.5),
                  dismissible: false,
                ),
                const Center(
                  child: CircularProgressIndicator(),
                ),
              ],
            );
          }
          if (controller.listState is PokemonListLoadedState) {
            final state = controller.listState as PokemonListLoadedState;
            return Stack(
              children: [
                ListView.builder(
                  itemCount: state.pokemons.length,
                  padding: const EdgeInsets.all(16),
                  itemBuilder: (context, index) {
                    final pokemon = state.pokemons[index];
                    if (index == state.pokemons.length - 1) {
                      return Column(
                        children: [
                          PokemonCard(
                            pokemon: pokemon,
                            isFavorite:
                                controller.favoritesStore.isFavorite(pokemon),
                            onFavoritePressed: () {
                              controller.toggleFavorite(
                                pokemon,
                                controller.favoritesStore.isFavorite(pokemon),
                              );
                            },
                          ),
                          const SizedBox(height: 8),
                          ElevatedButton(
                            onPressed: controller.fetchPokemons,
                            child: const Text('Carregar mais'),
                          ),
                        ],
                      );
                    }
                    return PokemonCard(
                      pokemon: pokemon,
                      isFavorite: controller.favoritesStore.isFavorite(pokemon),
                      onFavoritePressed: () {
                        controller.toggleFavorite(
                          pokemon,
                          controller.favoritesStore.isFavorite(pokemon),
                        );
                      },
                    );
                  },
                ),
                ModalLoading(showModalLoading: state.loading),
              ],
            );
          }
          if (controller.listState is PokemonListErrorState) {
            final state = controller.listState as PokemonListErrorState;
            return Center(
              child: Text(state.message),
            );
          }
          return Container();
        },
      ),
    );
  }
}
