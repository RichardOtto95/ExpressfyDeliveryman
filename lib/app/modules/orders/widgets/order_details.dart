import 'package:cached_network_image/cached_network_image.dart';
import 'package:delivery_emissary/app/modules/orders/widgets/accounts.dart';
import 'package:delivery_emissary/app/shared/color_theme.dart';
import 'package:delivery_emissary/app/shared/utilities.dart';
import 'package:delivery_emissary/app/shared/widgets/default_app_bar.dart';
import 'package:delivery_emissary/app/shared/widgets/side_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'characteristics.dart';

class OrderDetails extends StatelessWidget {
  const OrderDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: wXD(83, context)),
                OrderStatus(),
                Column(
                  children: [
                    Container(
                      width: maxWidth(context),
                      margin: EdgeInsets.fromLTRB(
                        wXD(32, context),
                        wXD(18, context),
                        wXD(16, context),
                        wXD(11, context),
                      ),
                      padding: EdgeInsets.only(bottom: wXD(11, context)),
                      decoration: BoxDecoration(
                          border: Border(
                              bottom:
                                  BorderSide(color: darkGrey.withOpacity(.2)))),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            child: '' == ''
                                ? Image.asset(
                                    'assets/images/no-image-icon.png',
                                    height: wXD(65, context),
                                    width: wXD(62, context),
                                    fit: BoxFit.cover,
                                  )
                                : CachedNetworkImage(
                                    imageUrl: 'image',
                                    height: wXD(65, context),
                                    width: wXD(62, context),
                                    fit: BoxFit.cover,
                                  ),
                          ),
                          Container(
                            padding: EdgeInsets.only(left: wXD(8, context)),
                            width: wXD(255, context),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(height: wXD(3, context)),
                                Text(
                                  'Samsung Galaxy A51+',
                                  style: textFamily(color: totalBlack),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(height: wXD(3, context)),
                                Text(
                                  'Lorem Ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum',
                                  style: textFamily(
                                    color: lightGrey,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
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
                    )
                  ],
                ),
                Characteristics(),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          left: wXD(27, context), right: wXD(4, context)),
                      child: Icon(
                        Icons.bookmark_outline,
                        size: wXD(20, context),
                        color: primary,
                      ),
                    ),
                    Text(
                      'Sem Cupom promocional',
                      style: textFamily(
                          color: totalBlack, fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
                Accounts(subTotal: 1250, shippingPrice: 48),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SideButton(
                      isWhite: true,
                      height: wXD(52, context),
                      width: wXD(142, context),
                      title: 'Rejeitar',
                      onTap: () => Modular.to.pop(),
                    ),
                    SideButton(
                      height: wXD(52, context),
                      width: wXD(142, context),
                      title: 'Confirmar',
                      onTap: () => Modular.to.pop(),
                    ),
                  ],
                ),
                SizedBox(height: wXD(19, context)),
              ],
            ),
          ),
          DefaultAppBar('Detalhes'),
        ],
      ),
    );
  }
}

class OrderStatus extends StatelessWidget {
  const OrderStatus({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: wXD(59, context),
        width: wXD(343, context),
        padding: EdgeInsets.only(
          left: wXD(15, context),
          top: wXD(14, context),
          right: wXD(8, context),
          bottom: wXD(13, context),
        ),
        decoration: BoxDecoration(
          color: white,
          border: Border.all(color: primary.withOpacity(.2)),
          borderRadius: BorderRadius.all(Radius.circular(12)),
          boxShadow: [
            BoxShadow(
              blurRadius: 6,
              color: Color(0x25000000),
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Pedido #99999',
                  style: textFamily(
                    fontSize: 11,
                    color: primary,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Text(
                  'Horário 09:35',
                  style: textFamily(
                    fontSize: 12,
                    color: primary,
                  ),
                ),
              ],
            ),
            Container(
              height: wXD(24, context),
              width: wXD(102, context),
              decoration: BoxDecoration(
                  color: primary,
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              alignment: Alignment.center,
              child: Text(
                'Pendente',
                style: textFamily(
                  fontSize: 12,
                  color: white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
