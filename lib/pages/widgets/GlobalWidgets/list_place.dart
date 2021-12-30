import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:restaurantsapp/constants/color_materials.dart';
import 'package:provider/provider.dart';
import 'package:restaurantsapp/model/restaurant_data.dart';
import 'package:restaurantsapp/providers/database_provider.dart';

class ListPlace extends StatefulWidget {
  final Restaurant restaurantData;
  const ListPlace({
    Key? key,
    required this.restaurantData,
  }) : super(key: key);

  @override
  State<ListPlace> createState() => _ListPlaceState();
}

class _ListPlaceState extends State<ListPlace> {
  final String urlImage = "https://restaurant-api.dicoding.dev/images/medium";

  @override
  Widget build(BuildContext context) {
    String imageid = widget.restaurantData.pictureId;
    return Consumer<DatabaseProvider>(builder: (context, provider, child) {
      return FutureBuilder<bool>(
        future: provider.isBookmarked(widget.restaurantData.id),
        builder: (context, snapshot) {
          var isBookmarked = snapshot.data ?? false;
          return Container(
            height: 120,
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(bottom: 10),
            child: Row(
              children: <Widget>[
                Container(
                  height: 120,
                  width: 100,
                  margin: const EdgeInsets.only(top: 5, bottom: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(
                        image: NetworkImage(
                          "$urlImage/$imageid",
                        ),
                        fit: BoxFit.cover),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.restaurantData.name,
                      style: const TextStyle(
                        fontSize: 20,
                        color: kBlack,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 1.66,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Row(
                            children: [
                              const Icon(
                                CupertinoIcons.location_solid,
                                color: kBlack,
                              ),
                              Text(
                                widget.restaurantData.city,
                                style: const TextStyle(
                                  fontSize: 18,
                                  color: kLightGray,
                                ),
                              ),
                            ],
                          ),
                          IconButton(
                            onPressed: () {
                              if (isBookmarked) {
                                provider
                                    .removeBookmark(widget.restaurantData.id);
                              } else {
                                provider.addBookmark(widget.restaurantData);
                              }
                            },
                            icon: (isBookmarked)
                                ? Icon(
                                    CupertinoIcons.heart_fill,
                                    color: Colors.redAccent.shade700,
                                  )
                                : const Icon(
                                    CupertinoIcons.heart,
                                  ),
                          )
                        ],
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        const Icon(
                          CupertinoIcons.star_fill,
                          color: Colors.orangeAccent,
                          size: 18,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(widget.restaurantData.rating.toString(),
                            style: const TextStyle(
                              color: kBlack,
                              fontSize: 17,
                            ))
                      ],
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      );
    });
  }
}
