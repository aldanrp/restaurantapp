import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:restaurantsapp/constants/color_materials.dart';
import 'package:restaurantsapp/pages/error_page.dart';
import 'package:restaurantsapp/pages/widgets/GlobalWidgets/list_place.dart';
import 'package:restaurantsapp/providers/restaurant_providers.dart';
import 'package:restaurantsapp/pages/details_page.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import 'package:fluttertoast/fluttertoast.dart';

class Home extends StatefulWidget {
  final bool hasInternet;
  final Future<void> hasconnection;
  const Home({Key? key, required this.hasInternet, required this.hasconnection})
      : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isInit = true;
  String message = "in";
  @override
  void didChangeDependencies() {
    if (isInit && widget.hasInternet == true) {
      try {
        Provider.of<RestaurantData>(context).getRestaurant();
      } catch (e) {
        setState(() {
          message = e.toString();
        });
      }
    }
    isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final allPlaceProvider = Provider.of<RestaurantData>(context);
    return (widget.hasInternet == true)
        ? Scaffold(
            backgroundColor: kWhite,
            body: SafeArea(
              child: Container(
                height: MediaQuery.of(context).size.height,
                margin: const EdgeInsets.only(left: 15, right: 15),
                child: Column(
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.only(
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
                              const Text(
                                "Hi Username",
                                textAlign: TextAlign.start,
                                textDirection: TextDirection.ltr,
                                style: TextStyle(
                                  fontSize: 20,
                                  color: kPrimary,
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              const Text(
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
                                padding: const EdgeInsets.all(10),
                                primary: Colors.black26,
                                backgroundColor: Colors.orange,
                                shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)))),
                            child: Row(
                              children: <Widget>[
                                Container(
                                  padding: const EdgeInsets.all(2),
                                  decoration: BoxDecoration(
                                      color: Colors.black45,
                                      borderRadius: BorderRadius.circular(50)),
                                  child: const Icon(
                                    Icons.add,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                const Text(
                                  '200 Pts',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 17),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                        top: 35,
                        bottom: 15,
                      ),
                      padding: const EdgeInsets.all(10),
                      decoration: const BoxDecoration(
                          color: kGray,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: IntrinsicHeight(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            TextButton(
                              style: TextButton.styleFrom(
                                primary: Colors.white,
                                textStyle: TextStyle(
                                    color: Colors.white.withOpacity(0.4)),
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
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  const Text(
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
                            const VerticalDivider(
                              color: Colors.red,
                              width: 1,
                              thickness: 2,
                              indent: 10,
                              endIndent: 10,
                            ),
                            Container(
                              margin: const EdgeInsets.only(right: 5, left: 5),
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
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    const Text(
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
                            const VerticalDivider(
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
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  const Text(
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
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                    const SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      flex: 3,
                      child: (allPlaceProvider.tempat.isEmpty)
                          ? Align(
                              alignment: Alignment.center,
                              child: (widget.hasInternet == true ||
                                      message != "false")
                                  ? const CircularProgressIndicator()
                                  : Container(
                                      padding: const EdgeInsets.all(10),
                                      child: const Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          "Data tidak dapast ditemukan",
                                          style: TextStyle(
                                            fontSize: 20,
                                            color: kPrimary,
                                          ),
                                        ),
                                      ),
                                    ),
                            )
                          : ListView.builder(
                              itemCount: allPlaceProvider.tempat.length,
                              shrinkWrap: true,
                              physics: const BouncingScrollPhysics(),
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    Future.delayed(
                                            const Duration(milliseconds: 0))
                                        .then((value) async {
                                      String message = "in";
                                      bool _hasinternet = false;
                                      _hasinternet =
                                          await InternetConnectionChecker()
                                              .hasConnection;
                                      if (_hasinternet == true) {
                                        try {
                                          await Provider.of<RestaurantData>(
                                                  context,
                                                  listen: false)
                                              .getRestaurantid(allPlaceProvider
                                                  .tempat[index].id);
                                        } catch (e) {
                                          message = e.toString();
                                        } finally {
                                          if (message != "in") {
                                            Fluttertoast.showToast(
                                              msg: message.toString(),
                                              fontSize: 18,
                                              gravity: ToastGravity.BOTTOM,
                                            );
                                          } else {
                                            var detail =
                                                Provider.of<RestaurantData>(
                                                        context,
                                                        listen: false)
                                                    .detailsresturant;
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    DetailsPage(
                                                        restaurant: detail),
                                              ),
                                            );
                                          }
                                        }
                                      } else {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                UnderConstructor(
                                                    hasconnection:
                                                        widget.hasconnection),
                                          ),
                                        );
                                      }
                                    });
                                  },
                                  child: ListPlace(
                                      restaurantData:
                                          allPlaceProvider.tempat[index]),
                                );
                              },
                            ),
                    ),
                  ],
                ),
              ),
            ),
          )
        : const Scaffold(
            body: SafeArea(
              child: Text("Tidak ada internet"),
            ),
          );
  }
}
