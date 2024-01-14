import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:open_app_file/open_app_file.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../models/allOrders/allOrders.dart';
import '../../shared/colors/colors.dart';
import '../../shared/network/remote/deleteOrder/deleteOrder.dart';
import '../clientsDetails/orderDetails.dart';

class OrderSearchItems extends StatefulWidget {
  GetAllOrdersDetails searchResult;

  OrderSearchItems(
    this.searchResult,
  );

  @override
  State<OrderSearchItems> createState() => _OrderSearchItemsState();
}

var totalControlled = TextEditingController();

final List<File> images = [];
final List<String> imagesPath = [];

class _OrderSearchItemsState extends State<OrderSearchItems> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.all(20),
        decoration: BoxDecoration(
            color: categories2,
            border: Border.all(),
            borderRadius: const BorderRadius.all(Radius.circular(25))),
        child: InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => OrderDetails(widget.searchResult)));
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Text(
                          "Name:",
                          style: TextStyle(fontSize: 20, color: Colors.red),
                        ),
                        Text(widget.searchResult.client.name,
                            style: const TextStyle(
                                fontSize: 20, color: Colors.black)),
                      ],
                    ),
                    Row(
                      children: [
                        Text("Phone : ",
                            style: TextStyle(fontSize: 20, color: Colors.red)),
                        Text(widget.searchResult.client.mobile,
                            style:
                                TextStyle(fontSize: 20, color: Colors.black)),
                      ],
                    ),
                    Row(
                      children: [
                        Text("Address : ",
                            style: TextStyle(fontSize: 20, color: Colors.red)),
                        Text(widget.searchResult.client.address,
                            style:
                                TextStyle(fontSize: 20, color: Colors.black)),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Text("Old total : ",
                            style: TextStyle(fontSize: 20, color: Colors.red)),
                        Text("${widget.searchResult.total} EG",
                            style: const TextStyle(
                                fontSize: 20, color: Colors.black)),
                      ],
                    ),
                    Row(
                      children: [
                        const Text("Deposit : ",
                            style: TextStyle(fontSize: 20, color: Colors.red)),
                        Text("${widget.searchResult.deposit} EG ",
                            style: const TextStyle(
                                fontSize: 20, color: Colors.black)),
                      ],
                    ),
                    Row(
                      children: [
                        const Text("rest : ",
                            style: TextStyle(fontSize: 20, color: Colors.red)),
                        Text("${widget.searchResult.rest} EG",
                            style: const TextStyle(
                                fontSize: 20, color: Colors.black)),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Text("Date of order : ",
                            style: TextStyle(fontSize: 20, color: Colors.red)),
                        Text("${widget.searchResult.date}".substring(0, 10),
                            style: const TextStyle(
                                fontSize: 20, color: Colors.black)),
                      ],
                    ),
                    Row(
                      children: [
                        const Text("waiting : ",
                            style: TextStyle(fontSize: 20, color: Colors.red)),
                        Text("${widget.searchResult.ago} days",
                            style: const TextStyle(
                                fontSize: 20, color: Colors.black)),
                      ],
                    ),
                  ],
                ),
              ),
              ScrollConfiguration(
                behavior: ScrollConfiguration.of(context).copyWith(
                  dragDevices: {
                    PointerDeviceKind.touch,
                    PointerDeviceKind.mouse,
                  },
                ),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height / 4,
                  child: ListView.builder(
                    itemCount: widget.searchResult.orderImages.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index2) {
                      return Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                              onTap: () {},
                              child: InkWell(
                                onTap: () async {
                                  Uri url = Uri.parse(widget
                                      .searchResult.orderImages[index2].image);
                                  if (await canLaunchUrl(url)) {
                                    await launchUrl(
                                      url,
                                    );
                                  }
                                },
                                child: Image.network(widget
                                    .searchResult.orderImages[index2].image),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 0,
                            right: 0,
                            child: GestureDetector(
                              onTap: () async {
                                await Delete.deleteImage(
                                    widget.searchResult.orderImages[index2].id);
                                setState(() {});
                              },
                              child: const CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 13,
                                child: Icon(
                                  Icons.close,
                                  color: Colors.red,
                                  size: 20,
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void openFile(File file) {
    OpenAppFile.open(file.path);
  }
}
