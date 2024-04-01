import 'dart:async';
import 'dart:math' as math;
import 'package:arpan/common/logger.dart';
import 'package:arpan/core/repository/geolocation/bloc/geolocation_bloc.dart';
import 'package:arpan/core/utils/constants/constants.dart';
import 'package:arpan/features/home/bloc/current_location_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:mapmyindia_gl/mapmyindia_gl.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({Key? key}) : super(key: key);

  @override
  _LocationScreen createState() => _LocationScreen();
}

class _LocationScreen extends State<LocationScreen> {
  final Completer<GoogleMapController> _controller = Completer();
  // MapmyIndiaMapController? _controller;
  // static const LatLng sourceLocation = LatLng(45.521563, -122.677433);
  static const LatLng destinationLocation =
      LatLng(21.218373900939955, 81.33756324648857);

  List<LatLng> polylineCoordinates = [];
  late LatLng pointerLatLng = LatLng(0.0, 0.0);
  LatLng _centerPosition = LatLng(0, 0);

  void getPolyPoints(double lat, double lng) async {
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      Constants.google_api_key,
      PointLatLng(lat, lng),
      // PointLatLng(sourceLocation.latitude, sourceLocation.longitude),
      PointLatLng(destinationLocation.latitude, destinationLocation.longitude),
    );

    if (result.points.isNotEmpty) {
      result.points.forEach(
        (PointLatLng point) => polylineCoordinates.add(
          LatLng(point.latitude, point.longitude),
        ),
      );
      setState(() {});
    }
  }

  @override
  void initState() {
    // getPolyPoints();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BlocBuilder<GeolocationBloc, GeolocationState>(
          builder: (context, state) {
            if (state is GeolocationLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is GeolocationLoaded) {
              LatLng sourceLocation =
                  LatLng(state.position.latitude, state.position.longitude);

              List<LatLng> listLatLan = [
                sourceLocation,
                LatLng(21.218014, 81.333340)
              ];

              logger.d(
                  'Location: ${state.position.latitude}, ${state.position.longitude}');
              return BlocBuilder<CurrentLocationBloc, CurrentLocationState>(
                builder: (context, currentState) {
                  return GoogleMap(
                    zoomControlsEnabled: false,
                    myLocationEnabled: true,
                    myLocationButtonEnabled: true,
                    initialCameraPosition: CameraPosition(
                      target: sourceLocation,
                      zoom: 14.0,
                    ),
                    onMapCreated: (GoogleMapController controller) {
                      _controller.complete(controller);
                    },
                    onCameraMove: (CameraPosition position) {
                      setState(() {
                        logger.e('Position: ${position}');
                        BlocProvider.of<CurrentLocationBloc>(context)
                            .add(GetTheCurrentLocation(position.target));
                      });
                      getPolyPoints(sourceLocation.latitude, sourceLocation.longitude);
                    },
                    
                    polylines: {
                      Polyline(
                        polylineId: PolylineId('route'),
                        points: polylineCoordinates,
                      )
                    },

                    markers: {
                      Marker(
                        markerId: MarkerId('center_position'),
                        position: currentState.currentLocation,
                        icon: BitmapDescriptor.defaultMarkerWithHue(
                            BitmapDescriptor.hueGreen),
                      ),
                      Marker(
                          markerId: MarkerId('source'),
                          position: sourceLocation,
                          icon: BitmapDescriptor.defaultMarkerWithHue(
                              BitmapDescriptor.hueRed)),
                      Marker(
                          markerId: MarkerId('desitination'),
                          position:
                              LatLng(21.218373900939955, 81.33756324648857),
                          icon: BitmapDescriptor.defaultMarkerWithHue(
                              BitmapDescriptor.hueRed)),
                    },

                    // polylines: Polyline(polylineId: polylineId),
                    // onMapCreated: (controller) async {
                    //   _controller = controller;
                    //   // _controller!.
                    //   _controller!
                    //       .addSymbol(SymbolOptions(geometry: sourceLocation));
                    //   // _controller!.addLine(LineOptions(
                    //   //     geometry: listLatLan, lineColor: "#3bb2d0", lineWidth: 4));
                    // },
                    // onCameraIdle: () async {
                    //   if (_controller != null) {
                    //     final RenderBox renderBox =
                    //         context.findRenderObject() as RenderBox;
                    //     final center = renderBox.size.center(Offset.zero);
                    //     final centerPoint = math.Point(center.dx, center.dy);
                    //     final centerLatLng =
                    //         await _controller!.toLatLng(centerPoint);
                    //     setState(() {
                    //       pointerLatLng = centerLatLng;
                    //       logger.e('Pointer: $pointerLatLng');
                    //     });
                    //   }
                    // },
                  );
                },
              );
              // return Expanded(
              //   child: MapmyIndiaMap(
              //     myLocationEnabled: true,
              //     initialCameraPosition:
              //         CameraPosition(target: sourceLocation, zoom: 14.0),
              //   ),
              // );
            } else {
              return Center(
                child: Text('Something Went Wrong...'),
              );
            }
          },
        ),

        // Positioned(
        //   // Position the pointer widget at the center of the screen
        //   left: MediaQuery.of(context).size.width / 2 -
        //       16, // Adjust based on pointer size
        //   top: MediaQuery.of(context).size.height / 2 -
        //       16 -
        //       150, // Adjust based on pointer size
        //   child: GestureDetector(
        //     // Gesture detector to enable dragging
        //     onPanUpdate: (details) async {
        //       // Convert the global position of the pointer to LatLng
        //       pointerLatLng = await _controller!.toLatLng(
        //         math.Point(
        //             details.globalPosition.dx, details.globalPosition.dy),
        //       );

        //       setState(() {
        //         // Update the position of the pointer
        //         pointerLatLng = pointerLatLng;
        //       });
        //     },
        //     child: Icon(
        //       Icons.pin_drop,
        //       color: Colors.green[900],
        //     ),
        //   ),
        // ),
        // Positioned(
        //     right: 20,
        //     bottom: 30,
        //     child: BlocBuilder<GeolocationBloc, GeolocationState>(
        //       builder: (context, state) {
        //         return InkWell(
        //           onTap: () {
        //             if (_controller != null && state is GeolocationLoaded) {
        //               _controller!.animateCamera(
        //                 CameraUpdate.newCameraPosition(
        //                   CameraPosition(
        //                     target: LatLng(state.position.latitude,
        //                         state.position.longitude),
        //                     zoom: 14.0,
        //                   ),
        //                 ),
        //               );
        //             }
        //             // _controller!.animateCamera(
        //             //   CameraUpdate.newCameraPosition(
        //             //     CameraPosition(
        //             //       target: sourceLocation,
        //             //       zoom: 14.0,
        //             //     ),
        //             //   ),
        //             // );
        //           },
        //           child: Container(
        //             padding: EdgeInsets.all(10),
        //             decoration: BoxDecoration(
        //               color: Colors.white,
        //               borderRadius: BorderRadius.circular(100),
        //             ),
        //             child: Icon(
        //               Icons.my_location,
        //               color: Colors.black,
        //             ),
        //           ),
        //         );
        //       },
        //     ))
      ],
    );
  }
}
