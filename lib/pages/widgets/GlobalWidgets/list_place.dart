import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:restaurantsapp/constants/color_materials.dart';

import 'package:restaurantsapp/model/restaurant_data.dart';

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
              const SizedBox(
                height: 10,
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
                    const Icon(CupertinoIcons.heart)
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
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
  }
}
