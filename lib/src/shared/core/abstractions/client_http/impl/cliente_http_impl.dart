import 'package:dio/dio.dart';
import 'package:flutter_application_1/src/shared/core/abstractions/client_http/cliente_http.dart';
import 'package:flutter_application_1/src/shared/core/abstractions/client_http/model/cliente_response.dart';
import 'package:flutter_application_1/src/shared/core/abstractions/local_storage/local_storage.dart';
import 'package:flutter_application_1/src/shared/core/abstractions/local_storage/storage_key_type/storage_key_type.dart';
import 'package:flutter_application_1/src/shared/core/environment/routers/routers.dart';

import 'package:flutter_application_1/src/shared/helpers/debug_print/debug_print.dart';

class ClienteHttpImpl implements ClientHttp {
  final Dio clienteHttp;
  final String baseUrl;
  final String prefixo;
  final LocalStorage localStorage;

  ClienteHttpImpl({
    required this.clienteHttp,
    required this.baseUrl,
    required this.prefixo,
    required this.localStorage,
  }) {
    clienteHttp.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          options.headers.addAll({
            'Access-Control-Allow-Origin': '*',
            'Acess-Control-Allow-Methods':
                'GET, HEAD, PUT, PATCH, POST, DELETE, OPTIONS',
            'Authorization':
                'Bearer ${localStorage.read(key: StorageKeyType.acessToken)}'
          });
          return handler.next(options);
        },
        onError: (error, handler) async {
          if (error.response?.statusCode == 401 &&
              error.response?.data['Token inválido ou expirado']) {
            await refreshToken();
            return handler.resolve(await _retryRequest(error.requestOptions));
          }

          return handler.next(error);
        },
      ),
    );
  }

  Future<Response<dynamic>> _retryRequest(RequestOptions requestOptions) async {
    final options = Options(
      method: requestOptions.method,
      headers: requestOptions.headers,
    );

    return clienteHttp.request<dynamic>(
      requestOptions.path,
      data: requestOptions.data,
      queryParameters: requestOptions.queryParameters,
      options: options,
    );
  }

  Future<void> refreshToken() async {
    try {
      final response =
          await clienteHttp.get('$baseUrl$prefixo/path/refresh-token/');

      if (response.statusCode == 200) {
        localStorage.save(
          key: StorageKeyType.acessToken,
          value: response.data['access_token'],
        );
      } else {
        localStorage.remove(key: StorageKeyType.acessToken);
        handlerExpiredAcessToken();
      }
    } catch (e) {
      localStorage.remove(key: StorageKeyType.acessToken);
      handlerExpiredAcessToken();
      debugPrintHelper(e.toString());
    }
  }

  @override
  Future<ClienteResponse> delete({
    required String url,
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    Response response;
    try {
      debugPrintHelper("url: $baseUrl$prefixo$url");
      debugPrintHelper("queryParameters: $queryParameters");
      debugPrintHelper("body: $body");

      response = await clienteHttp.delete(
        baseUrl + prefixo + url,
        data: body,
        queryParameters: queryParameters,
      );

      return ClienteResponse(
        body: response.data,
        statusCode: response.statusCode,
        statusMessage: response.statusMessage,
      );
    } on DioException catch (e) {
      final Map<String, dynamic> body = Map.from(e.response?.data);
      return ClienteResponse(
        body: body,
        statusCode: e.response?.statusCode,
        errorMessage: body['message'],
      );
    } catch (e) {
      debugPrintHelper(e.toString());
      return ClienteResponse();
    }
  }

  @override
  Future<ClienteResponse> get({
    required String url,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    Response response;
    try {
      debugPrintHelper("url: $baseUrl$prefixo$url");
      debugPrintHelper("queryParameters: $queryParameters");

      response = await clienteHttp.get(
        baseUrl + prefixo + url,
        queryParameters: queryParameters,
      );

      return ClienteResponse(
        body: response.data,
        statusCode: response.statusCode,
        statusMessage: response.statusMessage,
      );
    } on DioException catch (e) {
      final Map<String, dynamic> body = Map.from(e.response?.data);
      return ClienteResponse(
        body: body,
        statusCode: e.response?.statusCode,
        errorMessage: body['message'],
      );
    } catch (e) {
      debugPrintHelper(e.toString());
      return ClienteResponse();
    }
  }

  @override
  Future<ClienteResponse> post({
    required String url,
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    Response response;
    try {
      debugPrintHelper("url: $baseUrl$prefixo$url");
      debugPrintHelper("queryParameters: $queryParameters");
      debugPrintHelper("body: $body");

      response = await clienteHttp.post(
        baseUrl + prefixo + url,
        data: body,
        queryParameters: queryParameters,
      );

      return ClienteResponse(
        body: response.data,
        statusCode: response.statusCode,
        statusMessage: response.statusMessage,
      );
    } on DioException catch (e) {
      final Map<String, dynamic> body = Map.from(e.response?.data);
      return ClienteResponse(
        body: body,
        statusCode: e.response?.statusCode,
        errorMessage: body['message'],
      );
    } catch (e) {
      debugPrintHelper(e.toString());
      return ClienteResponse();
    }
  }

  @override
  Future<ClienteResponse> put({
    required String url,
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    Response response;
    try {
      debugPrintHelper("url: $baseUrl$prefixo$url");
      debugPrintHelper("queryParameters: $queryParameters");
      debugPrintHelper("body: $body");

      response = await clienteHttp.put(
        baseUrl + prefixo + url,
        data: body,
        queryParameters: queryParameters,
      );

      return ClienteResponse(
        body: response.data,
        statusCode: response.statusCode,
        statusMessage: response.statusMessage,
      );
    } on DioException catch (e) {
      final Map<String, dynamic> body = Map.from(e.response?.data);
      return ClienteResponse(
        body: body,
        statusCode: e.response?.statusCode,
        errorMessage: body['message'],
      );
    } catch (e) {
      debugPrintHelper(e.toString());
      return ClienteResponse();
    }
  }
}
