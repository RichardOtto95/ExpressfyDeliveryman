import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery_emissary/app/core/models/address_model.dart';
import 'package:delivery_emissary/app/core/models/directions_model.dart';
import 'package:delivery_emissary/app/core/models/order_model.dart';
import 'package:delivery_emissary/app/shared/color_theme.dart';
import 'package:delivery_emissary/app/shared/utilities.dart';
import 'package:delivery_emissary/app/shared/widgets/ball.dart';
import 'package:delivery_emissary/app/shared/widgets/center_load_circular.dart';
import 'package:delivery_emissary/app/shared/widgets/default_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:syncfusion_flutter_maps/maps.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import '../../../core/models/directions_model.dart';
import '../../../core/models/seller_model.dart';
// import '../../orders/widgets/directions_repository.dart';
import '../../orders/widgets/network_helper.dart';
import '../main_store.dart';

class NewMission extends StatefulWidget {
  const NewMission({Key? key}) : super(key: key);

  @override
  _NewMissionState createState() => _NewMissionState();
}

class _NewMissionState extends State<NewMission> {
  final MainStore store = Modular.get();

  Seller seller = Seller();
  Address sellerAddress = Address();
  Address customerAddress = Address();
  double distanceToSeller = 0;
  DirectionsOSMap? toSellerDirection;
  DirectionsOSMap? toCustomerDirection;
  String totalDistance = "Indefinida";

  @override
  void initState(){
    print("neMission neMission neMission");
    super.initState();
  }

  Future<Order> getNewMissionData() async {
    final orderDoc = await store.missionInProgressOrderDoc.get();
    print("step 1");
    final order = Order.fromDoc(orderDoc);
    print("step 2");

    seller = Seller.fromDoc(await FirebaseFirestore.instance
        .collection("sellers")
        .doc(order.sellerId)
        .get());
    print("step 3");

    sellerAddress = Address.fromDoc(await FirebaseFirestore.instance
        .collection("sellers")
        .doc(order.sellerId)
        .collection("addresses")
        .doc(order.sellerAdderessId)
        .get());
    print("step 4");

    customerAddress = Address.fromDoc(await FirebaseFirestore.instance
        .collection("customers")
        .doc(order.customerId)
        .collection("addresses")
        .doc(order.customerAdderessId)
        .get());
    print("step 5");

    Position myPosition = await determinePosition();
    print("step 6");

    MapLatLng myLatLng = MapLatLng(myPosition.latitude, myPosition.longitude);
    MapLatLng sellerPosition = MapLatLng(sellerAddress.latitude!, sellerAddress.longitude!);
    MapLatLng customerPosition = MapLatLng(customerAddress.latitude!, customerAddress.longitude!);
    print("step 7");
    print("myLatLng: $myLatLng");
    print("sellerPosition: $sellerPosition");

    try {
      print("seller try");
      NetworkHelper _network = NetworkHelper(
        startLat: myLatLng.latitude,
        startLng: myLatLng.longitude,
        endLat: sellerPosition.latitude,
        endLng: sellerPosition.longitude,
      );

      Map response = await _network.getData();



      toSellerDirection = response['direction'];      
      print('step 8');
    } catch (e) {
      print("error on seller try");
      print(e);
    }

    try {
      print("customer try");
      NetworkHelper _network = NetworkHelper(
        startLat: myLatLng.latitude,
        startLng: myLatLng.longitude,
        endLat: customerPosition.latitude,
        endLng: customerPosition.longitude,
      );

      Map _response = await _network.getData();

      toCustomerDirection = _response['direction'];      
      print('step 9');
    } catch (e) {
      print("error on customer try");
      print(e);
    }


    // toSellerDirection = await DirectionRepository()
    //     .getDirections(origin: myLatLng, destination: sellerPosition);
    // print("step 8");

    // toCustomerDirection = await DirectionRepository()
    //     .getDirections(origin: sellerPosition, destination: customerPosition);
    // print("step 9");
    print(
        "toSellerDirection!.totalDistance: ${toSellerDirection!.totalDistance}");
    print(
        "toCustomerDirection!.totalDistance: ${toCustomerDirection!.totalDistance}");

    String sellerTotalDistance =
        toSellerDirection!.totalDistance.replaceAll(" km", "");
    String customerTotalDistance =
        toCustomerDirection!.totalDistance.replaceAll(" km", "");

    sellerTotalDistance = sellerTotalDistance.replaceAll(" m", "");
    customerTotalDistance = customerTotalDistance.replaceAll(" m", "");

    print('sellerTotalDistance: $sellerTotalDistance');
    print('customerTotalDistance: $customerTotalDistance');

    double toSellerDistance = double.parse(sellerTotalDistance);
    double toCustomerDistance = double.parse(customerTotalDistance);

    print("step 10");

    totalDistance = (toSellerDistance + toCustomerDistance).toString();

    print("step 11");
    return order;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Order>(
        future: getNewMissionData(),
        builder: (context, orderSnap) {
          if(orderSnap.hasError){
            print('orderSnap.error: ${orderSnap.error}');
          }
          if (!orderSnap.hasData) {
            return CenterLoadCircular();
          }
          Order order = orderSnap.data!;
          return Column(
            children: [
              DefaultAppBar("Nova missão", noPop: true),
              Container(
                margin: EdgeInsets.only(top: wXD(25, context)),
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: wXD(22, context)),
                      width: wXD(236, context),
                      height: wXD(101, context),
                      child: SvgPicture.asset(
                        "./assets/svg/motocycle.svg",
                        height: wXD(193, context),
                      ),
                    ),
                    Positioned(
                      top: 0,
                      right: 0,
                      child: SvgPicture.asset(
                        "./assets/svg/locale.svg",
                        height: wXD(59, context),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: wXD(17, context)),
              Padding(
                padding: EdgeInsets.only(),
                child: Text(
                  "R\$ ${formatedCurrency(order.priceRateDelivery)}",
                  style: textFamily(
                    fontSize: 25,
                    color: primary,
                  ),
                ),
              ),
              SizedBox(height: wXD(31, context)),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(width: wXD(30, context)),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(height: wXD(5, context)),
                      Ball(size: 6, color: primary),
                      Ball(),
                      Ball(
                        size: 13,
                        color: primary,
                        icon: Icons.arrow_upward_rounded,
                      ),
                      Ball(size: 6, color: lightGrey.withOpacity(.5)),
                      Ball(),
                      Ball(),
                      Ball(),
                      Ball(),
                      Ball(
                        size: 13,
                        color: primary,
                        icon: Icons.arrow_downward_rounded,
                      ),
                      Ball(size: 6, color: lightGrey.withOpacity(.5)),
                      Ball(),
                      Ball(),
                      Ball(),
                      Ball(size: 6, color: primary),
                    ],
                  ),
                  SizedBox(width: wXD(36, context)),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${toSellerDirection!.totalDistance} até a primeira coleta",
                        style: textFamily(
                          fontSize: 12,
                          color: darkGrey,
                        ),
                      ),
                      SizedBox(height: wXD(13, context)),
                      Text(
                        "Coletas: 1",
                        style: textFamily(
                          fontSize: 16,
                          color: totalBlack,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(height: wXD(2, context)),
                      Text(
                        seller.storeName!,
                        style: textFamily(
                          fontSize: 12,
                          color: darkGrey,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(height: wXD(48, context)),
                      Text(
                        "Entregas: 1",
                        style: textFamily(
                          fontSize: 16,
                          color: totalBlack,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(height: wXD(2, context)),
                      SizedBox(
                        width: wXD(200, context),
                        child: Text(
                          customerAddress.formatedAddress!,
                          style: textFamily(
                            fontSize: 12,
                            color: darkGrey,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      SizedBox(height: wXD(31, context)),
                      Text(
                        "Percurso total de ${totalDistance}km",
                        style: textFamily(
                          fontSize: 16,
                          color: totalBlack,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Spacer(),
              Container(
                height: wXD(147, context),
                width: maxWidth(context),
                alignment: Alignment.topCenter,
                child: Row(
                  children: [
                    Spacer(),
                    SvgPicture.asset("./assets/svg/refuse.svg"),
                    Spacer(),
                    SvgPicture.asset("./assets/svg/3backward.svg"),
                    Spacer(flex: 3),
                    SvgPicture.asset("./assets/svg/3frontward.svg"),
                    Spacer(),
                    SvgPicture.asset("./assets/svg/confirm.svg"),
                    Spacer(),
                  ],
                ),
              ),
            ],
          );
        });
  }
}
