import 'package:dio/dio.dart';

void sendFCMNotification() async {
  var headers = {
    'Accept': '*/*',
    'User-Agent': 'Thunder Client (https://www.thunderclient.com)',
    'Content-Type': 'application/json',
    'Authorization': 'key=AAAAgLBAT3w:APA91bFuMKhRyNxBB_Y2J-EpXBPaxNlETsVBqfgl5kNhzTVqtnrl7Jq5frWIHIqZ7rHLlRG1uBsa4oyb6pxjqC5lz6zKOIS2m81mxzeoObwkoqc6GpyutRcw6VbmXQwF3QaICk6XELgX'
  };

  var data = {
    "to": "f1IiZntfQrGsA9MzDPKoa6:APA91bFP1Lj0iXB0CLAmd8ut4QU6DaVeXzXCKZlTF3SrXCWKr_yTvSRGld46rAFkqSeyulvt1PlJm4u5fn8g4AhqRiXSTa17njnZinbU6nNYi22SVZ4g34qiH7xErWwMyjTBydSbI4L-",
    "notification": {
      "title": "Hi",
      "body": "AbdElmonem"
    }
  };

  try {
    var dio = Dio();
    dio.options.headers = headers;
    var response = await dio.post('https://fcm.googleapis.com/fcm/send', data: data);

    if (response.statusCode == 200) {
      print(response.data);
    } else {
      print('Failed with status code: ${response.statusCode}');
    }
  } catch (e) {
    print('Error sending FCM notification: $e');
  }
}
