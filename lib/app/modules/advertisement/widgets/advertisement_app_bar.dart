import 'package:delivery_emissary/app/shared/color_theme.dart';
import 'package:delivery_emissary/app/shared/utilities.dart';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../advertisement_store.dart';

class AdvertisementAppBar extends StatelessWidget {
  AdvertisementAppBar({Key? key}) : super(key: key);
  final AdvertisementStore store = Modular.get();
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: wXD(104, context),
          width: maxWidth(context),
          padding:
              EdgeInsets.only(left: wXD(32, context), right: wXD(11, context)),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(50)),
            color: white,
            boxShadow: [
              BoxShadow(
                blurRadius: 4,
                offset: Offset(0, 3),
                color: Color(0x30000000),
              ),
            ],
          ),
          alignment: Alignment.bottomCenter,
          child: Observer(builder: (context) {
            return DefaultTabController(
              length: 3,
              child: TabBar(
                indicatorColor: primary,
                indicatorSize: TabBarIndicatorSize.label,
                labelPadding: EdgeInsets.symmetric(vertical: 8),
                labelColor: primary,
                labelStyle: textFamily(fontWeight: FontWeight.w500),
                unselectedLabelColor: darkGrey,
                indicatorWeight: 3,
                onTap: (val) {
                  switch (val) {
                    case 0:
                      store.setAnnouncementStatusSelected('active');
                      break;
                    case 1:
                      store.setAnnouncementStatusSelected('pending');
                      break;
                    case 2:
                      store.setAnnouncementStatusSelected('expired');
                      break;
                    default:
                  }
                },
                tabs: [
                  Text('Ativos (${store.announcementsActive})'),
                  Text('Pendentes (${store.announcementsPending})'),
                  Text('Expirados (${store.announcementsExpired})'),
                ],
              ),
            );
          }),
        ),
        Positioned(
          top: wXD(36, context),
          child: Text(
            'Meus anúncios',
            style: textFamily(
              fontSize: 20,
              color: darkBlue,
              fontWeight: FontWeight.w600,
            ),
          ),
        )
      ],
    );
  }
}
