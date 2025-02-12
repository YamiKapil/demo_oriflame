import 'package:dio/dio.dart';

class NetworkClient {
  late final Dio _dio;
  final timeout = const Duration(seconds: 30);

  NetworkClient._() {
    _dio = Dio();
    _dio.options.receiveTimeout = timeout;
    _dio.options.connectTimeout = timeout;
  }

  static final instance = NetworkClient._();

  Future<Response> get(String url) async {
    return _dio.get(url,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            "accept": "*/*",
            "Connection": "Keep-Alive",
          },
        ));
  }
}
