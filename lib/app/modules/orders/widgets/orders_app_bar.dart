import 'package:delivery_emissary/app/modules/orders/orders_store.dart';
import 'package:delivery_emissary/app/shared/color_theme.dart';
import 'package:delivery_emissary/app/shared/utilities.dart';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

class OrdersAppBar extends StatelessWidget {
  final OrdersStore store = Modular.get();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).viewPadding.top + wXD(70, context),
      width: maxWidth(context),
      padding: EdgeInsets.only(top: MediaQuery.of(context).viewPadding.top),
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
      child: ClipRRect(
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(50)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              'Pedidos',
              style: textFamily(
                fontSize: 20,
                color: darkBlue,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: wXD(10, context)),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Container(
                width: maxWidth(context),
                padding: EdgeInsets.symmetric(horizontal: wXD(40, context)),
                child: DefaultTabController(
                  length: 2,
                  child: TabBar(
                    indicatorColor: primary,
                    indicatorSize: TabBarIndicatorSize.label,
                    labelPadding: EdgeInsets.symmetric(vertical: 8),
                    labelColor: primary,
                    labelStyle: textFamily(fontWeight: FontWeight.w400),
                    unselectedLabelColor: darkGrey,
                    indicatorWeight: 3,
                    onTap: (value) {
                      if (value == 0)
                        store.setOrderStatusView([
                          "DELIVERY_ACCEPTED",
                          "SENDED",
                        ].asObservable());
                      else if (value == 1)
                        store.setOrderStatusView([
                          "DELIVERY_REFUSED",
                          "TIMEOUT",
                          "SEND_CANCELED",
                          "CONCLUDED",
                        ].asObservable());
                    },
                    tabs: [
                      Text('Em andamento'),
                      Text('Anteriores'),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
