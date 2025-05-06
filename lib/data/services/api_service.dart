import 'package:dio/dio.dart';

class ApiService {
  ApiService() {
    _dio.interceptors.add(LogInterceptor());
  }
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'https://api.thecatapi.com/v1',
      headers: {
        'x-api-key':
            'live_rs2cYwd6t2U172ZVENYGbtNNF4GcNn5CI17YBNd7cG1L0lqlSmFQUwp3bsmZdMtI',
      },
    ),
  );

  Future<Map<String, dynamic>?> getRandomCat() async {
    try {
      final response = await _dio.get(
        '/images/search',
        queryParameters: {'has_breeds': true, 'limit': 1},
      );
      if (response.data != null &&
          response.data is List &&
          response.data.isNotEmpty) {
        return response.data[0];
      }
    } catch (e) {
      return null;
    }
    return null;
  }
}
