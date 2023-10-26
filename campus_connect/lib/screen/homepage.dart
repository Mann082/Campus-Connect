import 'package:campus_connect/screen/Notification_Screen.dart';
import 'package:campus_connect/screen/authscreen.dart';
import 'package:campus_connect/screen/mainmapscreen.dart';
import 'package:campus_connect/widgets/mainDrawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  static const routeName = "/homepage";

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _buses = [
    "Bus 1",
    "Bus 2",
    "Bus 3",
    "Bus 4",
    "Bus 5",
    "Bus 6",
    "Bus 7",
    "Bus 1",
    "Bus 2",
    "Bus 3",
    "Bus 4",
    "Bus 5",
    "Bus 6",
    "Bus 7",
    "Bus 1",
    "Bus 2",
    "Bus 3",
    "Bus 4",
    "Bus 5",
    "Bus 6",
    "Bus 7",
    "Bus 1",
    "Bus 2",
    "Bus 3",
    "Bus 4",
    "Bus 5",
    "Bus 6",
    "Bus 7"
  ];
  var selectedBus = "Select Bus";
  late GoogleMapController mapController;
  // final LatLng _center = const LatLng(45.521563, -122.677433);

  // void _onMapCreated(GoogleMapController controller) {
  //   mapController = controller;
  // }

  late GoogleMapController _controller;

  static const LatLng _center = const LatLng(22.752077, 75.894703);

  final Set<Marker> _markers = {};

  LatLng _lastMapPosition = _center;

  MapType _currentMapType = MapType.normal;

  void _onMapTypeButtonPressed() {
    setState(() {
      _currentMapType = _currentMapType == MapType.normal
          ? MapType.satellite
          : MapType.normal;
    });
  }

  void _onAddMarkerButtonPressed() {
    setState(() {
      _markers.add(Marker(
        // This marker id can be anything that uniquely identifies each marker.
        markerId: MarkerId(_lastMapPosition.toString()),
        position: _lastMapPosition,
        infoWindow: const InfoWindow(
          title: 'Really cool place',
          snippet: 'Piyush Home',
        ),
        icon: BitmapDescriptor.defaultMarker,
      ));
    });
  }

  void _onCameraMove(CameraPosition position) {
    // _lastMapPosition = position.target;
  }

  void _onMapCreated(GoogleMapController controller) async {
    await Geolocator.checkPermission();
    await Geolocator.requestPermission();
    Position curr = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    print(curr);
    _lastMapPosition = LatLng(curr.latitude, curr.longitude);
    _controller = controller;
    // String value = await DefaultAssetBundle.of(context)
    //     .loadString('assets/map_style.json');
    // _controller.setMapStyle(value);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text("Bus Routes"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(NotificationScreen.routeName);
              },
              icon: const Icon(Icons.notifications))
        ],
      ),
      drawer: mainDrawer(),
      backgroundColor: Colors.white,
      body: RefreshIndicator(
        onRefresh: () async {
          setState(() {
            print("hellow");
          });
        },
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Divider(height: 1, color: Colors.black),
              SizedBox(
                height: size.height * 0.01,
              ),
              Center(
                child: Card(
                  elevation: 7,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(33)),
                  child: Container(
                    height: size.height * 0.3,
                    width: MediaQuery.of(context).size.width * 0.95,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Color.fromARGB(255, 11, 223, 156)),
                    child: Column(
                      children: [
                        SizedBox(
                          height: size.height * 0.03,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white),
                          child: DropdownMenu(
                              inputDecorationTheme: InputDecorationTheme(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide: BorderSide(
                                          width: 10, color: Colors.black))),
                              width: size.width * 0.85,
                              hintText: "Select Bus",
                              leadingIcon: Icon(CupertinoIcons.bus),
                              initialSelection: "Please Select",
                              menuStyle: MenuStyle(
                                  backgroundColor:
                                      MaterialStatePropertyAll(Colors.white),
                                  shadowColor:
                                      MaterialStatePropertyAll(Colors.white),
                                  fixedSize: MaterialStatePropertyAll(Size(
                                      size.width * 0.5, size.height * 0.5)),
                                  shape: MaterialStatePropertyAll(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          side: BorderSide(
                                              color: Colors.grey, width: 2)))),
                              onSelected: (String? value) {
                                setState(() {
                                  // print("presssed");
                                  // selectedContact = value!;
                                  // contacts = Provider.of<Groups>(context, listen: false)
                                  //     .returnByName(value.toString());
                                  selectedBus = value!;
                                  print(value);
                                });
                              },
                              // width: double.maxFinite,
                              dropdownMenuEntries: _buses
                                  .map((e) => DropdownMenuEntry(
                                      value: e,
                                      label: e,
                                      leadingIcon: Icon(CupertinoIcons.bus),
                                      style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStatePropertyAll(
                                                  Colors.white))))
                                  .toList()),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text('Selected Bus : $selectedBus'),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    fixedSize: Size(MediaQuery.of(context).size.width * 0.95,
                        size.height * 0.06),
                    backgroundColor: Colors.lightBlue,
                    foregroundColor: Colors.white),
                child: const Text(
                  "View Bus Schedule",
                  style: TextStyle(fontSize: 20),
                ),
              ),
              SizedBox(
                height: size.height * 0.025,
              ),
              Container(
                height: size.height * 0.42,
                width: MediaQuery.of(context).size.width * 0.95,
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  elevation: 20,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Stack(
                        children: <Widget>[
                          GoogleMap(
                            onMapCreated: _onMapCreated,
                            initialCameraPosition: const CameraPosition(
                              target: _center,
                              zoom: 11.0,
                            ),
                            mapType: _currentMapType,
                            markers: _markers,
                            onCameraMove: _onCameraMove,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Align(
                              alignment: Alignment.topRight,
                              child: Column(
                                children: <Widget>[
                                  FloatingActionButton(
                                    onPressed: _onMapTypeButtonPressed,
                                    materialTapTargetSize:
                                        MaterialTapTargetSize.padded,
                                    backgroundColor: Colors.green,
                                    child: const Icon(Icons.map, size: 36.0),
                                  ),
                                  SizedBox(height: 16.0),
                                  FloatingActionButton(
                                    onPressed: _onAddMarkerButtonPressed,
                                    materialTapTargetSize:
                                        MaterialTapTargetSize.padded,
                                    backgroundColor: Colors.green,
                                    child: const Icon(Icons.add_location,
                                        size: 36.0),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context)
                                  .pushNamed(mainMapScreen.routeName);
                            },
                          )
                        ],
                      )),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
