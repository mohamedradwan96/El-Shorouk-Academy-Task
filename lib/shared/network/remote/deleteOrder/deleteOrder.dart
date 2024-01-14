import 'dart:ffi';

import 'package:dio/dio.dart';

import '../../apiManger.dart';

class Delete {
  static Future<Void?> deleteOrder(int orderID) async {
    late Response response;

    try {
      response = await ApiManger().dio.delete(
            "/order/delete/$orderID",
          );
      print(response);
    } on DioException catch (e) {
      print(e.response?.data);

      throw Exception('Failed to fetch Data');
    }
    return null;
  }

  static Future<Void?> deleteImage(int imageID) async {
    late Response response;

    try {
      response = await ApiManger().dio.delete(
            "/order/image/delete/$imageID",
          );
      print(response);
    } on DioException catch (e) {
      print(e.response?.data);

      throw Exception('Failed to fetch Data');
    }
    return null;
  }

  static Future<Void?> doneOrder(int orderID) async {
    late Response response;

    try {
      response = await ApiManger().dio.put(
        "/order/update/$orderID",
        data: {"completed": true},
      );
      print(response);
    } on DioException catch (e) {
      print(e.response?.data);

      throw Exception('Failed to fetch Data');
    }
    return null;
  }

  static Future<Void?> deleteClient(int clientID) async {
    late Response response;

    try {
      response = await ApiManger().dio.delete(
            "/client/delete/$clientID",
          );
      print(response);
    } on DioException catch (e) {
      print(e.response?.data);

      throw Exception('Failed to fetch Data');
    }
    return null;
  }

  static Future<Void?> updateTotal(
      int orderID, int total, int quantity, int deposit) async {
    late Response response;

    try {
      response = await ApiManger().dio.put(
        "/order/update/$orderID",
        data: {
          "total": total,
          "deposit": deposit,
          "quantity": quantity,
        },
      );
      print(response);
    } on DioException catch (e) {
      print(e.response?.data);

      throw Exception('Failed to fetch Data');
    }
    return null;
  }
}
