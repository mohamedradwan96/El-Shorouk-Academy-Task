import 'dart:io';
import 'dart:ui';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:open_app_file/open_app_file.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../models/allOrders/allOrders.dart';
import '../../modules/textfield.dart';
import '../../shared/colors/colors.dart';
import '../../shared/componnet.dart';
import '../../shared/network/remote/deleteOrder/deleteOrder.dart';

class OrderDetails extends StatefulWidget {
  GetAllOrdersDetails searchResult;

  OrderDetails(
    this.searchResult,
  );
  static const String routeName = "orderDetails";

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

var totalControlled = TextEditingController();
TextEditingController quantityControlled = TextEditingController();
TextEditingController depositControlled = TextEditingController();

ScrollController _controller = new ScrollController();
GlobalKey<FormState> formKey = GlobalKey<FormState>();

final List<File> images = [];
final List<String> imagesPath = [];

class _OrderDetailsState extends State<OrderDetails> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    quantityControlled.text = widget.searchResult.quantity.toString();
    depositControlled.text = widget.searchResult.deposit.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: primaryColor, size: 40),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "Order::${widget.searchResult.client.name}",
          style: TextStyle(color: primaryColor),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.all(20),
        decoration: BoxDecoration(
            color: categories2,
            border: Border.all(),
            borderRadius: const BorderRadius.all(Radius.circular(25))),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
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
                                style:
                                    TextStyle(fontSize: 20, color: Colors.red)),
                            Text(widget.searchResult.client.mobile,
                                style: TextStyle(
                                    fontSize: 20, color: Colors.black)),
                          ],
                        ),
                        Row(
                          children: [
                            Text("Address : ",
                                style:
                                    TextStyle(fontSize: 20, color: Colors.red)),
                            Text(widget.searchResult.client.address,
                                style: TextStyle(
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
                            const Text("Old total : ",
                                style:
                                    TextStyle(fontSize: 20, color: Colors.red)),
                            Text("${widget.searchResult.total} EG",
                                style: const TextStyle(
                                    fontSize: 20, color: Colors.black)),
                          ],
                        ),
                        Row(
                          children: [
                            const Text("Deposit : ",
                                style:
                                    TextStyle(fontSize: 20, color: Colors.red)),
                            Text("${widget.searchResult.deposit} EG ",
                                style: const TextStyle(
                                    fontSize: 20, color: Colors.black)),
                          ],
                        ),
                        Row(
                          children: [
                            const Text("rest : ",
                                style:
                                    TextStyle(fontSize: 20, color: Colors.red)),
                            Text("${widget.searchResult.rest} EG",
                                style: const TextStyle(
                                    fontSize: 20, color: Colors.black)),
                          ],
                        ),
                        Row(
                          children: [
                            const Text("Quantity : ",
                                style:
                                    TextStyle(fontSize: 20, color: Colors.red)),
                            Text("${widget.searchResult.quantity} ",
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
                                style:
                                    TextStyle(fontSize: 20, color: Colors.red)),
                            Text("${widget.searchResult.date}".substring(0, 10),
                                style: const TextStyle(
                                    fontSize: 20, color: Colors.black)),
                          ],
                        ),
                        Row(
                          children: [
                            const Text("waiting : ",
                                style:
                                    TextStyle(fontSize: 20, color: Colors.red)),
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
                        itemBuilder: (context, index) {
                          return Stack(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: InkWell(
                                  onTap: () {},
                                  child: InkWell(
                                    onTap: () async {
                                      Uri url = Uri.parse(widget.searchResult
                                          .orderImages[index].image);
                                      if (await canLaunchUrl(url)) {
                                        await launchUrl(
                                          url,
                                        );
                                      }
                                    },
                                    child: Image.network(widget
                                        .searchResult.orderImages[index].image),
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 0,
                                right: 0,
                                child: GestureDetector(
                                  onTap: () async {
                                    await Delete.deleteImage(widget
                                        .searchResult.orderImages[index].id);
                                    _removeImageOrder(index);

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
                  ),
                  TextFields(
                      message: "Please enter the Quantity",
                      controller: quantityControlled,
                      fieldName: "New Quantity",
                      label: " New Total"),
                  TextFields(
                      message: "Please enter the New Deposit",
                      controller: depositControlled,
                      fieldName: "New Deposit",
                      label: " New Deposit"),
                  TextFields(
                      message: "Please enter the Total",
                      controller: totalControlled,
                      fieldName: "New Total",
                      label: " New Total"),
                  Center(
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue),
                      onPressed: () async {
                        await Delete.updateTotal(
                          widget.searchResult.id,
                          int.parse(totalControlled.text),
                          int.parse(quantityControlled.text),
                          int.parse(depositControlled.text),
                        );
                        setState(() {});
                        totalControlled.clear();
                        showMessage(context,
                            "new total & Quantity added Successfully 😜 ", "");
                      },
                      icon: const Icon(
                        Icons.monetization_on,
                        color: Colors.white,
                      ),
                      label: const Text('Add New Total & Quantity'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: primaryColor),
                          onPressed: _pickImages,
                          icon: const Icon(Icons.image),
                          label: Text('Add Images (${images.length})'),
                        ),
                        ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red),
                          onPressed: () async {
                            await Delete.deleteOrder(widget.searchResult.id);
                            setState(() {});
                            showMessage(
                                context, "Order Deleted Successfully 😜 ", "");
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
                            await Delete.doneOrder(widget.searchResult.id);
                            setState(() {});
                            showMessage(
                                context, "Congratulation 💲💲💲💃💃💃 ", "");
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
                  if (images.isNotEmpty) ...[
                    ScrollConfiguration(
                      behavior: ScrollConfiguration.of(context).copyWith(
                        dragDevices: {
                          PointerDeviceKind.touch,
                          PointerDeviceKind.mouse,
                        },
                      ),
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height / 2,
                        child: ListView.builder(
                          controller: _controller,
                          physics: const AlwaysScrollableScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemCount: images.length,
                          itemBuilder: (context, index) {
                            var image = images[index];
                            return Stack(
                              children: [
                                InkWell(
                                  onTap: () async {
                                    openFile(image);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Image.file(images[index]),
                                  ),
                                ),
                                Positioned(
                                  top: 0,
                                  right: 0,
                                  child: GestureDetector(
                                    onTap: () {
                                      _removeImage(index);
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
                    ),
                  ],
                  Center(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * .50,
                      height: MediaQuery.of(context).size.height / 10,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: primaryColor),
                        onPressed: () async {
                          // Code to submit the form
                          await register();
                          totalControlled.clear();
                        },
                        child: const Text(
                          'Update Images',
                          style: TextStyle(fontSize: 22),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void openFile(File file) {
    OpenAppFile.open(file.path);
  }

  void _removeImage(int index) {
    setState(() {
      images.removeAt(index);
    });
  }

  void _removeImageOrder(int index) {
    setState(() {
      widget.searchResult.orderImages.removeAt(index);
    });
  }

  Future<void> _pickImages() async {
    final pickedFiles = await FilePicker.platform
        .pickFiles(allowMultiple: true, type: FileType.image);
    if (pickedFiles == null) return;
    setState(() {
      images.addAll(pickedFiles.files.map((e) => File(e.path!)).toList());
    });
  }

  register() async {
    showLoading(context, "Estna Shwya Blash Srb3a 🙈  ");
    submitForm();
  }

  submitForm() async {
    var request = http.MultipartRequest('POST',
        Uri.parse('http://203.161.55.254:8009/api/v1/order/image/create'));

    // Add text fields

    request.fields['order'] = "${widget.searchResult.id}";

    // Add images
    for (final image in images) {
      print("**************");
      final file = await http.MultipartFile.fromPath(
        'image',
        image.path,
      );
      print("/////////////////////////////");
      request.files.add(file);
      print("/////////////////////////////*******************");
    }

    try {
      // Send the request
      final response = await request.send();
      print("/////////////////////////////*******************");
      images.clear();
      // Check if the request was successful (status code 2xx)
      if (response.statusCode == 201) {
        showMessage(context, "Client Created successfully 🙈 ", "");
        Future.delayed(const Duration(seconds: 1), () async {
          Navigator.pop(context);
          Navigator.pop(context);
          Navigator.pop(context);
          // Navigator.pushNamedAndRemoveUntil(
          //     context, Orders.routeName, (route) => false);
        });
      } else {
        hideLoading(context);
        showMessage(context, "Something went wrong 😭", "error");
      }
    } catch (e) {
      print(
          'Debug message: An error occurred while sending the data. Error: $e');
      // ignore: use_build_context_synchronously
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Error'),
          content: const Text('An error occurred while sending the data.'),
          actions: [
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }
}
