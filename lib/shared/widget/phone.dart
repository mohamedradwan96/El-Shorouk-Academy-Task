import 'package:flutter/material.dart';

import '../colors/colors.dart';

class PhoneTextFormFiled extends StatelessWidget {
  String label;
  var controlled = TextEditingController();
  String message;

  PhoneTextFormFiled(
      {required this.message, required this.label, required this.controlled});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: TextFormField(
          keyboardType: TextInputType.phone,
          validator: (text) {
            if (text == "" || text == null) {
              return "$message";
            }
          },
          controller: controlled,
          maxLines: 1,
          decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 10, horizontal: 10.0),
              label: Text(label),
              labelStyle: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: labelTextForm,
              ),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: const BorderSide(
                    width: 2,
                    style: BorderStyle.none,
                  )))),
    );
  }
}
