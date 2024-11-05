import 'package:http/http.dart' as http;
import '../http_client_adapter.dart';
import '../http_response.dart';

class HttpAdapter extends IHttpClientAdapter {
  final http.Client client = http.Client();
  final String baseUrl = 'https://pokeapi.co/api/v2';

  @override
  Future<HttpResponse> get(
    String path, {
    Map<String, String>? queryParameters,
    Map<String, String>? headers,
  }) async {
    final uri =
        Uri.parse('$baseUrl$path').replace(queryParameters: queryParameters);
    final result = await client.get(uri, headers: headers);
    final response = HttpResponse(
      data: result.body,
      statusCode: result.statusCode,
    );
    return response;
  }

  @override
  Future<HttpResponse> post(
    String path, {
    dynamic data,
    Map<String, String>? queryParameters,
    Map<String, String>? headers,
  }) async {
    final uri =
        Uri.parse('$baseUrl$path').replace(queryParameters: queryParameters);
    final result = await client.post(uri, headers: headers, body: data);
    final response = HttpResponse(
      data: result.body,
      statusCode: result.statusCode,
    );
    return response;
  }
}
