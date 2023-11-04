import 'package:campus_connect/providers/auth.dart';
import 'package:campus_connect/providers/bus_data.dart';
import 'package:campus_connect/screen/Notification_Screen.dart';
import 'package:campus_connect/screen/adminScreen.dart';
import 'package:campus_connect/screen/authscreen.dart';
import 'package:campus_connect/screen/driver.dart';
import 'package:campus_connect/screen/drivercontrols.dart';
import 'package:campus_connect/screen/homepage.dart';
import 'package:campus_connect/screen/mainmapscreen.dart';
import 'package:campus_connect/screen/selectuser.dart';
import 'package:campus_connect/screen/signup.dart';
import 'package:campus_connect/splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => Auth(),
        ),
        ChangeNotifierProvider(
          create: (context) => Buses(),
        )
      ],
      child: MaterialApp(
          title: 'Campus Connect',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
                seedColor: const Color.fromARGB(255, 67, 205, 154)),
            primaryColor: Colors.white,
            useMaterial3: true,
            textTheme: GoogleFonts.poppinsTextTheme(
              Theme.of(context).textTheme,
            ),
          ),
          routes: {
            selectUserScreen.routeName: (context) => const selectUserScreen(),
            authScreen.routeName: (context) => const authScreen(),
            HomePage.routeName: (context) => const HomePage(),
            NotificationScreen.routeName: (context) =>
                const NotificationScreen(),
            mainMapScreen.routeName: (context) => const mainMapScreen(),
            driverHome.routeName: (context) => const driverHome(),
            SignUp.routeName: (context) => const SignUp(),
            driverControlsScreen.routeName: (context) =>
                const driverControlsScreen(),
            adminScreen.routeName: (context) => const adminScreen(),
            SplashScreen.routename: (context) => SplashScreen()
          },
          initialRoute: SplashScreen.routename),
    );
  }
}






// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

// void main() => runApp(MyApp());

// class MyApp extends StatefulWidget {
//   @override
//   _MyAppState createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   late GoogleMapController _controller;

//   static const LatLng _center = const LatLng(22.752077, 75.894703);

//   final Set<Marker> _markers = {};

//   LatLng _lastMapPosition = _center;

//   MapType _currentMapType = MapType.normal;

//   void _onMapTypeButtonPressed() {
//     setState(() {
//       _currentMapType = _currentMapType == MapType.normal
//           ? MapType.satellite
//           : MapType.normal;
//     });
//   }

//   void _onAddMarkerButtonPressed() {
//     setState(() {
//       _markers.add(Marker(
//         // This marker id can be anything that uniquely identifies each marker.
//         markerId: MarkerId(_lastMapPosition.toString()),
//         position: _lastMapPosition,
//         infoWindow: const InfoWindow(
//           title: 'Really cool place',
//           snippet: 'Piyush Home',
//         ),
//         icon: BitmapDescriptor.defaultMarker,
//       ));
//     });
//   }

//   void _onCameraMove(CameraPosition position) {
//     _lastMapPosition = position.target;
//   }

//   void _onMapCreated(GoogleMapController controller) async {
//     _controller = controller;
//     String value = await DefaultAssetBundle.of(context)
//         .loadString('assets/map_style.json');
//     _controller.setMapStyle(value);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('Maps Sample App'),
//           backgroundColor: Colors.green[700],
//         ),
//         body: Stack(
//           children: <Widget>[
//             GoogleMap(
//               onMapCreated: _onMapCreated,
//               initialCameraPosition: CameraPosition(
//                 target: _center,
//                 zoom: 11.0,
//               ),
//               mapType: _currentMapType,
//               markers: _markers,
//               onCameraMove: _onCameraMove,
//             ),
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Align(
//                 alignment: Alignment.topRight,
//                 child: Column(
//                   children: <Widget>[
//                     FloatingActionButton(
//                       onPressed: _onMapTypeButtonPressed,
//                       materialTapTargetSize: MaterialTapTargetSize.padded,
//                       backgroundColor: Colors.green,
//                       child: const Icon(Icons.map, size: 36.0),
//                     ),
//                     SizedBox(height: 16.0),
//                     FloatingActionButton(
//                       onPressed: _onAddMarkerButtonPressed,
//                       materialTapTargetSize: MaterialTapTargetSize.padded,
//                       backgroundColor: Colors.green,
//                       child: const Icon(Icons.add_location, size: 36.0),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
