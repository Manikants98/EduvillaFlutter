import 'package:dio/dio.dart';

final dio = Dio();
const baseURL = "https://api-eduvila.onrender.com";

Future<Response> register(name, email, password) async {
  try {
    final response = await dio.post('$baseURL/register',
        data: {'name': name, 'email': email, 'password': password});
    print('$response ---- Response');
    return response;
  } catch (e) {
    print(e);
    throw Exception();
  }
}
