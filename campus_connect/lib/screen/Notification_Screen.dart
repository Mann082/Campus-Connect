import 'package:campus_connect/widgets/notification_tile.dart';
import 'package:flutter/material.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});
  static const routeName = "/notificaionScreen";
  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notifications"),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.menu))],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Divider(
            height: 1,
          ),
          TextButton(onPressed: () {}, child: Text("Clear Items")),
          notificationTile(),
          notificationTile(),
          notificationTile(),
          notificationTile(),
          notificationTile(),
          notificationTile(),
          notificationTile(),
        ],
      ),
    );
  }
}
