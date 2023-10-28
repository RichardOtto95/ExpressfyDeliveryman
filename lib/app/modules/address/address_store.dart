import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery_emissary/app/core/models/address_model.dart';
import 'package:delivery_emissary/app/modules/main/main_store.dart';
import 'package:delivery_emissary/app/shared/overlays.dart';
import 'package:delivery_emissary/app/shared/utilities.dart';
import 'package:delivery_emissary/app/shared/widgets/address_popup.dart';
import 'package:delivery_emissary/app/shared/widgets/load_circular_overlay.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:place_picker/place_picker.dart';
part 'address_store.g.dart';

class AddressStore = _AddressStoreBase with _$AddressStore;

abstract class _AddressStoreBase with Store {
  final MainStore mainStore = Modular.get();

  @observable
  LocationResult? locationResult;
  @observable
  OverlayEntry? editAddressOverlay;
  @observable
  bool addressOverlay = false;

  @action
  getAdressPopUpOverlay(Address address, context) {
    mainStore.globalOverlay = OverlayEntry(
      builder: (ovContext) => AddressPopUp(
        model: address,
        onCancel: () => mainStore.globalOverlay!.remove(),
        onEdit: () {
          print("onEdit");
          mainStore.globalOverlay!.remove();
          mainStore.globalOverlay = null;
          Overlays(context).insertAddAddress(editing: true, model: address);
        },
        onDelete: () async {
          print("onDelete");
          OverlayEntry overlayEntry;
          overlayEntry =
              OverlayEntry(builder: (context) => LoadCircularOverlay());
          Overlay.of(context)!.insert(overlayEntry);
          DocumentSnapshot _user = await FirebaseFirestore.instance
              .collection("agents")
              .doc(mainStore.authStore.user!.uid)
              .get();
          if (_user.get("main_address") == address.id) {
            await _user.reference.update({"main_address": null});
          }
          await _user.reference
              .collection("addresses")
              .doc(address.id)
              .update({"status": "DELETED"});
          overlayEntry.remove();
          mainStore.globalOverlay!.remove();
          mainStore.globalOverlay = null;
        },
      ),
    );
    Overlay.of(context)!.insert(mainStore.globalOverlay!);
  }

  @action
  getLocationResult(_locationResult) => locationResult = _locationResult;

  @action
  newAddress(Map<String, dynamic> addressMap, context, bool editing) async {
    OverlayEntry overlayEntry;
    overlayEntry = OverlayEntry(builder: (context) => LoadCircularOverlay());
    Overlay.of(context)!.insert(overlayEntry);
    String functionName = "newAddress";

    if (editing) {
      functionName = "editAddress";
    }
    print("$functionName");
    await cloudFunction(function: functionName, object: {
      "address": addressMap,
      "collection": "agents",
      "userId": mainStore.authStore.user!.uid,
    });
    overlayEntry.remove();
  }
}
