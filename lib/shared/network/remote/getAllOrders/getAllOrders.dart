import 'package:dio/dio.dart';

import '../../../../models/allOrders/allOrders.dart';
import '../../apiManger.dart';

class GetAllOrdersManager {
  static Future<List<GetAllOrdersDetails>> getAllOrders() async {
    late Response response;
    try {
      print("Try 1");
      response = await ApiManger().dio.get(
            "/order?completed=False",
          );
      print("Try 2");
      print(response.data['results']);

      return (response.data['results'] as List)
          .map((product) =>
              GetAllOrdersDetails.fromJson(product as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      print(e.response!.data);

      throw Exception('Failed to fetch product');
    }
  }
}
