import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../models/allOrders/allOrders.dart';
import '../../modules/searchOrder.dart';
import '../../shared/colors/colors.dart';
import '../../shared/componnet.dart';
import '../../shared/network/remote/deleteOrder/deleteOrder.dart';
import '../../shared/network/remote/getAllOrders/getAllOrders.dart';

class Orders extends StatefulWidget {
  static const String routeName = "orders";

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
        image: AssetImage("assets/images/img.png"),
        fit: BoxFit.cover,
      )),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
            iconTheme: const IconThemeData(color: primaryColor, size: 40),
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: const SearchOrder()),
        body: FutureBuilder<List<GetAllOrdersDetails>>(
          future: GetAllOrdersManager.getAllOrders(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              print("DONE");
              print(snapshot.data?.length);
              return Center(
                child: LoadingAnimationWidget.newtonCradle(
                  color: primaryColor,
                  size: 250,
                ),
              );
            }
            if (snapshot.hasError) {
              print(snapshot.error);
              print("ERROR");
              return Center(
                child: Column(
                  children: [
                    const Text("Something went Wrong"),
                    TextButton(
                        onPressed: () {
                          setState(() {});
                        },
                        child: const Text("Try Again"))
                  ],
                ),
              );
            }
            return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  //  print(snapshot.data!.length);
                  return Container(
                    padding: const EdgeInsets.all(20),
                    margin: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        color: categories2,
                        border: Border.all(),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(25))),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Order ${index + 1}",
                          style: const TextStyle(
                              fontSize: 22, color: Colors.indigo),
                        ),
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
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.red),
                                  ),
                                  Text(snapshot.data![index].client.name,
                                      style: const TextStyle(
                                          fontSize: 20, color: Colors.black)),
                                ],
                              ),
                              Row(
                                children: [
                                  Text("Phone : ",
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.red)),
                                  Text(snapshot.data![index].client.mobile,
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.black)),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            Text("Address : ",
                                style:
                                    TextStyle(fontSize: 20, color: Colors.red)),
                            Flexible(
                              child: Text(snapshot.data![index].client.address,
                                  maxLines: 2,
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.black)),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const Text("Quantity : ",
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.red)),
                                  Text("${snapshot.data![index].quantity} ",
                                      style: const TextStyle(
                                          fontSize: 20, color: Colors.black)),
                                ],
                              ),
                              Row(
                                children: [
                                  const Text("total : ",
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.red)),
                                  Text("${snapshot.data![index].total} EG",
                                      style: const TextStyle(
                                          fontSize: 20, color: Colors.black)),
                                ],
                              ),
                              Row(
                                children: [
                                  const Text("Deposit : ",
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.red)),
                                  Text("${snapshot.data![index].deposit} EG ",
                                      style: const TextStyle(
                                          fontSize: 20, color: Colors.black)),
                                ],
                              ),
                              Row(
                                children: [
                                  const Text("rest : ",
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.red)),
                                  Text("${snapshot.data![index].rest} EG",
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
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.red)),
                                  Text(
                                      "${snapshot.data![index].date}"
                                          .substring(0, 10),
                                      style: const TextStyle(
                                          fontSize: 20, color: Colors.black)),
                                ],
                              ),
                              Row(
                                children: [
                                  const Text("waiting : ",
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.red)),
                                  Text("${snapshot.data![index].ago} days",
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
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.red),
                                onPressed: () async {
                                  await Delete.deleteOrder(
                                      snapshot.data![index].id);
                                  setState(() {});
                                  showMessage(context,
                                      "Order Deleted Successfully 😜 ", "");
                                },
                                icon: const Icon(
                                  Icons.delete_forever_outlined,
                                  color: Colors.white,
                                ),
                                label: const Text('Delete Order'),
                              ),
                              ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.green),
                                onPressed: () async {
                                  await Delete.doneOrder(
                                      snapshot.data![index].id);
                                  setState(() {});
                                  showMessage(context,
                                      "Congratulation 💲💲💲💃💃💃 ", "");
                                },
                                icon: const Icon(
                                  Icons.done_outline_sharp,
                                  color: Colors.white,
                                ),
                                label: const Text('Done'),
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
                              itemCount:
                                  snapshot.data![index].orderImages.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index2) {
                                return Stack(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: InkWell(
                                        onTap: () async {
                                          Uri url = Uri.parse(snapshot
                                              .data![index]
                                              .orderImages[index2]
                                              .image);
                                          if (await canLaunchUrl(url)) {
                                            await launchUrl(
                                              url,
                                            );
                                          }
                                        },
                                        child: Image.network(snapshot
                                            .data![index]
                                            .orderImages[index2]
                                            .image),
                                      ),
                                    ),
                                    Positioned(
                                      top: 0,
                                      right: 0,
                                      child: GestureDetector(
                                        onTap: () async {
                                          await Delete.deleteImage(snapshot
                                              .data![index]
                                              .orderImages[index2]
                                              .id);
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
                  );
                });
          },
        ),
      ),
    );
  }
}
