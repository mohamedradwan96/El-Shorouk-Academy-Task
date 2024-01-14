import 'package:flutter/material.dart';

import '../../shared/colors/colors.dart';
import '../home_screens/home.dart';

class StartScreen extends StatelessWidget {
  static const String routeName = " StartScreen";
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          "assets/images/img_3.png",
          fit: BoxFit.cover,
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
        ),
        Center(
          child: SizedBox(
              width: MediaQuery.of(context).size.width / 2,
              height: MediaQuery.of(context).size.height / 10,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                ),
                onPressed: () {
                  Navigator.pushNamed(context, HomeScreen.routeName);
                },
                child: const Text("Start",
                    style: TextStyle(fontSize: 22, color: Colors.white)),
              )),
        ),
      ],
    );
  }
}
