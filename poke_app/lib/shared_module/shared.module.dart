import 'package:flutter_modular/flutter_modular.dart';
import 'package:poke_app/shared_module/http_client/http/http_adapter.dart';
import 'package:poke_app/shared_module/http_client/http_client_adapter.dart';

class SharedModule extends Module {
  @override
  void exportedBinds(Injector i) {
    i.addSingleton<IHttpClientAdapter>(HttpAdapter.new);
    super.exportedBinds(i);
  }
}
