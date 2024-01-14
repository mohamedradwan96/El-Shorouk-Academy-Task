// To parse this JSON data, do
//
//     final searchClient = searchClientFromJson(jsonString);

import 'dart:convert';

SearchClient searchClientFromJson(String str) =>
    SearchClient.fromJson(json.decode(str));

String searchClientToJson(SearchClient data) => json.encode(data.toJson());

class SearchClient {
  bool next;
  bool previous;
  Links links;
  int from;
  int to;
  int pageNumber;
  int count;
  int perPage;
  int totalPages;
  List<SearchResult> results;

  SearchClient({
    required this.next,
    required this.previous,
    required this.links,
    required this.from,
    required this.to,
    required this.pageNumber,
    required this.count,
    required this.perPage,
    required this.totalPages,
    required this.results,
  });

  factory SearchClient.fromJson(Map<String, dynamic> json) => SearchClient(
        next: json["next"],
        previous: json["previous"],
        links: Links.fromJson(json["links"]),
        from: json["from"],
        to: json["to"],
        pageNumber: json["page_number"],
        count: json["count"],
        perPage: json["per_page"],
        totalPages: json["total_pages"],
        results: List<SearchResult>.from(
            json["results"].map((x) => SearchResult.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "next": next,
        "previous": previous,
        "links": links.toJson(),
        "from": from,
        "to": to,
        "page_number": pageNumber,
        "count": count,
        "per_page": perPage,
        "total_pages": totalPages,
        // "results": List<dynamic>.from(results.map((x) => x.toJson())),
      };
}

class Links {
  dynamic next;
  dynamic previous;

  Links({
    this.next,
    this.previous,
  });

  factory Links.fromJson(Map<String, dynamic> json) => Links(
        next: json["next"],
        previous: json["previous"],
      );

  Map<String, dynamic> toJson() => {
        "next": next,
        "previous": previous,
      };
}

class SearchResult {
  int id;
  String name;
  String mobile;
  String address;

  SearchResult({
    required this.id,
    required this.name,
    required this.mobile,
    required this.address,
  });

  factory SearchResult.fromJson(Map<String, dynamic> json) => SearchResult(
        id: json["id"],
        name: json["name"],
        mobile: json["mobile"],
        address: json["address"],
      );

  // Map<String, dynamic> toJson() => {
  //   "id": id,
  //   "name": name,
  //   "mobile": mobile,
  //   "address": address,
  // };
}
