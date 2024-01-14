import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../models/allClients/allClientsResponse.dart';
import '../../modules/search.dart';
import '../../shared/colors/colors.dart';
import '../../shared/componnet.dart';
import '../../shared/network/remote/getAllClients/getAllClients.dart';
import '../clientsDetails/clientsDetails.dart';

class HistoryClients extends StatefulWidget {
  static const String routeName = "HistoryClients";

  @override
  State<HistoryClients> createState() => _HistoryClientsState();
}

class _HistoryClientsState extends State<HistoryClients> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/img_3.png"), fit: BoxFit.cover)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
            iconTheme: const IconThemeData(color: primaryColor, size: 40),
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: const Search()),
        body: Column(
          children: [
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lightBlueAccent),
              onPressed: () async {
                setState(() {});
              },
              icon: const Icon(
                Icons.refresh,
                color: Colors.white,
              ),
              label: const Text(
                'Refresh The User Lists ',
                style: TextStyle(color: Colors.white),
              ),
            ),
            Expanded(
              child: FutureBuilder<List<AllClientsResponse>>(
                future: GetALLClients.getAllClients(),
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
                    print("ERROR");
                    return Center(
                      child: Column(
                        children: [
                          const Text("Something went Wrong"),
                          TextButton(
                              onPressed: () {}, child: const Text("Try Again"))
                        ],
                      ),
                    );
                  }
                  return ListView.builder(
                      itemCount: snapshot.data?.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ClientsDetails(
                                          snapshot.data![index].id,
                                          snapshot.data![index].name,
                                          snapshot.data![index].mobile,
                                          snapshot.data![index].address,
                                        )));
                          },
                          child: Flexible(
                            child: Container(
                              width: MediaQuery.of(context).size.width * .85,
                              padding: const EdgeInsets.all(20),
                              margin: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                  color: search,
                                  border: Border.all(),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(25))),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "User ${index + 1}",
                                    style: const TextStyle(
                                        fontSize: 22, color: Colors.indigo),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            const Text(
                                              "Name: ",
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.red),
                                            ),
                                            Expanded(
                                              child: Text(
                                                  snapshot.data![index].name,
                                                  softWrap: false,
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: const TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.black)),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            const Text("Phone : ",
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.red)),
                                            Expanded(
                                              child: Text(
                                                  snapshot.data![index].mobile,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 1,
                                                  softWrap: false,
                                                  style: const TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.black)),
                                            ),
                                          ],
                                        ),
                                        ElevatedButton.icon(
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.red),
                                          onPressed: () async {
                                            // Function to delete user but i turned of it because it real data
                                            // Delete.deleteClient(
                                            //     snapshot.data![index].id);
                                            setState(() {});
                                            showMessage(
                                                context,
                                                "User Deleted Successfully 😜 ",
                                                "");
                                          },
                                          icon: const Icon(
                                            Icons.delete_forever_outlined,
                                            color: Colors.white,
                                          ),
                                          label: const Text(
                                            'Delete User',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
