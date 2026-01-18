import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:take_home_assessment/utils/exceptions/auth__exception.dart';
import 'package:take_home_assessment/utils/exceptions/network_exception.dart';
import 'package:take_home_assessment/utils/exceptions/server_exception.dart';

import 'api_client.dart';

/// HTTP-based implementation
class HttpApiClient implements ApiClient {
  final String baseUrl;

  HttpApiClient({required this.baseUrl});

  Uri _buildUri(String path, Map<String, String>? query) {
    final uri = Uri.parse('$baseUrl$path');
    if (query != null && query.isNotEmpty) {
      return uri.replace(queryParameters: query);
    }
    return uri;
  }

  Future<Map<String, String>> _buildHeaders(
    Map<String, String>? headers,
    bool attachToken,
  ) async {
    final Map<String, String> finalHeaders = {
      'Accept': 'application/json',
      if (headers != null) ...headers,
    };
    return finalHeaders;
  }

  Future<http.Response> _handleRequest(
    Future<http.Response> Function() request,
  ) async {
    try {
      final res = await request();
      if (res.statusCode == 401) throw UnauthorizedException();
      if (res.statusCode >= 500) throw ServerException();
      return res;
    } on SocketException catch (_) {
      throw NetworkException('please check your connection');
    } on http.ClientException catch (_) {
      throw NetworkException('please check your connection');
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<http.Response> get(
    String path, {
    Map<String, String> headers = const {},
    Map<String, String> query = const {},
    bool attachToken = true,
  }) {
    final uri = _buildUri(path, query);
    return _handleRequest(() async {
      final finalHeaders = await _buildHeaders(headers, attachToken);
      return http.get(uri, headers: finalHeaders);
    });
  }

  @override
  Future<http.Response> post(
    String path, {
    Object? body,
    Map<String, String> headers = const {},
    Map<String, String> query = const {},
    bool attachToken = true,
  }) {
    final uri = _buildUri(path, query);
    return _handleRequest(() async {
      final finalHeaders = await _buildHeaders(headers, attachToken);
      return http.post(
        uri,
        headers: finalHeaders,
        body: body != null ? jsonEncode(body) : null,
      );
    });
  }

  @override
  Future<http.Response> put(
    String path, {
    Object? body,
    Map<String, String> headers = const {},
    Map<String, String> query = const {},
    bool attachToken = true,
  }) {
    final uri = _buildUri(path, query);
    return _handleRequest(() async {
      final finalHeaders = await _buildHeaders(headers, attachToken);
      return http.put(
        uri,
        headers: finalHeaders,
        body: body != null ? jsonEncode(body) : null,
      );
    });
  }

  @override
  Future<http.Response> patch(
    String path, {
    Object? body,
    Map<String, String> headers = const {},
    Map<String, String> query = const {},
    bool attachToken = true,
  }) {
    final uri = _buildUri(path, query);
    return _handleRequest(() async {
      final finalHeaders = await _buildHeaders(headers, attachToken);
      return http.patch(
        uri,
        headers: finalHeaders,
        body: body != null ? jsonEncode(body) : null,
      );
    });
  }

  @override
  Future<http.Response> delete(
    String path, {
    Object? body,
    Map<String, String> headers = const {},
    Map<String, String> query = const {},
    bool attachToken = true,
  }) {
    final uri = _buildUri(path, query);
    return _handleRequest(() async {
      final finalHeaders = await _buildHeaders(headers, attachToken);
      return http.delete(
        uri,
        headers: finalHeaders,
        body: body != null ? jsonEncode(body) : null,
      );
    });
  }
}
