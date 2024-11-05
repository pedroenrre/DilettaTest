import 'package:flutter_modular/flutter_modular.dart';
import 'package:poke_app/shared_module/http_client/http/http_adapter.dart';
import 'package:poke_app/shared_module/http_client/http_client_adapter.dart';
import 'package:poke_app/shared_module/stores/favorites_store.dart';

class SharedModule extends Module {
  @override
  void exportedBinds(Injector i) {
    i.addSingleton<IHttpClientAdapter>(HttpAdapter.new);
    i.addSingleton<FavoritesStore>(FavoritesStore.new);
    super.exportedBinds(i);
  }
}
