import 'package:flutter/material.dart';

import 'package:restaurantsapp/constants/color_materials.dart';

class Setting extends StatelessWidget {
  const Setting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        body: Text(
          "Setting page",
          style: TextStyle(
            fontSize: 20,
            color: kBlack,
          ),
        ),
      ),
    );
  }
}
