import 'package:http/http.dart' as http;

/// API Client abstraction
abstract class ApiClient {
  Future<http.Response> get(
    String path, {
    Map<String, String> headers,
    Map<String, String> query,
    bool attachToken,
  });

  Future<http.Response> post(
    String path, {
    Object? body,
    Map<String, String> headers,
    Map<String, String> query,
    bool attachToken,
  });

  Future<http.Response> put(
    String path, {
    Object? body,
    Map<String, String> headers,
    Map<String, String> query,
    bool attachToken,
  });

  Future<http.Response> patch(
    String path, {
    Object? body,
    Map<String, String> headers,
    Map<String, String> query,
    bool attachToken,
  });

  Future<http.Response> delete(
    String path, {
    Object? body,
    Map<String, String> headers,
    Map<String, String> query,
    bool attachToken,
  });
}
