import 'package:delivery_emissary/app/shared/color_theme.dart';
import 'package:delivery_emissary/app/shared/utilities.dart';
import 'package:flutter/material.dart';

class Accounts extends StatelessWidget {
  final double subTotal, shippingPrice;
  const Accounts({
    Key? key,
    required this.subTotal,
    required this.shippingPrice,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: maxWidth(context),
      padding: EdgeInsets.fromLTRB(
        wXD(30, context),
        wXD(15, context),
        wXD(20, context),
        wXD(30, context),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                'Sub Total',
                style: textFamily(
                  fontSize: 15,
                  color: darkGrey,
                ),
              ),
              Spacer(),
              Text(
                'R\$${formatedCurrency(subTotal)}',
                style: textFamily(
                  fontSize: 15,
                  color: primary,
                ),
              ),
            ],
          ),
          SizedBox(height: wXD(12, context)),
          Row(
            children: [
              Text(
                'Frete',
                style: textFamily(
                  fontSize: 15,
                  color: darkGrey,
                ),
              ),
              Spacer(),
              Text(
                'R\$${formatedCurrency(shippingPrice)}',
                style: textFamily(
                  fontSize: 15,
                  color: primary,
                ),
              ),
            ],
          ),
          SizedBox(height: wXD(12, context)),
          Row(
            children: [
              Text(
                'Total',
                style: textFamily(
                  fontSize: 15,
                  color: darkGrey,
                ),
              ),
              Spacer(),
              Text(
                'R\$${formatedCurrency((shippingPrice + subTotal))}',
                style: textFamily(
                  fontSize: 15,
                  color: primary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
