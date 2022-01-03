import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:restaurantsapp/constants/color_materials.dart';
import 'package:restaurantsapp/constants/navigation.dart';
import 'package:restaurantsapp/data/db/database_helper.dart';
import 'package:restaurantsapp/data/preferences/preferences_helper.dart';
import 'package:restaurantsapp/model/restaurantdetails.dart';
import 'package:restaurantsapp/pages/details_page.dart';
import 'package:restaurantsapp/pages/error_page.dart';
import 'package:restaurantsapp/pages/favorite_page.dart';
import 'package:restaurantsapp/pages/home_page.dart';
import 'package:restaurantsapp/pages/search_page.dart';
import 'package:restaurantsapp/pages/setting_page.dart';
import 'package:provider/provider.dart';
import 'package:restaurantsapp/providers/database_provider.dart';
import 'package:restaurantsapp/providers/preferences_provider.dart';
import 'package:restaurantsapp/providers/restaurant_providers.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:restaurantsapp/providers/scheduling_provider.dart';
import 'package:restaurantsapp/utils/background_service.dart';
import 'package:restaurantsapp/utils/notification_helper.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final NotificationHelper _notificationHelper = NotificationHelper();
  final BackgroundService _service = BackgroundService();
  _service.initializeIsolate();
  if (Platform.isAndroid) {
    await AndroidAlarmManager.initialize();
  }
  await _notificationHelper.initNotifications(flutterLocalNotificationsPlugin);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => RestaurantData(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => DatabaseProvider(
            databaseHelper: DatabaseHelper(),
          ),
        ),
        ChangeNotifierProvider<SchedulingProvider>(
          create: (_) => SchedulingProvider(),
          child: const SettingsPage(),
        ),
        ChangeNotifierProvider(
          create: (_) => PreferencesProvider(
            preferencesHelper: PreferencesHelper(
              sharedPreferences: SharedPreferences.getInstance(),
            ),
          ),
        ),
      ],
      builder: (context, child) => MaterialApp(
        title: 'MakanYok',
        home: const MyHomePage(),
        debugShowCheckedModeBanner: false,
        navigatorKey: navigatorKey,
        routes: {
          DetailsPage.routeName: (context) => DetailsPage(
                restaurant:
                    ModalRoute.of(context)?.settings.arguments as Restaurants,
              ),
        },
      ),
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
  bool hasInternet = false;
  final NotificationHelper _notificationHelper = NotificationHelper();

  @override
  void initState() {
    super.initState();
    _notificationHelper
        .configureSelectNotificationSubject(DetailsPage.routeName);
    hasconnection();
  }

  void changePage(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  void dispose() {
    selectNotificationSubject.close();
    super.dispose();
  }

  Widget _getWidget(bool hasInternet) {
    if (currentIndex == 1) {
      return SearchPage(
        hasInternet: hasInternet,
        hasconnection: hasconnection(),
      );
    } else if (currentIndex == 2) {
      return Favoritepage(
        hasInternet: hasInternet,
        hasconnection: hasconnection(),
      );
    } else if (currentIndex == 3) {
      return const SettingsPage();
    }
    return Home(
      hasInternet: hasInternet,
      hasconnection: hasconnection(),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (hasInternet == true) {
      return Scaffold(
        body: _getWidget(hasInternet),
        bottomNavigationBar: BottomNavyBar(
          backgroundColor: kWhite,
          containerHeight: 70,
          selectedIndex: currentIndex,
          showElevation: true,
          itemCornerRadius: 24,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          onItemSelected: (index) => setState(() {
            currentIndex = index;
            hasconnection();
          }),
          items: <BottomNavyBarItem>[
            BottomNavyBarItem(
              icon: const Icon(
                CupertinoIcons.home,
                size: 30,
              ),
              title: const Text(
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
              icon: const Icon(
                Icons.search,
                size: 30,
              ),
              title: const Text(
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
              icon: const Icon(
                CupertinoIcons.heart_fill,
                size: 30,
              ),
              title: const Text(
                'Favorite',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              activeColor: Colors.redAccent.shade700,
              inactiveColor: kLightGray,
              textAlign: TextAlign.center,
            ),
            BottomNavyBarItem(
              icon: const Icon(
                Icons.settings,
                size: 30,
              ),
              title: const Text(
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
    } else {
      return Scaffold(
        backgroundColor: Colors.white,
        body: UnderConstructor(hasconnection: hasconnection()),
      );
    }
  }

  Future<void> hasconnection() async {
    bool _hasInternet = await InternetConnectionChecker().hasConnection;
    setState(() {
      hasInternet = _hasInternet;
    });
  }
}
