import 'package:elshorouk_academy_task/screens/add_client_screen/add_new_clients.dart';
import 'package:elshorouk_academy_task/screens/history_clients/history_clients.dart';
import 'package:elshorouk_academy_task/screens/home_screens/home.dart';
import 'package:elshorouk_academy_task/screens/orders/orders.dart';
import 'package:elshorouk_academy_task/screens/start/start.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sila System',
      debugShowCheckedModeBanner: false,
      initialRoute: StartScreen.routeName,
      routes: {
        StartScreen.routeName: (context) => StartScreen(),
        HomeScreen.routeName: (context) => HomeScreen(),
        AddNewClients.routeName: (context) => AddNewClients(),
        HistoryClients.routeName: (context) => HistoryClients(),
        Orders.routeName: (context) => Orders(),
      },
    );
  }
}
