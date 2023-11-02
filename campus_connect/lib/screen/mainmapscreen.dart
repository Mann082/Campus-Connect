import 'package:campus_connect/providers/bus_data.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:easy_search_bar/easy_search_bar.dart';
import 'package:geolocator/geolocator.dart';

class mainMapScreen extends StatefulWidget {
  const mainMapScreen({super.key});
  static const routeName = "/mainMapScreen";
  @override
  State<mainMapScreen> createState() => _mainMapScreenState();
}

class _mainMapScreenState extends State<mainMapScreen> {
  late GoogleMapController _controller;

  static const LatLng _center = const LatLng(22.752077, 75.894703);

  final Set<Marker> _markers = {};

  @override
  void initState() {
    // TODO: implement initState
    _lines.add(line);
    super.initState();
  }

  final Polyline line = const Polyline(
      polylineId: PolylineId("Hellow"),
      points: [
        LatLng(22.751399346060058, 75.89455224365582),
        LatLng(22.75106975060967, 75.89613699523274),
        LatLng(22.750655730058394, 75.89783217276977),
        LatLng(22.750410648337983, 75.89892874877832),
        LatLng(22.750025179092514, 75.90032204543097),
        LatLng(22.749623052620553, 75.9022700805192),
        LatLng(22.749425558125466, 75.90337181688544),
        LatLng(22.74912510107005, 75.9058268527678),
        LatLng(22.748554913029714, 75.91050487881331),
        LatLng(22.7477531035836, 75.91568595580405),
        LatLng(22.746889124928664, 75.9196570617584),
        LatLng(22.74648677300961, 75.92185533443654),
        LatLng(22.746332679074857, 75.92262734910567),
        LatLng(22.746031403538005, 75.92411243108369),
        LatLng(22.745457629774986, 75.92715499008777),
        LatLng(22.74519611881449, 75.9286094095639),
        LatLng(22.74524846840096, 75.9290454597885),
        LatLng(22.745643469179683, 75.92928025606327),
        LatLng(22.74611699272995, 75.92934476054127),
        LatLng(22.74906257924257, 75.93015158680477),
        LatLng(22.74985433923621, 75.93038119936244),
        LatLng(22.749900809339337, 75.93112789303206),
        LatLng(22.749780409532057, 75.9323303904495),
        LatLng(22.74963677453613, 75.93399098218077),
        LatLng(22.749626213133354, 75.93430477674495),
        LatLng(22.751871549029477, 75.9344536573957),
        LatLng(22.755289487544065, 75.93471507282695),
        LatLng(22.763100601007032, 75.93535949175579),
        LatLng(22.7712977838463, 75.93592537452103),
        LatLng(22.773081910453868, 75.93596188310038),
        LatLng(22.77760103214275, 75.93591624739453),
        LatLng(22.782440496659973, 75.93578651065714),
        LatLng(22.786448790760527, 75.9358987710764),
        LatLng(22.791829959396534, 75.93638473084827),
        LatLng(22.795081599914862, 75.93664326020495),
        LatLng(22.799422649223537, 75.93686967336554),
        LatLng(22.803746562483102, 75.9370174044434),
        LatLng(22.80756052485081, 75.93714017444833),
        LatLng(22.81026642979885, 75.93733278918974),
        LatLng(22.81346231118344, 75.93754081310011),
        LatLng(22.813697991182075, 75.93740970931584),
        LatLng(22.81646858080185, 75.93757486078114),
        LatLng(22.817644542095817, 75.93760376229092),
        LatLng(22.817766323910224, 75.93810747426008),
        LatLng(22.817808186383786, 75.93899309899277),
        LatLng(22.81776872659756, 75.94104152757116),
        LatLng(22.817892944624337, 75.94247728628756),
        LatLng(22.818031495367073, 75.94336880426319),
        LatLng(22.818133597025575, 75.94409907661887),
        LatLng(22.818743017741053, 75.94391936862044)
      ],
      color: Colors.pinkAccent,
      width: 4);

  final Set<Polyline> _lines = {};

  LatLng _lastMapPosition = _center;
  LatLng _currpos = _center;

  MapType _currentMapType = MapType.normal;
  void _giveployline(String origin, String dest) async {
    final url = Uri.parse(
        "https://routes.googleapis.com/directions/v2:computeRoutes?key=AIzaSyDVR-Yn6k8qa-hTSNUBw-H5sL5sLCiLux4");
    var response = await http.get(url);
  }

  var _searchController = TextEditingController();

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
          title: 'Bus Stop',
        ),
        icon: BitmapDescriptor.defaultMarker,
      ));
    });
  }

  void _centerthemap() async {
    await Geolocator.checkPermission();
    await Geolocator.requestPermission();
    Position curr = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  void _onCameraMove(CameraPosition position) {
    _lastMapPosition = position.target;
  }

  void _onMapCreated(GoogleMapController controller) async {
    _controller = controller;
    Provider.of<Buses>(context, listen: false).fetchBuses();

    // String value = await DefaultAssetBundle.of(context)
    //     .loadString('assets/map_style.json');
    // _controller.setMapStyle(value);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: const Text('Your Selected Bus Route'),
          foregroundColor: Colors.black,
          backgroundColor: Colors.white,
        ),
        body: Stack(
          children: <Widget>[
            GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: _center,
                zoom: 11.0,
              ),
              mapType: _currentMapType,
              polylines: _lines,
              markers: _markers,
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
              onCameraMove: _onCameraMove,
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Align(
                alignment: Alignment.topCenter,
                child: SizedBox(
                  height: 60,
                  width: 360,
                  child: Card(
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: TextField(
                      style: const TextStyle(
                        color: const Color(0xff020202),
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                        letterSpacing: 0.5,
                      ),
                      onChanged: (value) {},
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: const Color(0xfff1f1f1),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none,
                        ),
                        hintText: "Search for Locations",
                        hintStyle: const TextStyle(
                            color: const Color(0xffb2b2b2),
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                            letterSpacing: 0.5,
                            decorationThickness: 6),
                        prefixIcon: const Icon(Icons.search),
                        prefixIconColor: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 90, right: 20),
              child: Align(
                alignment: Alignment.topRight,
                child: Column(
                  children: <Widget>[
                    FloatingActionButton(
                      onPressed: _onMapTypeButtonPressed,
                      materialTapTargetSize: MaterialTapTargetSize.padded,
                      backgroundColor: Colors.green,
                      child: const Icon(Icons.map, size: 36.0),
                    ),
                    SizedBox(height: 16.0),
                    // FloatingActionButton(
                    //   onPressed: _onAddMarkerButtonPressed,
                    //   materialTapTargetSize: MaterialTapTargetSize.padded,
                    //   backgroundColor: Colors.green,
                    //   child: const Icon(Icons.add_location, size: 36.0),
                    // ),
                    // SizedBox(height: 16.0),
                    FloatingActionButton(
                      onPressed: _onAddMarkerButtonPressed,
                      materialTapTargetSize: MaterialTapTargetSize.padded,
                      backgroundColor: Colors.green,
                      child: const Icon(Icons.location_searching_rounded,
                          size: 36.0),
                    ),
                    SizedBox(height: 16.0),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
