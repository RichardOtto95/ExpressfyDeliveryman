import 'package:delivery_emissary/app/shared/color_theme.dart';
import 'package:delivery_emissary/app/shared/utilities.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../advertisement_store.dart';

class SearchType extends StatelessWidget {
  SearchType({Key? key}) : super(key: key);

  final AdvertisementStore store = Modular.get();

  @override
  Widget build(BuildContext context) {
    List types = [
      'Iphone',
      'Samsung',
      'Asus',
      'LG',
      'Nokia',
      'Motorola',
      'Sony',
      'Outras marcas',
    ];
    return Container(
      width: maxWidth(context),
      height: hXD(523, context),
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      alignment: Alignment.topLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: maxWidth(context),
            padding: EdgeInsets.fromLTRB(
              wXD(29, context),
              wXD(24, context),
              wXD(25, context),
              wXD(11, context),
            ),
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(color: darkGrey.withOpacity(.5)))),
            child: Row(
              children: [
                Icon(
                  Icons.search,
                  size: wXD(23, context),
                  color: primary,
                ),
                SizedBox(width: wXD(24, context)),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration.collapsed(
                      hintText: 'Buscar tipo',
                      hintStyle: textFamily(
                        fontSize: 15,
                        color: darkGrey.withOpacity(.7),
                      ),
                    ),
                  ),
                ),
                Icon(
                  Icons.close_rounded,
                  size: wXD(20, context),
                  color: Color(0xff555869).withOpacity(.5),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.only(
                  top: wXD(23, context),
                  left: wXD(19, context),
                  right: wXD(19, context)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(
                  types.length,
                  (index) => GestureDetector(
                    onTap: () {
                      store.editingAd
                          ? store.adEdit.type = types[index]
                          : store.announcementType = types[index];
                      store.typeValidateVisible = false;
                      store.setSearchType(false);
                    },
                    child: Padding(
                      padding: EdgeInsets.only(bottom: wXD(20, context)),
                      child: Text(
                        types[index],
                        style: textFamily(
                          fontSize: 17,
                          color: textTotalBlack,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
