import 'dart:io';

import 'package:elshorouk_academy_task/shared/constants/sizedbox.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../modules/search.dart';
import '../../modules/textfield.dart';
import '../../shared/colors/colors.dart';
import '../../shared/componnet.dart';

class ClientsDetails extends StatefulWidget {
  int id;
  String name;
  String mobile;
  String address;

  ClientsDetails(this.id, this.name, this.mobile, this.address);

  static const String routeName = "clientsDetails";

  @override
  State<ClientsDetails> createState() => _ClientsDetailsState();
}

ScrollController _controller = ScrollController();
GlobalKey<FormState> formKey = GlobalKey<FormState>();
var totalControlled = TextEditingController();
var dateControlled = TextEditingController();
var depositControlled = TextEditingController();
var clientControlled = TextEditingController();
TextEditingController nameControlled = TextEditingController();
TextEditingController mobileControlled = TextEditingController();
TextEditingController addressControlled = TextEditingController();
final quantityControlled = TextEditingController();

DateTime date = DateTime.now();
DateTime? newDate;
final List<File> images = [];
File? image;

class _ClientsDetailsState extends State<ClientsDetails> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nameControlled.text = widget.name;
    mobileControlled.text = widget.mobile;
    addressControlled.text = widget.address;
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
              // in search bar you can add user and search it by phone number
              title: const Search()),
          body: Container(
            padding: const EdgeInsets.all(20),
            margin: const EdgeInsets.all(20),
            decoration: BoxDecoration(
                color: Colors.green.shade50,
                border: Border.all(),
                borderRadius: const BorderRadius.all(Radius.circular(25))),
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "User Details : ",
                      style: TextStyle(fontSize: 22, color: Colors.indigo),
                    ),
                    sizedBoxVertical20(),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red),
                          onPressed: () async {
                            // you Can here delete user but i comment it because it real data

                            // Delete.deleteClient(widget.id);
                            setState(() {});
                            showMessage(
                                context, "User Deleted Successfully 😜 ", "");
                          },
                          icon: const Icon(
                            Icons.delete_forever_outlined,
                            color: Colors.white,
                          ),
                          label: const Text(
                            'Delete User',
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    sizedBoxVertical20(),
                    TextFields(
                        message: "Please enter the Name",
                        controller: nameControlled,
                        fieldName: "Name",
                        icon: Icons.drive_file_rename_outline,
                        label: "Name"),
                    TextFields(
                        message: "Please enter the mobile",
                        controller: mobileControlled,
                        fieldName: "Mobile",
                        icon: Icons.phone_android,
                        label: "Mobile"),
                    TextFields(
                        message: "Please enter the Address",
                        controller: addressControlled,
                        fieldName: "Address",
                        icon: Icons.home,
                        label: "Address"),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green),
                          onPressed: () async {
                            //here you can update user data and submit it

                            // GetALLClients.updateClient(
                            //     widget.id,
                            //     nameControlled.text,
                            //     mobileControlled.text,
                            //     addressControlled.text);
                            setState(() {});
                            showMessage(context, "User updated  😜 ", "");
                          },
                          icon: const Icon(
                            Icons.update,
                            color: Colors.white,
                          ),
                          label: const Text(
                            'Update User',
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        ),
                      ),
                    ),
                    TextFields(
                        message: "Please enter the Quantity",
                        controller: quantityControlled,
                        fieldName: "Quantity",
                        icon: Icons.onetwothree,
                        label: "Quantity"),
                    TextFields(
                        message: "Please enter the Total",
                        controller: totalControlled,
                        fieldName: "Total",
                        icon: Icons.attach_money,
                        label: "Total"),
                    TextFields(
                        message: "Please enter the deposit",
                        controller: depositControlled,
                        fieldName: "Deposit",
                        icon: Icons.money,
                        label: "Deposit"),
                    TextFormField(
                      controller: dateControlled,
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
                    const SizedBox(
                      height: 20,
                    ),
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
                            depositControlled.clear();
                            totalControlled.clear();
                          },
                          child: const Text(
                            'Done',
                            style: TextStyle(fontSize: 22, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  register() async {
    if (formKey.currentState!.validate()) {
      showLoading(context, "Waiting 🙈  ");
      //submitForm();
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
      dateControlled.text = DateFormat('yyyy-MM-dd').format(pickedDate);
    });
  }
}
