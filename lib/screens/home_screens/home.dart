import 'package:flutter/material.dart';

import '../../modules/search.dart';
import '../../shared/colors/colors.dart';
import '../add_client_screen/add_new_clients.dart';
import '../history_clients/history_clients.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "HomeScreen";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/img_3.png"), fit: BoxFit.cover)),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
              iconTheme: const IconThemeData(color: primaryColor, size: 40),
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: const Search()),
          body: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // screen that you can add new user details
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width / 2,
                    height: MediaQuery.of(context).size.height / 8,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: primaryColor,
                            shape: BeveledRectangleBorder(
                                side: BorderSide(color: Colors.black),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(25)))),
                        onPressed: () {
                          Navigator.pushNamed(context, AddNewClients.routeName);
                        },
                        child: const Text(
                          "Add New User",
                          style: TextStyle(fontSize: 22, color: Colors.white),
                        )),
                  ),
                ),

                // screen that you can preview user details

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width / 1.8,
                    height: MediaQuery.of(context).size.height / 8,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: const BeveledRectangleBorder(
                                side: BorderSide(color: Colors.black),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(25))),
                            backgroundColor: primaryColor),
                        onPressed: () {
                          Navigator.pushNamed(
                              context, HistoryClients.routeName);
                        },
                        child: const Text("History of Users",
                            style:
                                TextStyle(fontSize: 22, color: Colors.white))),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
