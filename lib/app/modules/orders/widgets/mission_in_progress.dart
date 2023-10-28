import 'package:delivery_emissary/app/modules/orders/widgets/token.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery_emissary/app/core/models/order_model.dart';
import 'package:delivery_emissary/app/core/models/time_model.dart';
import 'package:delivery_emissary/app/modules/main/main_store.dart';
import 'package:delivery_emissary/app/shared/color_theme.dart';
import 'package:delivery_emissary/app/shared/overlays.dart';
import 'package:delivery_emissary/app/shared/utilities.dart';
import 'package:delivery_emissary/app/shared/widgets/ball.dart';
import 'package:delivery_emissary/app/shared/widgets/center_load_circular.dart';
import 'package:delivery_emissary/app/shared/widgets/default_app_bar.dart';
import 'package:delivery_emissary/app/shared/widgets/floating_circle_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:syncfusion_flutter_maps/maps.dart';
import '../orders_store.dart';

class MissionInProgress extends StatefulWidget {
  final String orderId;
  MissionInProgress({Key? key, required this.orderId,})
      : super(key: key);

  @override
  _MissionInProgressState createState() => _MissionInProgressState();
}

class _MissionInProgressState extends State<MissionInProgress> {
  final MainStore mainStore = Modular.get();
  final OrdersStore store = Modular.get();

  @override
  void initState() {
    store.zoomPanBehavior = MapZoomPanBehavior(
      zoomLevel: 15,
      minZoomLevel: 5,
      enableDoubleTapZooming: true,
      maxZoomLevel: 18,
      // focalLatLng: MapLatLng(-15.787763, -48.008072),
      
    );

    store.mapTileLayerController = MapTileLayerController();
    // store.addOrderListen(context);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  String getEstimate() {
    return TimeModel()
        .hour(Timestamp.fromDate(DateTime.now().add(Duration(hours: 2))));
  }

  String getOrderCode(String id) {
    return id.substring(id.length - 4, id.length).toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if(store.inNavigation){
          store.inNavigation = false;
          // store.mapCircle = null;
          store.circle = null;
          return false;
        }
        // if (store.getInNavigationMap()) {
        //   store.inNavigationMap = false;
        //   return false;
        // }
        if(mainStore.globalOverlay != null){
          if(mainStore.globalOverlay!.mounted){
            mainStore.globalOverlay!.remove();
            mainStore.globalOverlay = null;
            return false;
          }
        }
        store.hasArrived = false;
        // store.delivryng = false;
        return store.canBack;
      },
      child: Scaffold(
        body: Stack(  
          children: [
            StreamBuilder<DocumentSnapshot>(
              stream: FirebaseFirestore.instance.collection('orders').doc(widget.orderId).snapshots(),
              builder: (context, snapshot) {
                if(snapshot.hasError){
                  print(snapshot.error);
                }
                if(!snapshot.hasData){
                  return CenterLoadCircular();
                }

                DocumentSnapshot orderDoc = snapshot.data!;
                print('orderDoc.id: ${orderDoc.id}');
                return Stack(
                  children: [
                    SingleChildScrollView(
                      padding: EdgeInsets.only(top: wXD(50, context)),
                      scrollDirection: Axis.vertical,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // OrderHeaderGoogleMap(),                              
                          SizedBox(height: wXD(231, context)),
                          SendDeliveryMessage(
                            orderDoc: orderDoc,
                          ),
                          orderDoc['status'] != "SENDED"
                              ? PickUpProducts(
                                agentToken: orderDoc['agent_token'].toUpperCase(),
                                orderId: widget.orderId,
                              )
                              : DeliverProducts(
                                orderModel: Order.fromDoc(orderDoc),
                              ),
                          MissionSideButton(
                            agentStatus: orderDoc['agent_status'],
                          ),
                          Observer(
                            builder: (context) => Visibility(
                              visible: store.secondsToCancel != 0,
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      right: wXD(21, context)),
                                  child: TextButton(
                                    onPressed: () {
                                      store.cancelOrder(context);
                                    },
                                    child: Text(
                                      "Cancelar corrida ${store.secondsToCancel}s",
                                      style: textFamily(
                                        fontSize: 12,
                                        color: primary,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),       
                    // Positioned(
                    //   top: wXD(263, context),
                    //   right: wXD(28, context),
                    //   child: GestureDetector(
                    //     onTap: () {
                    //       store.inNavigationMap = !store.inNavigationMap;
                    //     },
                    //     child: Container(
                    //       height: wXD(37, context),
                    //       width: wXD(37, context),
                    //       decoration: BoxDecoration(
                    //         shape: BoxShape.circle,
                    //         color: primary,
                    //       ),
                    //       alignment: Alignment.center,
                    //       child: SvgPicture.asset(
                    //         "./assets/svg/turn_right.svg",
                    //         height: wXD(21, context),
                    //         width: wXD(21, context),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    // Observer(
                    //   builder: (context) {
                    //     return AnimatedPositioned(
                    //       right: store.inNavigationMap ? 0 : -maxWidth(context),
                    //       curve: Curves.ease,
                    //       duration: Duration(milliseconds: 400),
                    //       child: getNavigationMap(Order.fromDoc(orderDoc)),
                    //     );
                    //   }
                    // ),                    
                    Observer(
                      builder: (context) {
                        print('observer externo');
                        return Positioned(
                          top: store.inNavigation ? wXD(50, context) : wXD(50, context),
                          child: AnimatedContainer(
                            height: store.inNavigation ? maxHeight(context) : wXD(231, context),
                            width: maxWidth(context),
                            duration: Duration(milliseconds: 400),
                            child: ExpensiveGoogleMaps(
                              orderModel: Order.fromDoc(orderDoc),
                            ),
                          ),
                        );
                      }
                    ),
                    Observer(
                      builder: (context) {
                        return !store.inNavigation ?
                        Positioned(
                          top: wXD(263, context),
                          right: wXD(28, context),
                          child: GestureDetector(
                            onTap: () {
                              store.scrollingOSMap = false;
                              store.scrollingGoogleMap = false;
                              store.inNavigation = true;
                            },
                            child: Container(
                              height: wXD(37, context),
                              width: wXD(37, context),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: primary,
                              ),
                              alignment: Alignment.center,
                              child: SvgPicture.asset(
                                "./assets/svg/turn_right.svg",
                                height: wXD(21, context),
                                width: wXD(21, context),
                              ),
                            ),
                          ),
                        ) : Container();
                      }
                    ),
                    Observer(
                      builder: (context) {
                        return store.destinyDirectionOSMap == null && store.info == null
                        ? Container() :
                        AnimatedPositioned(
                          width: maxWidth(context),
                          bottom: store.inNavigation ? 40 : -wXD(100, context),
                          curve: Curves.ease,
                          duration: Duration(milliseconds: 400),
                          child: Container(
                            margin: 
                                EdgeInsets.symmetric(horizontal: wXD(70, context)),
                            height: wXD(30, context),
                            padding:
                                EdgeInsets.symmetric(horizontal: wXD(10, context)),
                            decoration: BoxDecoration(
                              color: white,
                              borderRadius: BorderRadius.all(Radius.circular(22)),
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 5,
                                  offset: Offset(0, 3),
                                  color: totalBlack.withOpacity(.3),
                                )
                              ],
                            ),
                            alignment: Alignment.center,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  store.destinyDirectionOSMap != null ?
                                  store.destinyDirectionOSMap!.totalDistance :
                                  store.info!.totalDistance,
                                  style: textFamily(fontSize: 15, color: grey),
                                ),
                                SizedBox(width: wXD(20, context)),
                                Text(
                                  store.destinyDirectionOSMap != null ?
                                  store.destinyDirectionOSMap!.totalDuration :
                                  store.info!.totalDuration,                                  
                                  style: textFamily(fontSize: 15, color: grey),
                                ),
                              ],
                            ),
                          ),
                        );
                      }
                    ),
                    Observer(
                      builder: (context) {
                        return store.inNavigation && store.destinyDirectionOSMap != null || store.info != null ? 
                        Positioned(
                          right: wXD(20, context),
                          bottom: wXD(60, context),
                          child: FloatingCircleButton(
                            size: wXD(60, context),
                            onTap: () {
                              store.setCurrentLocation();
                            },
                            child: Icon(
                              Icons.my_location,
                              size: wXD(25, context),
                              color: white,
                            ),
                          ),
                        ) : Container();
                      }
                    ),
                  ],
                );
              }
            ),            
            DefaultAppBar(
              "Missão em andamento",
              onPop: () {
                // if (store.getInNavigationMap()) {
                //   store.inNavigationMap = false;
                //   store.mapCircle = null;
                // } else 
                if(store.inNavigation){
                  store.inNavigation = false;
                } else if (store.canBack) {
                  store.hasArrived = false;
                  // store.delivryng = false;
                  Modular.to.pop();
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  // Widget getNavigationMap(Order _orderModel) {    
  //   return Stack(
  //     alignment: Alignment.bottomCenter,
  //     children: [
  //       Listener(
  //         onPointerMove: (ev) {
  //           if (!store.scrollingMap) {
  //             store.scrollingMap = true;
  //           }
  //         },
  //         child: Container(
  //           height: maxHeight(context),
  //           width: maxWidth(context),
  //           child: GoogleMap(
  //             padding: EdgeInsets.only(top: hXD(333.5, context)),
  //             initialCameraPosition: CameraPosition(
  //               target: LatLng(
  //                 mainStore.agentMap["position"]["latitude"],
  //                 mainStore.agentMap["position"]["longitude"],
  //               ),
  //               zoom: 18,
  //             ),
  //             circles:
  //                 Set.of(store.circle != null ? [store.circle!] : []),
  //             markers: {
  //               if (store.location != null) store.location!,
  //               if (store.destination != null) store.destination!,
  //             },
  //             onTap: (latLng) {
  //               print("######## onTaaaaaaaaaaapp ########");
  //             },
  //             onLongPress: (latLng) {
  //               print("######## onLoooooooooongTaaaaaaaaaaapp ########");
  //             },
  //             onMapCreated: (controller) =>
  //                 store.navigationMapController = controller,
  //             mapToolbarEnabled: false,
  //             zoomControlsEnabled: false,
  //             buildingsEnabled: false,
  //             polylines: {
  //               if (store.info != null)
  //                 Polyline(
  //                     polylineId: PolylineId("navigation_polyline"),
  //                     color: primary,
  //                     width: 5,
  //                     points: store.info!.polylinePoints
  //                         .map((e) => LatLng(e.latitude, e.longitude))
  //                         .toList())
  //             },
  //           ),
  //         ),
  //       ),
  //       Listener(
  //         onPointerMove: (ev) {
  //           print("ev: ${ev.localDelta}");
  //         },
  //         onPointerDown: (event) => print("event: ${event.localDelta}"),
  //         child: Container(
  //           height: maxHeight(context),
  //           width: maxWidth(context),
  //         ),
  //       ),
  //       store.info == null
  //           ? Container()
  //           : AnimatedPositioned(
  //               bottom: store.inNavigationMap ? 40 : -wXD(100, context),
  //               curve: Curves.ease,
  //               duration: Duration(milliseconds: 400),
  //               child: Container(
  //                 // width: wXD(100, context),
  //                 height: wXD(30, context),
  //                 padding:
  //                     EdgeInsets.symmetric(horizontal: wXD(10, context)),
  //                 decoration: BoxDecoration(
  //                   color: white,
  //                   borderRadius: BorderRadius.all(Radius.circular(22)),
  //                   boxShadow: [
  //                     BoxShadow(
  //                       blurRadius: 5,
  //                       offset: Offset(0, 3),
  //                       color: totalBlack.withOpacity(.3),
  //                     )
  //                   ],
  //                 ),
  //                 alignment: Alignment.center,
  //                 child: Row(
  //                   mainAxisAlignment: MainAxisAlignment.center,
  //                   children: [
  //                     Text(
  //                       store.info!.totalDistance,
  //                       style: textFamily(fontSize: 15, color: grey),
  //                     ),
  //                     SizedBox(width: wXD(20, context)),
  //                     Text(
  //                       store.info!.totalDuration,
  //                       style: textFamily(fontSize: 15, color: grey),
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //             ),
  //       Positioned(
  //         right: wXD(20, context),
  //         bottom: wXD(60, context),
  //         child: FloatingCircleButton(
  //           size: wXD(60, context),
  //           onTap: () => store.getMarkers(context, _orderModel),
  //           child: Icon(
  //             Icons.my_location,
  //             size: wXD(25, context),
  //             color: white,
  //           ),
  //         ),
  //       ),
  //     ],
  //   );
  // }
}

class SendDeliveryMessage extends StatelessWidget {
  final DocumentSnapshot orderDoc;
  SendDeliveryMessage({Key? key, required this.orderDoc}) : super(key: key);

  final OrdersStore store = Modular.get();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        store.sendMessage(orderDoc);
      },
      child: Padding(
        padding:
            EdgeInsets.only(bottom: wXD(15, context), top: wXD(15, context)),
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.only(
                  left: wXD(30, context), right: wXD(3, context)),
              child: Icon(
                Icons.email_outlined,
                color: primary,
                size: wXD(20, context),
              ),
            ),
            Text(
              'Enviar uma mensagem',
              style: textFamily(
                fontSize: 14,
                color: primary,
              ),
            ),
            Spacer(),
            Padding(
              padding: EdgeInsets.only(right: wXD(14, context)),
              child: Icon(
                Icons.arrow_forward,
                color: primary,
                size: wXD(20, context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DeliverProducts extends StatefulWidget {
  final Order orderModel;
  const DeliverProducts({
    Key? key, 
    required this.orderModel, 
  }) : super(key: key);

  @override
  _DeliverProductsState createState() => _DeliverProductsState();
}

class _DeliverProductsState extends State<DeliverProducts> {
  final OrdersStore store = Modular.get();
  String getEstimate(num _seconds) {
    return TimeModel().hour(Timestamp.fromDate(DateTime.now().add(Duration(seconds: _seconds.toInt()))));
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: wXD(356, context),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(width: wXD(28, context)),
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 8.0),
                    child: SvgPicture.asset("./assets/svg/check_orange.svg"),
                  ),
                  ...List.generate(
                    2,
                    (index) => Ball(),
                  ),
                  Ball(
                    size: wXD(14, context),
                    color: primary,
                    shape: BoxShape.rectangle,
                    bottom: 5,
                  ),
                ],
              ),
              SizedBox(width: wXD(36, context)),
              Observer(
                builder: (context) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Parada 1",
                        style: textFamily(
                          fontSize: 16,
                          color: textOrange,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(height: wXD(27, context)),
                      Text(
                        "Parada 2",
                        style: textFamily(
                          fontSize: 16,
                          color: textBlack,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(height: wXD(6, context)),
                      Text(
                        store.customerUsername,
                        style: textFamily(
                          fontSize: 16,
                          color: primary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: wXD(6, context)),
                      Text(
                        store.destinyDirectionOSMap != null ?
                        "Chegada estimada ${getEstimate(store.destinyDirectionOSMap!.durationValue)}" :
                        store.info != null ?
                        "Chegada estimada ${getEstimate(store.info!.durationValue)}" :
                        "",
                        style: textFamily(
                          fontSize: 16,
                          color: textBlack,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(height: wXD(6, context)),
                      // PaymentMethod(),
                      // SizedBox(height: wXD(6, context)),
                      Text(
                        "Endereço:",
                        style: textFamily(
                          fontSize: 12,
                          color: darkGrey,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(height: wXD(3, context)),
                      Container(
                        width: wXD(250, context),
                        child: Text(
                          store.destinyAddress != null ?
                          store.destinyAddress!.formatedAddress! : 
                          "",
                          style: textFamily(
                            fontSize: 14,
                            color: textBlack,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      store.destinyAddress != null && store.destinyAddress!.addressComplement != null ?
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: wXD(7, context)),
                          Text(
                            "Referência:",
                            style: textFamily(
                              fontSize: 12,
                              color: darkGrey,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(height: wXD(3, context)),
                          Text(
                            store.destinyAddress!.addressComplement!,
                            style: textFamily(
                              fontSize: 14,
                              color: textBlack,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ) : Container(),
                      SizedBox(height: wXD(7, context)),
                      Text(
                        "Entregar o pedido:",
                        style: textFamily(
                          fontSize: 12,
                          color: darkGrey,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(height: wXD(3, context)),
                      Text(
                        widget.orderModel.code!.toUpperCase(),
                        style: textFamily(
                          fontSize: 14,
                          color: textBlack,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  );
                }
              ),
            ],
          ),
        ),
        Positioned(
          bottom: wXD(21, context),
          right: 0,
          child: GestureDetector(
            onTap: () {
              store.phoneCallWithCustomer(widget.orderModel);
              // store.confirmProduct(context);
            },
            child: Container(
              height: wXD(50, context),
              width: wXD(50, context),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: primary,
              ),
              alignment: Alignment.center,
              child: Icon(
                Icons.phone,
                size: wXD(32, context),
                color: white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class PickUpProducts extends StatefulWidget {
  final String agentToken, orderId;
  const PickUpProducts({
    Key? key, 
    required this.agentToken,
    required this.orderId,
  }) : super(key: key);

  @override
  _PickUpProductsState createState() => _PickUpProductsState();
}

class _PickUpProductsState extends State<PickUpProducts> {
  final OrdersStore store = Modular.get();

  String getEstimate() {
    return TimeModel()
        .hour(Timestamp.fromDate(DateTime.now().add(Duration(hours: 2))));
  }

  String getOrderCode(String id) {
    return id.substring(id.length - 4, id.length).toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      return Column(
        children: [
          Token(widget.agentToken),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(width: wXD(28, context)),
              Column(
                children: [
                  Ball(
                    size: wXD(14, context),
                    color: primary,
                    shape: BoxShape.rectangle,
                    bottom: 5,
                  ),
                  ...List.generate(
                    store.hasArrived ? 18 : 11,
                    (index) => Ball(),
                  ),
                  Ball(
                    size: wXD(14, context),
                    color: lightGrey.withOpacity(.8),
                    shape: BoxShape.rectangle,
                    bottom: 5,
                  ),
                ],
              ),
              SizedBox(width: wXD(36, context)),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Parada 1",
                    style: textFamily(
                      fontSize: 16,
                      color: textBlack,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: wXD(6, context)),
                  Text(
                    store.storeName,
                    style: textFamily(
                      fontSize: 16,
                      color: primary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: wXD(6, context)),
                  Text(
                    "Chegada estimada ${getEstimate()}",
                    style: textFamily(
                      fontSize: 16,
                      color: textBlack,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: wXD(7, context)),
                  Text(
                    "Endereço:",
                    style: textFamily(
                      fontSize: 12,
                      color: darkGrey,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: wXD(4, context)),
                  Container(
                    width: wXD(250, context),
                    child: Text(
                      store.destinyAddress != null ?
                      store.destinyAddress!.formatedAddress! :
                      "",
                      style: textFamily(
                        fontSize: 14,
                        color: textBlack,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  SizedBox(height: wXD(12, context)),
                  store.hasArrived
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Coletar o pedido:",
                              style: textFamily(
                                fontSize: 12,
                                color: darkGrey,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            SizedBox(height: wXD(4, context)),
                            Text(
                              getOrderCode(widget.orderId),
                              style: textFamily(
                                fontSize: 14,
                                color: textBlack,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            // SizedBox(height: wXD(12, context)),
                            // Text(
                            //   "Token do pedido:",
                            //   style: textFamily(
                            //     fontSize: 12,
                            //     color: darkGrey,
                            //     fontWeight: FontWeight.w400,
                            //   ),
                            // ),
                            // SizedBox(height: wXD(4, context)),
                            // Text(
                            //   token,
                            //   style: textFamily(
                            //     fontSize: 14,
                            //     color: textBlack,
                            //     fontWeight: FontWeight.w400,
                            //   ),
                            // ),
                          ],
                        )
                      : Container(),
                  SizedBox(height: wXD(13, context)),
                  Text(
                    "Parada: 2",
                    style: textFamily(
                      fontSize: 16,
                      color: textBlack.withOpacity(.6),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      );
    });
  }
}

// class OrderHeaderGoogleMap extends StatefulWidget {
//   @override
//   _OrderHeaderGoogleMapState createState() => _OrderHeaderGoogleMapState();
// }

// class _OrderHeaderGoogleMapState extends State<OrderHeaderGoogleMap> {
//   final OrdersStore store = Modular.get();
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: wXD(231, context),
//       width: maxWidth(context),
//       child: Observer(
//         builder: (context) {
//           return GoogleMap(
//             initialCameraPosition: CameraPosition(
//               target: LatLng(-15.787763, -48.008072),
//               zoom: 11.5,
//             ),
//             myLocationButtonEnabled: true,
//             scrollGesturesEnabled: false,
//             zoomControlsEnabled: false,
//             onMapCreated: (controller) =>
//                 store.googleMapController = controller,
//             markers: {
//               if (store.location != null) store.location!,
//               if (store.destination != null) store.destination!,
//             },
//             polylines: {
//               if (store.info != null)
//                 Polyline(
//                     polylineId: PolylineId("overview_polyline"),
//                     color: Colors.red,
//                     width: 5,
//                     points: store.info!.polylinePoints
//                         .map((e) => LatLng(e.latitude, e.longitude))
//                         .toList())
//             },
//           );
//         },
//       ),
//     );
//   }
// }

class ExpensiveGoogleMaps extends StatefulWidget {
  final Order orderModel;

  const ExpensiveGoogleMaps({
    Key? key,
    required this.orderModel, 
  }) : super(key: key);
  @override
  _ExpensiveGoogleMapsState createState() => _ExpensiveGoogleMapsState();
}

class _ExpensiveGoogleMapsState extends State<ExpensiveGoogleMaps> {
  final OrdersStore store = Modular.get();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: store.getRouteGoogleMap(widget.orderModel, context),
      builder: (context, snapshot) {
        // print('getroute future hasData: ${snapshot.hasData}');
        if(snapshot.hasError){
          print("error on future builder");
          print(snapshot.error);
        }
        if(!snapshot.hasData){
          return CenterLoadCircular();
        }
        return Observer(
          builder: (context) {
            // print('store.mapCircle: ${store.mapCircle}');
            return Listener(
              onPointerMove: (PointerMoveEvent event){
                print('onPointerMove');
                if(!store.scrollingGoogleMap)
                store.scrollingGoogleMap = true;
              },
              child: GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: LatLng(-15.787763, -48.008072),
                  zoom: 11.5,
                ),
                myLocationButtonEnabled: false,
                scrollGesturesEnabled: true,
                zoomControlsEnabled: false,
                onMapCreated: (controller) =>
                    store.googleMapController = controller,
                markers: {
                  if (store.location != null) store.location!,
                  if (store.destination != null) store.destination!,
                },
                polylines: {
                  if (store.info != null)
                    Polyline(
                      polylineId: PolylineId("overview_polyline"),
                      color: Colors.red,
                      width: 5,
                      points: store.info!.polyPoints,
                    )
                },
              ),
            );              
          },
        );
      }
    );
  }
}

class OSMap extends StatefulWidget {
  final Order orderModel;

  const OSMap({
    Key? key,
    required this.orderModel, 
  }) : super(key: key);
  @override
  _OSMapState createState() => _OSMapState();
}

class _OSMapState extends State<OSMap> {
  final OrdersStore store = Modular.get();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: store.getRouteOSMap(widget.orderModel, context),
      builder: (context, snapshot) {
        // print('getroute future hasData: ${snapshot.hasData}');
        if(snapshot.hasError){
          print("error on future builder");
          print(snapshot.error);
        }
        if(!snapshot.hasData){
          return CenterLoadCircular();
        }
        return Observer(
          builder: (context) {
            // print('store.mapCircle: ${store.mapCircle}');
            return Listener(
              onPointerMove: (PointerMoveEvent event){
                print('onPointerMove');
                if(!store.scrollingOSMap)
                store.scrollingOSMap = true;
              },
              child: SfMaps(
                layers: [
                  MapTileLayer(
                    controller: store.mapTileLayerController,
                    urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                    zoomPanBehavior: store.zoomPanBehavior,
                    // onWillPan: (MapPanDetails mapPanDetails){
                    //   print('onWillPan:');
                    //   return true;
                    // },
                    // onWillZoom: (MapZoomDetails mapZoomDetails){
                    //   print('onWillZoom');
                    //   return true;
                    // },
                    markerBuilder: (BuildContext context, int index) {
                      MapMarker _marker = store.mapMarkersListOSMap[index];
                      return _marker;
                    },                                          
                    initialMarkersCount: store.mapMarkersListOSMap.length,                                                              
                    sublayers: [
                      MapPolylineLayer(
                        polylines: {
                          MapPolyline(
                            color: Colors.red,
                            width: 5,
                            points: store.polyPointsOSMap,
                          ),
                        },
                      ),
                      MapCircleLayer(
                        circles: Set.of(store.mapCircleOSMap != null ? [store.mapCircleOSMap!] : []),
                      ),
                    ],
                  ),
                ],
              ),
            );              
          },
        );
      }
    );
  }
}

class MissionSideButton extends StatefulWidget {
  final String? agentStatus;
  // final String text;
  // final bool enable;

  MissionSideButton({
    Key? key,
    // required this.text,
    // required this.enable,
    required this.agentStatus,
  }) : super(key: key);

  @override
  _MissionSideButtonState createState() => _MissionSideButtonState();
}

class _MissionSideButtonState extends State<MissionSideButton> {
  final MainStore mainStore = Modular.get();

  final OrdersStore store = Modular.get();

  String text = "";
  bool enable = false;
  bool visible = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("widget.agentStatus: ${widget.agentStatus}");
    switch (widget.agentStatus) {
      case null:
        visible = false;
        break;
      case "GOING_TO_STORE":
        print("GOING_TO_STORE");
        visible = true;
        enable = true;
        break;
      case "NEAR_STORE":
        visible = false;
        break;
      case "GOING_TO_CUSTOMER":
        text = "Entregar";
        enable = true;
        visible = true;
        break;
      case "NEAR_CUSTOMER":
        text = "Chegada no cliente";
        enable = true;
        visible = true;
        break;
      case "IN_CUSTOMER":
        text = "Entregar";
        enable = true;
        visible = true;
        break;
      default:
    }
    return Align(
      alignment: Alignment.centerRight,
      child: Visibility(
        visible: visible,
        child: InkWell(
          onTap: () async {
            print('onTap widget.agentStatus: ${widget.agentStatus}');
            if (widget.agentStatus == "NEAR_CUSTOMER" ||
                widget.agentStatus == "GOING_TO_STORE") {
              await cloudFunction(
                function: "agentResponse",
                object: {
                  "orderId": mainStore.missionInProgressOrderDoc.id,
                  "response": {"agent_status": "IN_CUSTOMER"},
                },
              );
            }
            if (widget.agentStatus == "GOING_TO_CUSTOMER" ||
                widget.agentStatus == "IN_CUSTOMER") {
              Overlays(context).getTokenOverlay(
                Order.fromDoc(
                  (await mainStore.missionInProgressOrderDoc.get()),
                ),
                context,
              );
            }
          },
          borderRadius: BorderRadius.horizontal(left: Radius.circular(50)),
          child: Container(
            padding: EdgeInsets.only(
                left: wXD(15, context), right: wXD(13, context)),
            height: wXD(52, context),
            width: text.length * wXD(13.5, context),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.horizontal(left: Radius.circular(50)),
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: enable
                    ? [white, primary.withOpacity(.7), primary]
                    : [Colors.transparent, Colors.transparent],
              ),
              border: Border.all(
                color: enable ? Colors.transparent : primary,
              ),
              boxShadow: [
                BoxShadow(
                  blurRadius: 4,
                  offset: Offset(0, 3),
                  color:
                      enable ? totalBlack.withOpacity(.3) : Colors.transparent,
                )
              ],
            ),
            alignment: Alignment.center,
            child: Text(
              text,
              style: textFamily(
                fontSize: 18,
                color: enable ? white : primary,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// class ButtonClipper extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     Paint thumbPaint = Paint()
//       ..color = primary
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = 1;
//     canvas.
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
// }
class PaymentMethod extends StatelessWidget {
  PaymentMethod({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: wXD(38, context),
      width: wXD(177, context),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Color(0xffFFF4EF),
      ),
      alignment: Alignment.centerLeft,
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: wXD(6, context),
              right: wXD(9, context),
            ),
            child: SvgPicture.asset(
              "./assets/svg/outlined_card.svg",
              height: wXD(15, context),
            ),
          ),
          Text(
            "Pagamento online",
            style: textFamily(
              fontSize: 14,
              color: grey.withOpacity(.5),
            ),
          ),
        ],
      ),
    );
  }
}
