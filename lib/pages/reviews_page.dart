import 'package:flutter/material.dart';
import 'package:restaurantsapp/constants/color_materials.dart';
import 'package:restaurantsapp/model/restaurantdetails.dart';

class ReviewsPage extends StatelessWidget {
  final Restaurants restaurant;
  const ReviewsPage({Key? key, required this.restaurant}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.arrow_back,
                        color: kBlack,
                      )),
                  Container(
                    margin: const EdgeInsets.only(
                      top: 20,
                    ),
                    height: 72,
                    width: MediaQuery.of(context).size.width / 1.4,
                    child: RichText(
                      text: const TextSpan(
                        text: "Yuk",
                        style: TextStyle(
                            color: kPrimary,
                            fontSize: 25,
                            fontWeight: FontWeight.w600),
                        children: <TextSpan>[
                          TextSpan(
                            text: ', diliat dulu reviews restaurantnya',
                            style: TextStyle(
                              color: kBlack,
                              fontSize: 25,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: restaurant.customerReviews.length,
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(
                        border: Border(
                          top: BorderSide(
                              width: 1,
                              color: kPrimary,
                              style: BorderStyle.solid),
                          bottom: BorderSide(
                              width: 1,
                              color: kPrimary,
                              style: BorderStyle.solid),
                        ),
                      ),
                      padding: const EdgeInsets.only(
                        left: 10,
                        right: 10,
                        top: 5,
                        bottom: 5,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                restaurant.customerReviews[index].name,
                                style: const TextStyle(
                                  fontSize: 20,
                                  color: kPrimary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                restaurant.customerReviews[index].date,
                                style: const TextStyle(
                                  fontSize: 15,
                                  color: kLightGray,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            restaurant.customerReviews[index].review,
                            style: const TextStyle(
                              fontSize: 17,
                              color: kBlack,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
