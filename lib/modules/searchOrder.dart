import 'package:flutter/material.dart';

import '../models/allClients/allClientsResponse.dart';
import '../models/allOrders/allOrders.dart';
import '../screens/search_screen/orderSearchItems.dart';
import '../shared/colors/colors.dart';
import '../shared/network/search/searchManger.dart';

class SearchOrder extends StatelessWidget {
  const SearchOrder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showSearch(context: context, delegate: SearchView());
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        margin: const EdgeInsets.symmetric(vertical: 4),
        height: MediaQuery.of(context).size.height * .08,
        decoration: const BoxDecoration(
            color: search, borderRadius: BorderRadius.all(Radius.circular(35))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text(
              "search Order",
              style: TextStyle(color: Colors.black, fontSize: 16),
            ),
            Icon(Icons.search),
          ],
        ),
      ),
    );
  }
}

class SearchView extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            showResults(context);
          },
          icon: const Icon(
            Icons.search,
            size: 30,
          ))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(
          Icons.clear,
          size: 24,
        ));
  }

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder<List<GetAllOrdersDetails>>(
      future: SearchManger.searchOrder(query),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
              child: CircularProgressIndicator(
                  color: primaryColor, backgroundColor: Colors.red));
        }
        if (snapshot.hasError) {
          print("snapshot.error");
          print(snapshot.error.toString());
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text("Something Went Wrong "),
              ],
            ),
          );
        }

        return Container(
          decoration: const BoxDecoration(
              image:
                  DecorationImage(image: AssetImage("assets/images/img.png"))),
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 20),
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              return OrderSearchItems(snapshot.data![index]);
            },
          ),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white60,
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
          image: AssetImage(
            "assets/images/img.png",
          ),
          fit: BoxFit.cover,
        )),
        child: FutureBuilder<List<AllClientsResponse>>(
          future: SearchManger.getAllClient(query),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                  child: CircularProgressIndicator(
                      color: primaryColor, backgroundColor: Colors.red));
            }
            return ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 20),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    leading: const Icon(Icons.category),
                    title: Text(snapshot.data![index].name),
                    onTap: () {
                      showResults(context);
                    },
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
