import 'http_response.dart';

abstract class IHttpClientAdapter {
  Future<HttpResponse> get(
    String path, {
    Map<String, String> queryParameters,
    Map<String, String> headers,
  });

  Future<HttpResponse> post(
    String path, {
    dynamic data,
    Map<String, String> queryParameters,
    Map<String, String> headers,
  });
}
