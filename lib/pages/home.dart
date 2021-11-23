// ignore_for_file: file_names, prefer_const_constructors, avoid_print

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:restaurantsapp/constants/color_materials.dart';
import 'package:restaurantsapp/model/restaurant_data.dart';
import 'package:restaurantsapp/pages/widgets/details_page.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhite,
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          margin: EdgeInsets.only(left: 15, right: 15),
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(
                  top: 30,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      // ignore: prefer_const_literals_to_create_immutables
                      children: <Widget>[
                        Text(
                          "Hi Username",
                          textAlign: TextAlign.start,
                          textDirection: TextDirection.ltr,
                          style: TextStyle(
                            fontSize: 20,
                            color: kPrimary,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Welcome back!",
                          style: TextStyle(
                              fontSize: 30,
                              color: kPrimary,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    TextButton(
                      onPressed: () {
                        print("points");
                      },
                      style: TextButton.styleFrom(
                          padding: EdgeInsets.all(10),
                          primary: Colors.black26,
                          backgroundColor: Colors.orange,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)))),
                      child: Row(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.all(2),
                            decoration: BoxDecoration(
                                color: Colors.black45,
                                borderRadius: BorderRadius.circular(50)),
                            child: Icon(
                              Icons.add,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            '200 Pts',
                            style: TextStyle(color: Colors.white, fontSize: 17),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  top: 35,
                  bottom: 15,
                ),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: kGray,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: IntrinsicHeight(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      TextButton(
                        style: TextButton.styleFrom(
                          primary: Colors.white,
                          textStyle:
                              TextStyle(color: Colors.white.withOpacity(0.4)),
                        ),
                        onPressed: () {
                          print("claim");
                        },
                        child: Row(
                          children: <Widget>[
                            Image.asset(
                              'assets/icons/claim_icon.png',
                              width: 25,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              'Claim',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.normal),
                            )
                          ],
                        ),
                      ),
                      VerticalDivider(
                        color: Colors.red,
                        width: 1,
                        thickness: 2,
                        indent: 10,
                        endIndent: 10,
                      ),
                      Container(
                        margin: EdgeInsets.only(right: 5, left: 5),
                        child: TextButton(
                          style: TextButton.styleFrom(
                            primary: Colors.white10,
                          ),
                          onPressed: () {
                            print("get points");
                          },
                          child: Row(
                            children: <Widget>[
                              Image.asset(
                                'assets/icons/point_icon.png',
                                width: 25,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                'Get Points',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.normal),
                              )
                            ],
                          ),
                        ),
                      ),
                      VerticalDivider(
                        color: Colors.red,
                        width: 1,
                        thickness: 2,
                        indent: 10,
                        endIndent: 10,
                      ),
                      TextButton(
                        style: TextButton.styleFrom(
                          primary: Colors.white10,
                        ),
                        onPressed: () {
                          print('my card');
                        },
                        child: Row(
                          children: <Widget>[
                            Image.asset(
                              'assets/icons/card_icon.png',
                              width: 25,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              'Mycard',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.normal),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              //untuk bagian list
              SizedBox(
                height: 10,
              ),
              Expanded(
                flex: 4,
                child: ListView(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "This our recomended",
                              style: TextStyle(
                                fontSize: 19,
                                color: kPrimary.withOpacity(0.7),
                                fontWeight: FontWeight.bold,
                                letterSpacing: 2,
                              ),
                              textAlign: TextAlign.justify,
                            ),
                            Text(
                              "See all",
                              style: TextStyle(
                                fontSize: 19,
                                color: kLightGray.withOpacity(0.8),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 21),
                          height: MediaQuery.of(context).size.height,
                          child: FutureBuilder<String>(
                            future: DefaultAssetBundle.of(context)
                                .loadString('assets/local_restaurant.json'),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                final Restaurant restaurant =
                                    restaurantFromJson(snapshot.data!);
                                var dataRes = restaurant.restaurants;
                                print("$dataRes");
                                return ListView.builder(
                                  itemCount: dataRes.length,
                                  shrinkWrap: true,
                                  physics: BouncingScrollPhysics(),
                                  scrollDirection: Axis.vertical,
                                  itemBuilder: (context, index) {
                                    return _buildRestaurantItem(
                                        context, dataRes[index]);
                                  },
                                );
                              } else {
                                return Text(
                                  "Data engga masuk",
                                  style: TextStyle(fontSize: 20, color: kBlack),
                                );
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildRestaurantItem(
    BuildContext context, RestaurantElement restaurantData) {
  var menu = restaurantData.menus;
  return GestureDetector(
    onTap: () {
      print(restaurantData);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DetailsPage(restaurant: restaurantData),
        ),
      );
    },
    child: SizedBox(
      height: 120,
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: <Widget>[
          Container(
            height: 120,
            width: 100,
            margin: EdgeInsets.only(top: 5, bottom: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              image: DecorationImage(
                  image: NetworkImage(
                    restaurantData.pictureId,
                  ),
                  fit: BoxFit.cover),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Container(
            width: MediaQuery.of(context).size.width / 1.56,
            margin: EdgeInsets.only(top: 3),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  restaurantData.name,
                  style: TextStyle(
                    fontSize: 20,
                    color: kBlack,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 1.55,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(
                            CupertinoIcons.location_solid,
                            color: kBlack,
                          ),
                          Text(
                            restaurantData.city,
                            style: TextStyle(
                              fontSize: 18,
                              color: kLightGray,
                            ),
                          ),
                        ],
                      ),
                      Icon(CupertinoIcons.heart)
                    ],
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  children: <Widget>[
                    Icon(
                      CupertinoIcons.star_fill,
                      color: Colors.orangeAccent,
                      size: 18,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(restaurantData.rating.toString(),
                        style: TextStyle(
                          color: kBlack,
                          fontSize: 17,
                        ))
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
