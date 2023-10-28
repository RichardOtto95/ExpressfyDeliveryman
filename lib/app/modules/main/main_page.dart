import 'dart:ui';

import 'package:delivery_emissary/app/core/services/auth/auth_store.dart';
import 'package:delivery_emissary/app/modules/home/home_module.dart';
import 'package:delivery_emissary/app/modules/notifications/notifications_module.dart';
import 'package:delivery_emissary/app/modules/orders/orders_module.dart';
import 'package:delivery_emissary/app/modules/profile/profile_module.dart';
import 'package:delivery_emissary/app/modules/support/support_module.dart';
import 'package:delivery_emissary/app/shared/color_theme.dart';
import 'package:delivery_emissary/app/shared/utilities.dart';
import 'package:delivery_emissary/app/shared/widgets/custom_nav_bar.dart';
import 'package:delivery_emissary/app/shared/widgets/floating_circle_button.dart';
import 'package:delivery_emissary/app/shared/widgets/load_circular_overlay.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
import 'dart:math' as math;
import 'main_store.dart';
import 'widgets/new_mission.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends ModularState<MainPage, MainStore>
    with TickerProviderStateMixin {
  final AuthStore authStore = Modular.get();
  @override
  void initState() {
    store.addNewOrderListener();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        print('mainstore overlay : ${store.globalOverlay != null}');
        if (store.globalOverlay != null) {
          store.removeOverlay = true;
        }
        return false;
      },
      child: Scaffold(
        body: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Observer(
              builder: (context) {
                return Container(
                  height: maxHeight(context),
                  width: maxWidth(context),
                  child: store.newMission
                      ? NewMission()
                      : PageView(
                          physics: store.paginateEnable
                              ? AlwaysScrollableScrollPhysics()
                              : NeverScrollableScrollPhysics(),
                          controller: store.pageController,
                          scrollDirection: Axis.horizontal,
                          children: [
                            HomeModule(),
                            NotificationsModule(),
                            OrdersModule(),
                            SupportModule(),
                            ProfileModule(),
                          ],
                          onPageChanged: (value) {
                            print('value: $value');
                            store.page = value;
                            store.setVisibleNav(true);
                          },
                        ),
                );
              },
            ),
            Observer(
              builder: (context) {
                return AnimatedPositioned(
                  duration: Duration(seconds: 2),
                  curve: Curves.bounceOut,
                  bottom: store.visibleNav ? 0 : wXD(-85, context),
                  child: CustomNavBar(),
                );
              },
            ),
            Observer(
              builder: (context) {
                return AnimatedPositioned(
                  duration: Duration(seconds: 1),
                  curve: Curves.bounceOut,
                  bottom: store.newMission
                      ? wXD(94, context)
                      : store.visibleNav
                          ? wXD(30, context)
                          : wXD(-80, context),
                  child: TargetButton(),
                );
              },
            ),
            Observer(
              builder: (context) {
                if (store.missionCompleted) {
                  // Overlays(context).insertMissionConcludedOverlay();
                  double opacity = 0;
                  double sigma = 0;
                  double bottom = -172;
                  bool backing = false;

                  return Positioned(
                    height: maxHeight(context),
                    width: maxWidth(context),
                    child: Material(
                      color: Colors.transparent,
                      child: StatefulBuilder(
                        builder: (context, setScreen) {
                          if (!backing) {
                            WidgetsBinding.instance!.addPostFrameCallback((_) {
                              setScreen(() {
                                opacity = .51;
                                sigma = 3;
                                bottom = 0;
                              });
                            });
                          }
                          return Stack(
                            alignment: Alignment.bottomCenter,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  backing = true;
                                  setScreen(() {
                                    opacity = 0;
                                    sigma = 0;
                                    bottom = -172;
                                  });
                                  Future.delayed(
                                    Duration(milliseconds: 400),
                                    () {
                                      store.missionCompleted = false;
                                      store.priceRateDelivery = 0;
                                    },
                                  );
                                },
                                child: BackdropFilter(
                                  filter: ImageFilter.blur(
                                      sigmaX: sigma, sigmaY: sigma),
                                  child: ColorFiltered(
                                    colorFilter: ColorFilter.mode(
                                      totalBlack.withOpacity(.2),
                                      BlendMode.color,
                                    ),
                                    child: AnimatedOpacity(
                                      duration: Duration(milliseconds: 400),
                                      curve: Curves.ease,
                                      opacity: opacity,
                                      child: Container(
                                        color: totalBlack,
                                        height: maxHeight(context),
                                        width: maxWidth(context),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              AnimatedPositioned(
                                bottom: bottom,
                                duration: Duration(milliseconds: 400),
                                curve: Curves.ease,
                                child: Container(
                                  height: wXD(172, context),
                                  width: maxWidth(context),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(25)),
                                    color: white,
                                  ),
                                  child: Stack(
                                    alignment: Alignment.topCenter,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                            top: wXD(75, context)),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              "Missão concluída",
                                              style: textFamily(
                                                fontSize: 21,
                                                color: primary,
                                              ),
                                            ),
                                            SizedBox(height: wXD(13, context)),
                                            Text(
                                              "Missão no valor de R\$ ${formatedCurrency(store.priceRateDelivery)}\nfinalizada com sucesso.",
                                              style: textFamily(
                                                fontSize: 15,
                                                color:
                                                    textBlack.withOpacity(.5),
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Positioned(
                                        top: wXD(20, context),
                                        right: wXD(-24, context),
                                        child: SvgPicture.asset(
                                          "./assets/svg/hand_phone.svg",
                                          height: wXD(108, context),
                                        ),
                                      ),
                                      Positioned(
                                        top: wXD(19, context),
                                        left: wXD(26, context),
                                        child: InkWell(
                                          onTap: () {
                                            backing = true;
                                            setScreen(() {
                                              opacity = 0;
                                              sigma = 0;
                                              bottom = -172;
                                            });
                                            Future.delayed(
                                              Duration(milliseconds: 400),
                                              () {
                                                store.missionCompleted = false;
                                                store.priceRateDelivery = 0;
                                              },
                                            );
                                          },
                                          child: Icon(
                                            Icons.close_rounded,
                                            size: wXD(30, context),
                                            color: grey,
                                          ),
                                        ),
                                      ),
                                      Observer(
                                        builder: (context) {
                                          if (store.removeOverlay) {
                                            WidgetsBinding.instance!
                                                .addPostFrameCallback(
                                                    (timeStamp) {
                                              backing = true;
                                              setScreen(() {
                                                opacity = 0;
                                                sigma = 0;
                                                bottom = -172;
                                              });
                                              Future.delayed(
                                                Duration(milliseconds: 400),
                                                () {
                                                  store.missionCompleted =
                                                      false;
                                                  store.priceRateDelivery = 0;
                                                },
                                              );
                                              store.removeOverlay = false;
                                            });
                                          }
                                          return Container();
                                        },
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  );
                }
                return Container();
              },
            ),
          ],
        ),
      ),
    );
  }
}

class TargetButton extends StatefulWidget {
  TargetButton({Key? key}) : super(key: key);

  @override
  _TargetButtonState createState() => _TargetButtonState();
}

class _TargetButtonState extends State<TargetButton>
    with SingleTickerProviderStateMixin {
  final MainStore store = Modular.get();
  late AnimationController _animationController;
  late Animation _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    _animation = Tween(begin: 0.0, end: 12.0).animate(_animationController);
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      // print("timer: ${store.tick}");
      return Container(
        width: wXD(345, context),
        height: wXD(80, context),
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            DragTarget(
              builder: (context, candidateData, rejectedData) {
                return Container(
                  height: wXD(68, context),
                  width: wXD(68, context),
                  // color: Colors.red.withOpacity(.3),
                );
              },
              onWillAccept: (data) {
                _animationController.repeat(reverse: true);
                print("onWillAccept");
                return true;
              },
              onLeave: (data) {
                print("onLeave");
                _animationController.reverse();
              },
              onAccept: (data) {
                cloudFunction(
                  function: "agentResponse",
                  object: {
                    "orderId": store.missionInProgressOrderDoc.id,
                    "response": {"status": "DELIVERY_REFUSED"},
                  },
                );
                print("Refuse");
                store.timer.cancel();
                store.tick = 0;
                store.newMission = false;
                _animationController.stop();
              },
            ),
            Draggable(
              maxSimultaneousDrags: 1,
              data: "Não sei",
              axis: Axis.horizontal,
              feedback: AnimatedBuilder(
                animation: _animation,
                builder: (context, snapshot) {
                  return CustomPaint(
                    painter: TimerPainter(
                        -2 * math.pi + (0.105 * (store.tick / 100))),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          for (int i = 1; i <= 6; i++)
                            BoxShadow(
                              color: primary
                                  .withOpacity(_animationController.value / 4),
                              spreadRadius: _animation.value * i / 6,
                            )
                        ],
                      ),
                      child: FloatingCircleButton(
                        size: wXD(68, context),
                        onTap: () {},
                        child: Padding(
                          padding: EdgeInsets.only(
                            left: wXD(5, context),
                            bottom: wXD(5, context),
                          ),
                          child: SvgPicture.asset(
                            "./assets/svg/target.svg",
                            height: wXD(38, context),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
              childWhenDragging: Container(),
              child: CustomPaint(
                painter: TimerPainter(
                  -2 * math.pi + (0.105 * (store.tick / 100)),
                  color: store.newMission
                      ? null
                      : store.page == 2
                          ? primary
                          : Colors.transparent,
                ),
                child: FloatingCircleButton(
                  size: wXD(68, context),
                  onTap: () {
                    if (store.globalOverlay != null) {
                      store.globalOverlay!.remove();
                      store.globalOverlay = null;
                    }
                    if (!store.newMission) store.setPage(2);
                  },
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: wXD(5, context),
                      bottom: wXD(5, context),
                    ),
                    child: SvgPicture.asset(
                      "./assets/svg/target.svg",
                      height: wXD(38, context),
                    ),
                  ),
                ),
              ),
              onDragStarted: () {},
              onDragCompleted: () {},
              onDragEnd: (details) {},
              onDragUpdate: (details) {},
              onDraggableCanceled: (velocity, offset) {},
            ),
            DragTarget(
              builder: (context, candidateData, rejectedData) {
                return Container(
                  height: wXD(68, context),
                  width: wXD(68, context),
                  // color: Colors.red.withOpacity(.3),
                );
              },
              onWillAccept: (data) {
                _animationController.repeat(reverse: true);
                print("onWillAccept");
                return true;
              },
              onLeave: (data) {
                print("onLeave");
                _animationController.reverse();
              },
              onAccept: (data) async {
                OverlayEntry _overlay;
                _overlay =
                    OverlayEntry(builder: (context) => LoadCircularOverlay());
                store.timer.cancel();
                Overlay.of(context)!.insert(_overlay);
                print("orderId: ${store.missionInProgressOrderDoc.id}");
                await cloudFunction(
                  function: "agentResponse",
                  object: {
                    "orderId": store.missionInProgressOrderDoc.id,
                    "response": {
                      "agent_status": "GOING_TO_STORE",
                      "status": "DELIVERY_ACCEPTED",
                    },
                  },
                );
                _overlay.remove();
                // print("Accept");
                store.tick = 0;
                _animationController.stop();
                store.newMission = false;
                await Future.delayed(
                  Duration(seconds: 1),
                  () => store.setPage(2),
                );
                await Future.delayed(
                  Duration(milliseconds: 200),
                  () async => await Modular.to
                      .pushNamed("orders/mission-in-progress", arguments: store.missionInProgressOrderDoc.id),
                );
              },
            ),
          ],
        ),
      );
    });
  }
}

class TimerPainter extends CustomPainter {
  final double time;
  final Color? color;

  TimerPainter(this.time, {this.color});
  @override
  void paint(Canvas canvas, Size size) {
    double radius = size.width / 2;
    canvas.translate(size.width / 2, size.height / 2);
    Offset center = Offset(0.0, 0.0);
    // draw shadow first
    // Path oval = Path()
    //   ..addOval(Rect.fromCircle(center: Offset(0, 3), radius: radius));

    // Paint shadowPaint = Paint()
    //   ..color = Colors.black.withOpacity(.3)
    //   ..maskFilter = MaskFilter.blur(BlurStyle.normal, 3)
    //   ..style = PaintingStyle.stroke
    //   ..strokeWidth = 5;
    // canvas.drawPath(oval, shadowPaint);
    // draw circle
    Paint thumbPaint = Paint()
      ..shader = LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: color != null
                  ? [color!, color!]
                  : [Colors.blue.shade800, Colors.red, Colors.yellow.shade700],
              tileMode: TileMode.mirror)
          .createShader(Rect.fromCircle(center: center, radius: radius))
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5;
    // canvas.drawCircle(center, radius, thumbPaint);

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      math.pi * 3 / 2,
      time,
      false,
      thumbPaint,
    );
  }

  @override
  bool shouldRepaint(TimerPainter oldDelegate) {
    return true;
  }
}
