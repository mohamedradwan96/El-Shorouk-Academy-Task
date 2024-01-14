// To parse this JSON data, do
//
//     final allclients = allclientsFromJson(jsonString);

class AllClientsResponse {
  int id;
  String name;
  String mobile;
  String address;

  AllClientsResponse({
    required this.id,
    required this.name,
    required this.mobile,
    required this.address,
  });

  factory AllClientsResponse.fromJson(Map<String, dynamic> json) =>
      AllClientsResponse(
        id: json["id"],
        name: json["name"],
        mobile: json["mobile"],
        address: json["address"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "mobile": mobile,
        "address": address,
      };
}
