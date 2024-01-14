import 'package:dio/dio.dart';

import '../../../../models/createNewClient/createNewClient.dart';
import '../../../../models/older-client-new-order/order-client-new-order.dart';
import '../../apiManger.dart';

class CreateNewClientManger {
  Future<dynamic> createClient() async {
    late Response response;

    var data = CreateNewClient.userInstance.toJson();
    print(data);
    try {
      print("Try:1");
      response = await ApiManger().dio.post("/order/client/create", data: data);
      print("2");
      return response.statusCode;
    } on DioException catch (e) {
      print(e.response!.statusCode);
      return e.response!.statusCode;
    }
  }

  Future<dynamic> createOldClientOrder() async {
    late Response response;

    var data = CreateOrderOldClient.userInstance.toJson();
    print(data);
    try {
      print("Try:1");
      response = await ApiManger().dio.post("/order/create", data: data);
      print("2");
      return response.statusCode;
    } on DioException catch (e) {
      print(e.response!.statusCode);
      return e.response!.statusCode;
    }
  }
}
