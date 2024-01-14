import 'package:flutter/material.dart';

import '../../models/allClients/allClientsResponse.dart';
import '../../shared/colors/colors.dart';
import '../clientsDetails/clientsDetails.dart';

class ProductsSearchItems extends StatefulWidget {
  AllClientsResponse searchResult;

  ProductsSearchItems(
    this.searchResult,
  );

  @override
  State<ProductsSearchItems> createState() => _ProductsSearchItemsState();
}

class _ProductsSearchItemsState extends State<ProductsSearchItems> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ClientsDetails(
                        widget.searchResult.id,
                        widget.searchResult.name,
                        widget.searchResult.mobile,
                        widget.searchResult.address,
                      )));
        },
        child: Container(
          padding: const EdgeInsets.all(20),
          margin: const EdgeInsets.all(20),
          decoration: BoxDecoration(
              color: search,
              border: Border.all(),
              borderRadius: const BorderRadius.all(Radius.circular(25))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                children: [
                  const Text(
                    "Name: ",
                    style: TextStyle(fontSize: 20, color: Colors.red),
                  ),
                  Text(widget.searchResult.name,
                      style:
                          const TextStyle(fontSize: 16, color: Colors.black)),
                ],
              ),
              Row(
                children: [
                  const Text(
                    "Phone: ",
                    style: TextStyle(fontSize: 20, color: Colors.red),
                  ),
                  Text(widget.searchResult.mobile,
                      style:
                          const TextStyle(fontSize: 16, color: Colors.black)),
                ],
              ),
              Row(
                children: [
                  const Text(
                    "Address: ",
                    style: TextStyle(fontSize: 20, color: Colors.red),
                  ),
                  Text(widget.searchResult.address,
                      style:
                          const TextStyle(fontSize: 16, color: Colors.black)),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
