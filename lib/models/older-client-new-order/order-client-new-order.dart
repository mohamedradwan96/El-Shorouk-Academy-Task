// To parse this JSON data, do
//
//     final createOrderOldClient = createOrderOldClientFromJson(jsonString);

import 'dart:convert';

CreateOrderOldClient createOrderOldClientFromJson(String str) =>
    CreateOrderOldClient.fromJson(json.decode(str));

String createOrderOldClientToJson(CreateOrderOldClient data) =>
    json.encode(data.toJson());

class CreateOrderOldClient {
  List<OrderImage>? orderImages;
  int? total;
  int? deposit;
  DateTime? date;
  //bool? completed;
  int? client;

  CreateOrderOldClient({
    required this.orderImages,
    required this.total,
    required this.deposit,
    required this.date,
    //required this.completed,
    required this.client,
  });

  static CreateOrderOldClient? _userInstance;

  CreateOrderOldClient._();

  static CreateOrderOldClient get userInstance =>
      _userInstance ??= CreateOrderOldClient._();

  factory CreateOrderOldClient.fromJson(Map<String, dynamic> json) =>
      CreateOrderOldClient(
        // id: json["id"],
        orderImages: List<OrderImage>.from(
            json["order_images"].map((x) => OrderImage.fromJson(x))),
        total: json["total"],
        deposit: json["deposit"],
        //rest: json["rest"],
        date: DateTime.parse(json["date"]),
        //completed: json["completed"],
        client: json["client"],
      );

  Map<String, dynamic> toJson() => {
        //"id": id,
        "order_images": List<dynamic>.from(orderImages!.map((x) => x.toJson())),
        "total": total,
        "deposit": deposit,
        //"rest": rest,
        "date":
            "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
        //"completed": completed,
        "client": client,
      };
}

class OrderImage {
  int id;
  String image;
  int order;

  OrderImage({
    required this.id,
    required this.image,
    required this.order,
  });

  factory OrderImage.fromJson(Map<String, dynamic> json) => OrderImage(
        id: json["id"],
        image: json["image"],
        order: json["order"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "image": image,
        "order": order,
      };
}
