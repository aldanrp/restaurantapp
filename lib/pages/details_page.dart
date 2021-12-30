import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:readmore/readmore.dart';
import 'package:restaurantsapp/constants/color_materials.dart';
import 'package:restaurantsapp/model/restaurantdetails.dart';

class DetailsPage extends StatefulWidget {
  final Restaurants restaurant;

  const DetailsPage({
    Key? key,
    required this.restaurant,
  }) : super(key: key);

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  Widget build(BuildContext context) {
    const String urlImage = "https://restaurant-api.dicoding.dev/images/medium";
    String imageid = widget.restaurant.pictureId;
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
                  image: NetworkImage("$urlImage/$imageid"),
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
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: const BoxDecoration(
                color: kWhite,
              ),
              padding: const EdgeInsets.only(top: 15, left: 10, right: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
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
                          widget.restaurant.name,
                          style: const TextStyle(
                            fontSize: 27,
                            color: kBlack,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const Icon(
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
                        widget.restaurant.city,
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
                      Text(widget.restaurant.rating.toString(),
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
                    widget.restaurant.description,
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
                  const SizedBox(
                    height: 3,
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    child: RaisedButton(
                      onPressed: () {
                        displayModalBottomSheet(
                            context, widget.restaurant.menus);
                      },
                      hoverColor: kGray,
                      padding: const EdgeInsets.all(10),
                      color: kPrimary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Text(
                        'Our Menu',
                        style: TextStyle(
                          fontSize: 15,
                          color: kBlack,
                        ),
                      ),
                    ),
                  ),
                ],
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
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    context: context,
    builder: (BuildContext bc) {
      return Container(
        padding: const EdgeInsets.only(top: 20, left: 5, right: 5),
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
                      fontSize: 20,
                      color: kPrimary.withOpacity(0.8),
                      fontWeight: FontWeight.bold),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: restaurant.foods.map((data) {
                    return Container(
                      padding: const EdgeInsets.all(3),
                      margin: const EdgeInsets.only(top: 5),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.circle,
                            size: 11,
                          ),
                          const SizedBox(width: 3),
                          Text(
                            data.name,
                            style: const TextStyle(
                              fontSize: 15,
                              color: kBlack,
                            ),
                          ),
                        ],
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
                      fontSize: 20,
                      color: kPrimary.withOpacity(0.8),
                      fontWeight: FontWeight.bold),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: restaurant.drinks.map((data) {
                    return Container(
                      margin: const EdgeInsets.only(top: 5, bottom: 5),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.circle,
                            size: 11,
                          ),
                          const SizedBox(
                            width: 3,
                          ),
                          Text(
                            data.name,
                            style: const TextStyle(
                              fontSize: 15,
                              color: kBlack,
                            ),
                          ),
                        ],
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
