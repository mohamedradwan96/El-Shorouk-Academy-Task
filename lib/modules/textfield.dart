import 'package:flutter/material.dart';

import '../shared/colors/colors.dart';

class TextFields extends StatelessWidget {
  String? fieldName;
  String? message;
  String? label;
  TextEditingController? controller;
  IconData? icon;

  TextFields(
      {this.fieldName, this.message, this.label, this.controller, this.icon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Icon(icon),
          SizedBox(
            width: 5,
          ),
          Text(
            "$fieldName : ",
            style: TextStyle(fontSize: 22),
          ),
          SizedBox(
            width: 5,
          ),
          Expanded(
              child: TextFormField(
                  keyboardType: TextInputType.name,
                  validator: (text) {
                    if (text == "" || text == null) {
                      return message;
                    }
                  },
                  controller: controller,
                  maxLines: 1,
                  decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 10.0),
                      label: Text(label!),
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
                          )))))
        ],
      ),
    );
  }
}
