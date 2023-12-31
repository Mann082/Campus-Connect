import 'package:campus_connect/screen/authscreen.dart';
import 'package:campus_connect/screen/selectuser.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class mainDrawer extends StatelessWidget {
  final String title;
  const mainDrawer({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    var padding = MediaQuery.of(context).padding;
    var size = MediaQuery.of(context).size;
    return Drawer(
      child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        Container(
          height: padding.top,
          color: Color.fromARGB(255, 11, 223, 156),
        ),
        Container(
          color: Color.fromARGB(255, 11, 223, 156),
          height: (size.height * 0.3),
          child: Center(
            child: Text(
              "Welcome $title",
              style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        Divider(
          height: 1,
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextButton(
                  onPressed: () {},
                  child: ListTile(
                    leading: Icon(CupertinoIcons.person),
                    title: Text("Profile"),
                  )),
              Divider(
                height: 1,
              ),
              TextButton(
                  onPressed: () {},
                  child: ListTile(
                    leading: Icon(Icons.feedback_outlined),
                    title: Text("Feedback"),
                  )),
              Divider(
                height: 1,
              ),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(selectUserScreen.routeName);
                  },
                  child: ListTile(
                    leading: Icon(Icons.logout),
                    title: Text("Logout"),
                  )),
              Divider(
                height: 1,
              ),
            ],
          ),
        )
      ]),
    );
  }
}
