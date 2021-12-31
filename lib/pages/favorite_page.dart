import 'package:flutter/material.dart';
import 'package:restaurantsapp/constants/color_materials.dart';
import 'package:restaurantsapp/pages/details_page.dart';
import 'package:restaurantsapp/pages/error_page.dart';
import 'package:restaurantsapp/pages/widgets/GlobalWidgets/list_place.dart';
import 'package:restaurantsapp/providers/database_provider.dart';
import 'package:provider/provider.dart';
import 'package:restaurantsapp/providers/restaurant_providers.dart';
import 'package:restaurantsapp/utils/result_state.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Favoritepage extends StatelessWidget {
  final bool hasInternet;
  final Future<void> hasconnection;
  const Favoritepage(
      {Key? key, required this.hasInternet, required this.hasconnection})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(
                  top: 20,
                ),
                height: 72,
                width: MediaQuery.of(context).size.width / 1.4,
                child: RichText(
                  text: const TextSpan(
                    text: "Nih",
                    style: TextStyle(
                        color: kPrimary,
                        fontSize: 30,
                        fontWeight: FontWeight.w600),
                    children: <TextSpan>[
                      TextSpan(
                        text: ', favorit tempat kamu',
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
              Expanded(
                child: Consumer<DatabaseProvider>(
                  builder: (context, provider, child) {
                    if (provider.state == ResultState.HasData) {
                      return ListView.builder(
                        itemCount: provider.bookmarks.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Future.delayed(const Duration(milliseconds: 0))
                                  .then((value) async {
                                String message = "in";
                                bool _hasinternet = false;
                                _hasinternet = await InternetConnectionChecker()
                                    .hasConnection;
                                if (_hasinternet == true) {
                                  try {
                                    await Provider.of<RestaurantData>(context,
                                            listen: false)
                                        .getRestaurantid(
                                            provider.bookmarks[index].id);
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
                                      var detail = Provider.of<RestaurantData>(
                                              context,
                                              listen: false)
                                          .detailsresturant;
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              DetailsPage(restaurant: detail),
                                        ),
                                      );
                                    }
                                  }
                                } else {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => UnderConstructor(
                                          hasconnection: hasconnection),
                                    ),
                                  );
                                }
                              });
                            },
                            child: ListPlace(
                              restaurantData: provider.bookmarks[index],
                            ),
                          );
                        },
                      );
                    } else {
                      return Container(
                        padding: const EdgeInsets.all(10),
                        child: Align(
                          alignment: Alignment.center,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
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
                      );
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
