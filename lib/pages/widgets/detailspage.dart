// ignore_for_file: file_names, deprecated_member_use, prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:readmore/readmore.dart';
import 'package:restaurantsapp/constants/color_materials.dart';
import 'package:restaurantsapp/model/restaurant_data.dart';

class DetailsPage extends StatelessWidget {
  final RestaurantElement restaurant;

  const DetailsPage(
      {Key? key, required this.restaurant, RestaurantElement? restaurantmodel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(slivers: <Widget>[
          SliverAppBar(
            backgroundColor: kWhite,
            expandedHeight: MediaQuery.of(context).size.height * 0.49,
            flexibleSpace: Container(
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(restaurant.pictureId),
                  fit: BoxFit.cover,
                ),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
            ),
          ),
          SliverList(
              delegate: SliverChildListDelegate([
            Container(
              decoration: const BoxDecoration(
                color: kWhite,
              ),
              child: Container(
                height: MediaQuery.of(context).size.height,
                padding: const EdgeInsets.only(top: 15, left: 10, right: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.only(right: 15, bottom: 5),
                      padding: const EdgeInsets.only(bottom: 5),
                      decoration: const BoxDecoration(
                        border: Border(
                            bottom: BorderSide(width: 2, color: kLightGray)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            restaurant.name,
                            style: const TextStyle(
                              fontSize: 27,
                              color: kBlack,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Icon(
                            CupertinoIcons.heart,
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Icon(
                          CupertinoIcons.location_solid,
                          color: kBlack,
                        ),
                        Text(
                          restaurant.city,
                          style: const TextStyle(
                            fontSize: 18,
                            color: kLightGray,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Icon(
                          CupertinoIcons.star_fill,
                          color: Colors.orangeAccent,
                          size: 18,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(restaurant.rating.toString(),
                            style: const TextStyle(
                              color: kBlack,
                              fontSize: 17,
                            ))
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ReadMoreText(
                      restaurant.description,
                      trimLines: 3,
                      textAlign: TextAlign.justify,
                      trimMode: TrimMode.Line,
                      trimCollapsedText: "Show more",
                      trimExpandedText: "Show less",
                      lessStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Colors.green,
                      ),
                      moreStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Colors.green,
                      ),
                      style: const TextStyle(
                        fontSize: 15,
                        color: kLightGray,
                        fontWeight: FontWeight.normal,
                        letterSpacing: 1,
                        height: 2,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    RaisedButton(
                      onPressed: () {
                        displayModalBottomSheet(context, restaurant.menus);
                      },
                      hoverColor: kGray,
                      padding: EdgeInsets.all(10),
                      color: kPrimary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Text(
                        'Menu',
                        style: TextStyle(
                          fontSize: 15,
                          color: kBlack,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ])),
        ]),
      ),
    );
  }
}

void displayModalBottomSheet(BuildContext context, Menus restaurant) {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext bc) {
      return Container(
        padding: EdgeInsets.only(top: 10, left: 5, right: 5),
        child: GridView.count(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          crossAxisCount: 2,
          childAspectRatio: 4 / 9,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Food Menu",
                  style: TextStyle(
                      fontSize: 18,
                      color: kPrimary.withOpacity(0.8),
                      fontWeight: FontWeight.bold),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: restaurant.foods.map((data) {
                    return Container(
                      padding: EdgeInsets.all(3),
                      margin: EdgeInsets.only(top: 5),
                      child: Text(
                        data.name,
                        style: TextStyle(
                          fontSize: 15,
                          color: kBlack,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Drinks Menu",
                  style: TextStyle(
                      fontSize: 18,
                      color: kPrimary.withOpacity(0.8),
                      fontWeight: FontWeight.bold),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: restaurant.drinks.map((data) {
                    return Container(
                      margin: EdgeInsets.only(top: 5, bottom: 5),
                      child: Text(
                        data.name,
                        style: TextStyle(
                          fontSize: 15,
                          color: kBlack,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ],
        ),
      );
    },
  );
}