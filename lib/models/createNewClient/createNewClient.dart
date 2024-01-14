// To parse this JSON data, do
//
//     final createNewClient = createNewClientFromJson(jsonString);

import 'dart:convert';
import 'dart:io';

String createNewClientToJson(CreateNewClient data) =>
    json.encode(data.toJson());

class CreateNewClient {
  String? name;
  String? mobile;
  String? address;
  int? total;
  int? deposit;
  //int? rest;
  DateTime? date;
  List<File>? orderImages;

  CreateNewClient({
    required this.name,
    required this.mobile,
    required this.address,
    required this.total,
    required this.deposit,
    // required this.rest,
    required this.date,
//    required this.client,
    //required this.orderImages,
  });

  //instance of user in all app

  static CreateNewClient? _userInstance;

  CreateNewClient._();

  static CreateNewClient get userInstance =>
      _userInstance ??= CreateNewClient._();

  // factory CreateNewClient.fromJson(Map<String, dynamic> json) =>
  //     CreateNewClient(
  //       name: json["name"],
  //       mobile: json["mobile"],
  //       address: json["address"],
  //       total: json["total"],
  //       deposit: json["deposit"],
  //       // rest: json["rest"],
  //       date: DateTime.parse(json["date"]),
  //       // client: Client.fromJson(json["client"]),
  //       // orderImages: List<OrderImage>.from(
  //       //     json["order_images"].map((x) => OrderImage.fromJson(x))),
  //     );

  Map<String, dynamic> toJson() {
    print(name);
    return {
      //"id": id,
      "name": name,
      "mobile": mobile,
      "address": address,
      "total": total,
      "deposit": deposit,
      //"rest": rest,
      "date":
          "${date?.year.toString().padLeft(4, '0')}-${date?.month.toString().padLeft(2, '0')}-${date?.day.toString().padLeft(2, '0')}",
      // "client": client?.toJson(),

      "order_images": orderImages,
    };
  }
}

//
// class Client {
//   String name;
//   String mobile;
//   String address;
//
//   Client({
//     required this.name,
//     required this.mobile,
//     required this.address,
//   });
//
//   factory Client.fromJson(Map<String, dynamic> json) => Client(
//         name: json["name"],
//         mobile: json["mobile"],
//         address: json["address"],
//       );
//
//   Map<String, dynamic> toJson() {
//     return {
//       "name": name,
//       "mobile": mobile,
//       "address": address,
//     };
//   }
// }
//
class OrderImage {
  String image;
  // int order;

  OrderImage({
    required this.image,
    //required this.order,
  });

  factory OrderImage.fromJson(Map<String, dynamic> json) => OrderImage(
        // id: json["id"],
        image: json["image"],
        //order: json["order"],
      );

  Map<String, dynamic> toJson() => {
        "image": image,
        //"order": order,
      };
}
