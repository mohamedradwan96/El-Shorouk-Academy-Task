import 'package:dio/dio.dart';

import '../../../models/allClients/allClientsResponse.dart';
import '../../../models/allOrders/allOrders.dart';
import '../apiManger.dart';

class SearchManger {
  static Future<List<AllClientsResponse>> getAllClient(
      String searchWord) async {
    late Response response;
    try {
      response = await ApiManger().dio.get(
            "/client/?mobile=$searchWord",
          );

      return (response.data['results'] as List)
          .map((product) =>
              AllClientsResponse.fromJson(product as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      print(e.response?.data);
      throw Exception('Failed to fetch product');
    }
  }

  static Future<List<GetAllOrdersDetails>> searchOrder(
      String searchWord) async {
    late Response response;
    try {
      response = await ApiManger().dio.get(
            "/order?client__mobile__icontains=$searchWord&completed=False",
          );

      return (response.data['results'] as List)
          .map((product) =>
              GetAllOrdersDetails.fromJson(product as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      print(e.response?.data);
      throw Exception('Failed to fetch product');
    }
  }
}
