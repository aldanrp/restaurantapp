import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:restaurantsapp/constants/color_materials.dart';

class UnderConstructor extends StatelessWidget {
  final Future<void> hasconnection;
  const UnderConstructor({Key? key, required this.hasconnection})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Align(
          alignment: Alignment.center,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 100,
              ),
              Lottie.asset('assets/images/no-internet.json'),
              const SizedBox(
                height: 5,
              ),
              const Text(
                "Oopsiee...",
                style: TextStyle(
                  fontSize: 25,
                  color: kBlack,
                ),
              ),
              const SizedBox(
                height: 3,
              ),
              const Text(
                "Your internet connection are lost ",
                style: TextStyle(
                  fontSize: 15,
                  color: kBlack,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                margin: const EdgeInsets.only(left: 20, right: 20),
                width: MediaQuery.of(context).size.width,
                child: TextButton(
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.only(top: 18, bottom: 18),
                    primary: Colors.black26,
                    backgroundColor: kSecondary,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(50),
                      ),
                    ),
                  ),
                  onPressed: () {
                    hasconnection;
                  },
                  child: const Text(
                    "Refresh",
                    style: TextStyle(
                      color: kWhite,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
