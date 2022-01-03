import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:restaurantsapp/model/restaurant_data.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/subjects.dart';

final selectNotificationSubject = BehaviorSubject<String>();

class NotificationHelper {
  static NotificationHelper? _instance;

  NotificationHelper._internal() {
    _instance = this;
  }

  factory NotificationHelper() => _instance ?? NotificationHelper._internal();

  Future<void> initNotifications(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    var initializationSettingsAndroid =
        const AndroidInitializationSettings('app_icon');

    var initializationSettingsIOS = const IOSInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (String? payload) async {
      if (payload != null) {
        print('notification payload: ' + payload);
      }
      selectNotificationSubject.add(payload ?? 'empty payload');
    });
  }

  Future<String> _base64encodedImage(String url) async {
    final http.Response response = await http.get(Uri.parse(url));
    final String base64Data = base64Encode(response.bodyBytes);
    return base64Data;
  }

  Future<void> showNotification(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
      DataTempat articles) async {
    var _channelId = "1";
    var _channelName = "channel_01";
    var _channelDescription = "dicoding news channel";
    int randomIndex = Random().nextInt(articles.restaurants.length);

    String idgambar = articles.restaurants[randomIndex].pictureId;
    const String urlImage = "https://restaurant-api.dicoding.dev/images/small";
    const String urlBigImage =
        "https://restaurant-api.dicoding.dev/images/medium";

    final String largeIcon = await _base64encodedImage('$urlImage/$idgambar');
    final String bigPicture =
        await _base64encodedImage('$urlBigImage/$idgambar');

    final BigPictureStyleInformation bigPictureStyleInformation =
        BigPictureStyleInformation(
            ByteArrayAndroidBitmap.fromBase64String(
                bigPicture), //Base64AndroidBitmap(bigPicture),
            largeIcon: ByteArrayAndroidBitmap.fromBase64String(largeIcon),
            contentTitle: articles.restaurants[randomIndex].name,
            htmlFormatContentTitle: true,
            summaryText: articles.restaurants[randomIndex].rating.toString(),
            htmlFormatSummaryText: true);
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        _channelId, _channelName,
        channelDescription: _channelDescription,
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'ticker',
        styleInformation: bigPictureStyleInformation);

    var iOSPlatformChannelSpecifics = const IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);

    var titleNotification = "Recommendasi restaurant";
    var titleNews = articles.restaurants[randomIndex].name;

    await flutterLocalNotificationsPlugin.show(
        1, titleNotification, titleNews, platformChannelSpecifics,
        payload: json.encode(articles.toJson()));
  }

  void configureSelectNotificationSubject(String route) {
    selectNotificationSubject.stream.listen(
      (String payload) async {
        var data = DataTempat.fromJson(json.decode(payload));
        var article = data.restaurants[0];
        print(article);
      },
    );
  }
}
