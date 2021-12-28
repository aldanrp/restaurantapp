import 'package:flutter/material.dart';

import 'package:restaurantsapp/constants/color_materials.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        body: Text(
          "Seacrh Page",
          style: TextStyle(fontSize: 20, color: kBlack),
        ),
      ),
    );
  }
}