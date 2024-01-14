// To parse this JSON data, do
//
//     final orders = ordersFromJson(jsonString);

class GetAllOrdersDetails {
  int id;
  List<OrderImage> orderImages;
  Client client;
  int ago;
  int total;
  int deposit;
  int rest;
  int quantity;
  DateTime date;
  bool completed;

  GetAllOrdersDetails({
    required this.id,
    required this.orderImages,
    required this.client,
    required this.ago,
    required this.total,
    required this.deposit,
    required this.rest,
    required this.quantity,
    required this.date,
    required this.completed,
  });

  factory GetAllOrdersDetails.fromJson(Map<String, dynamic> json) =>
      GetAllOrdersDetails(
        id: json["id"],
        orderImages: List<OrderImage>.from(
            json["order_images"].map((x) => OrderImage.fromJson(x))),
        client: Client.fromJson(json["client"]),
        ago: json["ago"],
        total: json["total"],
        deposit: json["deposit"],
        rest: json["rest"],
        quantity: json["quantity"],
        date: DateTime.parse(json["date"]),
        completed: json["completed"],
      );

  Map<String, dynamic> toJson() => {
        // "id": id,
        // "order_images": List<dynamic>.from(orderImages.map((x) => x.toJson())),
        // "client": client.toJson(),
        // "ago": ago,
        // "total": total,
        // "deposit": deposit,
        // "rest": rest,
        // "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "completed": completed,
      };
}

class Client {
  int id;
  String name;
  String mobile;
  String address;

  Client({
    required this.id,
    required this.name,
    required this.mobile,
    required this.address,
  });

  factory Client.fromJson(Map<String, dynamic> json) => Client(
        id: json["id"],
        name: json["name"],
        mobile: json["mobile"],
        address: json["address"],
      );
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

  // Map<String, dynamic> toJson() => {
  //   "id": id,
  //   "image": image,
  //   "order": order,
  // };
}
