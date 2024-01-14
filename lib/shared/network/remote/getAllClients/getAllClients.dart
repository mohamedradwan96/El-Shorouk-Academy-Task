import 'package:dio/dio.dart';

import '../../../../models/allClients/allClientsResponse.dart';
import '../../apiManger.dart';

class GetALLClients {
  static Future<List<AllClientsResponse>> getAllClients() async {
    late Response response;
    try {
      print("Try 1");
      response = await ApiManger().dio.get(
            "/client/",
          );
      print("Try 2");
      print(response.data['results']);

      return (response.data['results'] as List)
          .map((product) =>
              AllClientsResponse.fromJson(product as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      print(e.response?.data);

      throw Exception('Failed to fetch product');
    }
  }

  static Future<void> updateClient(
      int clientID, String name, String mobile, String address) async {
    late Response response;
    try {
      print("Try 1");
      response = await ApiManger().dio.put("/client/update/$clientID", data: {
        "name": name,
        "mobile": mobile,
        "address": address,
      });
      print("Try 2");
      print(response);
    } on DioException catch (e) {
      print(e.response?.data);

      throw Exception('Failed to fetch product');
    }
  }
}
