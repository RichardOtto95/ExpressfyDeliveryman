import 'package:delivery_emissary/app/shared/color_theme.dart';
import 'package:delivery_emissary/app/shared/utilities.dart';

import 'package:flutter/material.dart';

class StatusForecast extends StatelessWidget {
  const StatusForecast({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: wXD(56, context),
        width: wXD(343, context),
        padding: EdgeInsets.symmetric(
          vertical: wXD(13, context),
          horizontal: wXD(16, context),
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(13)),
          color: white,
          boxShadow: [
            BoxShadow(
              blurRadius: 3,
              color: Color(0x30000000),
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Status atual',
                  style: textFamily(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: primary,
                  ),
                ),
                Text(
                  'Aguardando confirmação',
                  style: textFamily(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: primary,
                  ),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'Previsão de entrega',
                  style: textFamily(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: primary,
                  ),
                ),
                Text(
                  '13:00 PM',
                  style: textFamily(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: primary,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
