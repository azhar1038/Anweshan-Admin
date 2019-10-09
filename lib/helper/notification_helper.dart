import 'dart:convert';

import 'package:http/http.dart';
import 'package:meta/meta.dart';

class NotificationHelper {
  static final Client client = Client();
  static const String serverKey =
      'AAAAR8PjiBU:APA91bHdnD9S4BB1R3Ae-o4eneeWo3zZXoZZ3Unz-R3410ONABlOE_8rodzKs3X9zFKF5W7KU5A33LTbY5naNjd8O5zsD7pDnDsFrebhulUQvWqDADTWiew22nRdhTHm4rtLfPlla9GH';

  static Future<Response> sendToAll({
    @required String title,
    @required String body,
  }) =>
      sendToTopic(title: title, body: body, topic: 'all');

  static Future<Response> sendToTopic(
          {@required String title,
          @required String body,
          @required String topic}) =>
      sendTo(title: title, body: body, fcmToken: '/topics/$topic');

  static Future<Response> sendTo({
    @required String title,
    @required String body,
    @required String fcmToken,
  }) =>
      client.post(
        'https://fcm.googleapis.com/fcm/send',
        body: json.encode({
          'notification': {'body': '$body', 'title': '$title'},
          'priority': 'high',
          'data': {
            'click_action': 'FLUTTER_NOTIFICATION_CLICK',
            'id': '1',
            'status': 'done',
          },
          'to': '$fcmToken',
        }),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'key=$serverKey',
        },
      );
}
