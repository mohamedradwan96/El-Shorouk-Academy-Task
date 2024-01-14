import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../../modules/search.dart';
import '../../modules/textfield.dart';
import '../../shared/colors/colors.dart';
import '../../shared/componnet.dart';
import '../../shared/constants/sizedbox.dart';
import '../home_screens/home.dart';

class AddNewClients extends StatefulWidget {
  static const String routeName = "addNewClients";

  @override
  State<AddNewClients> createState() => _AddNewClientsState();
}

class _AddNewClientsState extends State<AddNewClients> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final userNameControlled = TextEditingController();

  final phoneControlled = TextEditingController();

  final addressControlled = TextEditingController();

  final totalControlled = TextEditingController();
  final quantityControlled = TextEditingController();

  final restControlled = TextEditingController();
  final dateController = TextEditingController();

  final depositControlled = TextEditingController();

  final List<File> images = [];

  DateTime date = DateTime.now();
  DateTime? newDate;

  File? image;

  @override
  void dispose() {
    userNameControlled.dispose();
    phoneControlled.dispose();
    addressControlled.dispose();
    totalControlled.dispose();
    depositControlled.dispose();
    restControlled.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/img.png"), fit: BoxFit.cover)),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
              iconTheme: const IconThemeData(color: primaryColor, size: 40),
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: const Search()),
          body: SingleChildScrollView(
            child: Center(
              child: Container(
                padding: const EdgeInsets.all(20),
                margin: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: const BorderRadius.all(Radius.circular(50))),
                child: Form(
                  key: formKey,
                  child: Column(children: [
                    TextFields(
                        message: "Please enter the name",
                        controller: userNameControlled,
                        fieldName: "Name",
                        icon: Icons.edit,
                        label: "Name"),
                    sizedBoxVertical10(),
                    TextFields(
                        message: "Please enter the phone",
                        controller: phoneControlled,
                        fieldName: "phone",
                        icon: Icons.phone,
                        label: "phone"),
                    sizedBoxVertical10(),
                    TextFields(
                        message: "Please enter the Address",
                        controller: addressControlled,
                        fieldName: "Address",
                        icon: Icons.location_on,
                        label: "Address"),
                    sizedBoxVertical10(),
                    TextFields(
                        message: "Please enter the Quantity",
                        controller: quantityControlled,
                        fieldName: "Quantity",
                        icon: Icons.onetwothree,
                        label: "Total"),
                    sizedBoxVertical10(),
                    TextFields(
                        message: "Please enter the Total",
                        controller: totalControlled,
                        fieldName: "Total",
                        icon: Icons.attach_money,
                        label: "Total"),
                    sizedBoxVertical10(),
                    TextFields(
                        message: "Please enter the deposit",
                        controller: depositControlled,
                        fieldName: "Deposit",
                        icon: Icons.money,
                        label: "Deposit"),
                    sizedBoxVertical10(),
                    TextFormField(
                      controller: dateController,
                      readOnly: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: const BorderSide(
                              width: 2,
                              style: BorderStyle.none,
                            )),
                        labelText: 'Date',
                        prefixIcon: const Icon(Icons.calendar_today),
                        suffixIcon: IconButton(
                          onPressed: _showDatePicker,
                          icon: const Icon(Icons.date_range),
                        ),
                      ),
                    ),
                    sizedBoxVertical30(),
                    Center(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: primaryColor),
                        onPressed: () async {
                          await register();
                        },
                        child: const Text(
                          'Submit',
                          style: TextStyle(fontSize: 22, color: Colors.white),
                        ),
                      ),
                    ),
                  ]),
                ),
              ),
            ),
          ),
        ));
  }

  register() async {
    if (formKey.currentState!.validate()) {
      showLoading(context, "waiting 🙈  ");
      submitForm();
    }
  }

  submitForm() async {
    var request = http.MultipartRequest('POST',
        Uri.parse('http://203.161.55.254:8009/api/v1/order/client/create'));

    // Add text fields
    request.fields['name'] = userNameControlled.text;
    request.fields['mobile'] = phoneControlled.text;
    request.fields['address'] = addressControlled.text;
    request.fields['total'] = totalControlled.text;
    request.fields['deposit'] = depositControlled.text;
    request.fields['date'] = dateController.text;
    request.fields['quantity'] = quantityControlled.text;

    try {
      // Send the request
      final response = await request.send();

      // Check if the request was successful (status code 2xx)
      if (response.statusCode == 201) {
        showMessage(context, "User Created successfully 🙈 ", "");
        Future.delayed(const Duration(seconds: 1), () async {
          Navigator.pushNamedAndRemoveUntil(
              context, HomeScreen.routeName, (route) => false);
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

  void _showDatePicker() async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2021),
      lastDate: DateTime(2050),
    );
    if (pickedDate == null) return;
    setState(() {
      dateController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
    });
  }
}
