import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:restaurantsapp/constants/color_materials.dart';
import 'package:restaurantsapp/model/restaurant_data.dart';
import 'package:restaurantsapp/pages/details_page.dart';
import 'package:restaurantsapp/pages/error_page.dart';
import 'package:restaurantsapp/pages/widgets/GlobalWidgets/list_place.dart';
import 'package:restaurantsapp/pages/widgets/searchwidget/search_widget.dart';
import 'package:restaurantsapp/providers/restaurant_providers.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SearchPage extends StatefulWidget {
  final bool hasInternet;
  final Future<void> hasconnection;
  const SearchPage(
      {Key? key, required this.hasInternet, required this.hasconnection})
      : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<Restaurant> searchdata = [];
  List<Restaurant> searchplaces = [];
  String query = "";
  bool isInit = true;
  @override
  void didChangeDependencies() {
    if (isInit && widget.hasInternet == true) {
      searchdata = searchplaces = Provider.of<RestaurantData>(context).tempat;
    }
    isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return (widget.hasInternet == true)
        ? Scaffold(
            body: SafeArea(
              child: Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.only(
                    left: 10,
                    right: 10,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.only(
                          top: 30,
                        ),
                        height: 75,
                        width: MediaQuery.of(context).size.width,
                        child: RichText(
                          text: const TextSpan(
                            text: "Yuk",
                            style: TextStyle(
                                color: kPrimary,
                                fontSize: 30,
                                fontWeight: FontWeight.w600),
                            children: <TextSpan>[
                              TextSpan(
                                text: ', dicari \ndulu tempatnya',
                                style: TextStyle(
                                  color: kBlack,
                                  fontSize: 30,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      buildSearch(),
                      Expanded(
                        child: (searchplaces.isEmpty)
                            ? Container(
                                padding: const EdgeInsets.all(10),
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: const [
                                      Text(
                                        "Data tidak ditemukan",
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: kPrimary,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              )
                            : ListView.builder(
                                itemCount: searchplaces.length,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  final book = searchplaces[index];
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
                                                .getRestaurantid(book.id);
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
                                    child: ListPlace(restaurantData: book),
                                  );
                                },
                              ),
                      ),
                    ],
                  )),
            ),
          )
        : const Scaffold(
            body: SafeArea(
              child: Text("Tidak ada internet"),
            ),
          );
  }

  Widget buildSearch() => SearchWidget(
        text: query,
        hintText: 'Nama Tempatnya',
        onChanged: searchPlaces,
      );

  Future<void> searchPlaces(String query) async {
    String message = "in";
    bool _hasinternet = false;
    _hasinternet = await InternetConnectionChecker().hasConnection;
    if (_hasinternet == true) {
      try {
        await Provider.of<RestaurantData>(context, listen: false)
            .getSearchRestaurant(query);
      } catch (e) {
        message = e.toString();
      } finally {
        if (message != "in") {
          Fluttertoast.showToast(
            msg: message.toString(),
            fontSize: 18,
            gravity: ToastGravity.BOTTOM,
          );
          final books = searchdata;
          setState(() {
            searchplaces = books;
          });
        } else {
          var detail =
              Provider.of<RestaurantData>(context, listen: false).search;
          final books = detail;
          setState(() {
            searchplaces = books;
          });
        }
      }
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              UnderConstructor(hasconnection: widget.hasconnection),
        ),
      );
    }

    setState(() {
      this.query = query;
    });
  }
}
