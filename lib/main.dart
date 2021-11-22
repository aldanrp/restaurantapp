// ignore_for_file: prefer_const_constructors

import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:restaurantsapp/constants/color_materials.dart';
import 'package:restaurantsapp/pages/home.dart';
import 'package:restaurantsapp/pages/SearchPage.dart';
import 'package:restaurantsapp/pages/setting.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'MakanYok',
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int currentIndex = 0;

  void changePage(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  Widget _getWidget() {
    if (currentIndex == 1) {
      return const SearchPage();
    } else if (currentIndex == 2) {
      return const Setting();
    }
    return const Home();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _getWidget(),
      bottomNavigationBar: BottomNavyBar(
        backgroundColor: kWhite,
        containerHeight: 70,
        selectedIndex: currentIndex,
        showElevation: true,
        itemCornerRadius: 24,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        onItemSelected: (index) => setState(() => currentIndex = index),
        items: <BottomNavyBarItem>[
          BottomNavyBarItem(
            icon: const Icon(
              CupertinoIcons.home,
              size: 30,
            ),
            title: Text(
              'Home',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            activeColor: Colors.red,
            inactiveColor: kLightGray,
            textAlign: TextAlign.center,
          ),
          BottomNavyBarItem(
            icon: Icon(
              Icons.search,
              size: 30,
            ),
            title: Text(
              'Search',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            activeColor: Colors.purpleAccent,
            inactiveColor: kLightGray,
            textAlign: TextAlign.center,
          ),
          BottomNavyBarItem(
            icon: Icon(
              Icons.settings,
              size: 30,
            ),
            title: Text(
              'Setting',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            activeColor: Colors.black,
            inactiveColor: kLightGray,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
