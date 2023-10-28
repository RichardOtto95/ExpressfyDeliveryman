import 'package:delivery_emissary/app/modules/main/main_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../color_theme.dart';
import '../utilities.dart';

class CustomNavBar extends StatelessWidget {
  final MainStore mainStore = Modular.get();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: wXD(85, context),
      width: wXD(375, context),
      child: CustomPaint(
        painter: WaverShadow(),
        child: Container(
          margin: EdgeInsets.only(top: wXD(12, context)),
          child: ClipPath(
            clipper: WaverClipper(),
            child: Container(
              height: wXD(80, context),
              width: wXD(375, context),
              color: Color(0xffffffff),
              child: Observer(builder: (context) {
                // print(
                //     'pageController.page: ${mainStore.pageController.page}');
                return Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: double.infinity,
                        child: IconButton(
                          onPressed: () {
                            print(
                                'mainstore overlay : ${mainStore.globalOverlay != null}');
                            if (mainStore.globalOverlay != null) {
                              mainStore.globalOverlay!.remove();
                              mainStore.globalOverlay = null;
                            }
                            mainStore.setPage(0);
                          },
                          icon: Icon(
                            Icons.home_outlined,
                            color: mainStore.page == 0.000
                                ? primary
                                : darkGrey.withOpacity(.3),
                            size: wXD(35, context),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: SizedBox(
                        height: double.infinity,
                        child: IconButton(
                          onPressed: () {
                            print(
                                'mainstore overlay : ${mainStore.globalOverlay != null}');
                            if (mainStore.globalOverlay != null) {
                              mainStore.globalOverlay!.remove();
                              mainStore.globalOverlay = null;
                            }
                            mainStore.setPage(1);
                          },
                          icon: Icon(
                            Icons.notifications_outlined,
                            color: mainStore.page == 1.000
                                ? primary
                                : darkGrey.withOpacity(.3),
                            size: wXD(35, context),
                          ),
                        ),
                      ),
                    ),
                    Spacer(),
                    Expanded(
                      child: SizedBox(
                        height: double.infinity,
                        child: IconButton(
                          onPressed: () {
                            print(
                                'mainstore overlay : ${mainStore.globalOverlay != null}');
                            if (mainStore.globalOverlay != null) {
                              mainStore.globalOverlay!.remove();
                              mainStore.globalOverlay = null;
                            }
                            mainStore.setPage(3);
                          },
                          icon: Icon(
                            Icons.headset_mic_outlined,
                            color: mainStore.page == 3.000
                                ? primary
                                : darkGrey.withOpacity(.3),
                            size: wXD(35, context),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: SizedBox(
                        height: double.infinity,
                        child: IconButton(
                          onPressed: () {
                            print(
                                'mainstore overlay : ${mainStore.globalOverlay != null}');
                            if (mainStore.globalOverlay != null) {
                              mainStore.globalOverlay!.remove();
                              mainStore.globalOverlay = null;
                            }
                            mainStore.setPage(4);
                          },
                          icon: Icon(
                            Icons.person_outline,
                            color: mainStore.page == 4.000
                                ? primary
                                : darkGrey.withOpacity(.3),
                            size: wXD(35, context),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}

class WaverShadow extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path = Path();
    path.moveTo(size.width, 0);
    path.lineTo(size.width * .64, 0);

    // Offset firstStart = Offset(size.width * .625, size.height * .05);
    Offset firstStart = Offset(size.width * .60, 0);
    Offset firstEnd = Offset(size.width * .59, size.height * .2);

    path.quadraticBezierTo(
      firstStart.dx,
      firstStart.dy,
      firstEnd.dx,
      firstEnd.dy,
    );

    path.arcToPoint(
      Offset(size.width * .41, size.height * .2),
      radius: Radius.circular(35),
    );

    Offset start2 = Offset(size.width * .40, 0);
    Offset end2 = Offset(size.width * .36, 0);

    path.quadraticBezierTo(start2.dx, start2.dy, end2.dx, end2.dy);

    path.lineTo(0, 0);
    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.close();

    canvas.drawShadow(path, Color(0x30000000), 4, false);

    // Paint paint = Paint();
    // paint.color = Color(0xfffafafa);

    // canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class WaverClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    // debugPrint(size.width.toString());

    Path path = Path();
    path.moveTo(size.width, 0);
    path.lineTo(size.width * .64, 0);

    // Offset firstStart = Offset(size.width * .625, size.height * .05);
    Offset firstStart = Offset(size.width * .64 - (size.height * .1), 0);
    Offset firstEnd = Offset(size.width * .61, size.height * .1);

    path.quadraticBezierTo(
      firstStart.dx,
      firstStart.dy,
      firstEnd.dx,
      firstEnd.dy,
    );

    path.arcToPoint(
      Offset(size.width * .39, size.height * .1),
      radius: Radius.circular(40),
    );

    Offset start2 = Offset(size.width * .36 + (size.height * .1), 0);
    Offset end2 = Offset(size.width * .36, 0);

    path.quadraticBezierTo(start2.dx, start2.dy, end2.dx, end2.dy);

    path.lineTo(0, 0);
    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}
