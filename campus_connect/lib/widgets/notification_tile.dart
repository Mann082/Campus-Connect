import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class notificationTile extends StatelessWidget {
  const notificationTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Dismissible(
        direction: DismissDirection.endToStart,
        key: ValueKey("hwllo"),
        background: Container(
          margin: const EdgeInsets.all(5),
          color: Theme.of(context).errorColor,
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.only(right: 20),
          child: const Icon(
            Icons.delete,
            color: Colors.white,
            size: 40,
          ),
        ),
        onDismissed: (direction) {
          // Provider.of<Cart>(context, listen: false).removeItem(productId);
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 3),
          child: Container(
              color: Color.fromARGB(255, 11, 223, 156),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Row(
                  children: [
                    Icon(
                      Icons.bus_alert,
                      size: 35,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Hii student",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 17),
                          ),
                          Text("Your Bus Arriving in 5 min")
                        ])
                  ],
                ),
              )
              // ListTile(
              //   leading: Icon(Icons.bus_alert),
              //   title: Text("Hii student"),
              //   subtitle: Text("Your Bus Arriving in 5 min"),
              // ),
              ),
        ));
  }
}

// Card(
//             elevation: 10,
//             child: ListTile(
//               leading: Icon(Icons.bus_alert),
//               title: Text("Hii student"),
//               subtitle: Text("Your Bus Arriving in 5 min"),
//             ),
//           ),