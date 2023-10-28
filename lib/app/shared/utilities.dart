import 'dart:io';

import 'package:cloud_functions/cloud_functions.dart';
import 'package:delivery_emissary/app/shared/color_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:permission_handler/permission_handler.dart';

import 'widgets/score_date_picker.dart';

double wXD(double size, BuildContext context) {
  return MediaQuery.of(context).size.width / 375 * size;
}

double hXD(double size, BuildContext context) {
  return MediaQuery.of(context).size.height / 667 * size;
}

double maxHeight(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

double maxWidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

double inPer(double size, double fraction) => (size * fraction) / 100;

double viewPaddingTop(BuildContext context) =>
    MediaQuery.of(context).viewPadding.top;

// TextStyle textFamily({
//   double? fontSize,
//   FontWeight? fontWeight,
//   double? height,
//   Color? color,
// }) {
//   // print('fontSize nul?? ${fontSize == null}');
//   // print('fontWeight nul?? ${fontWeight == null}');
//   // print('height nul?? ${height == null}');
//   // FontWeight _fontWeight = fontWeight == null ? FontWeight.w600 : fontWeight;
//   return GoogleFonts.montserrat(
//     fontSize: fontSize ?? 13,
//     color: color ?? textDarkBlue,
//     fontWeight: fontWeight ?? FontWeight.w500,
//     height: height ?? null,
//   );
//   // return TextStyle(
//   //   fontFamily: 'Montserrat',
//   //   fontSize: fontSize ?? 13,
//   //   color: color ?? textDarkBlue,
//   //   fontWeight: fontWeight ?? FontWeight.w600,
//   //   height: height ?? null,
//   // );
// }

TextStyle textFamily({
  double? fontSize,
  FontWeight? fontWeight,
  double? height,
  Color? color,
  FontStyle? fontStyle,
}) {
  return GoogleFonts.montserrat(
    fontSize: fontSize ?? 13,
    color: color ?? textDarkBlue,
    fontWeight: fontWeight ?? FontWeight.w500,
    height: height ?? null,
    fontStyle: fontStyle,
  );
}

SystemUiOverlayStyle getOverlayStyleFromColor(Color color) {
  Brightness brightness = ThemeData.estimateBrightnessForColor(color);
  return brightness == Brightness.dark
      ? SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light)
      : SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark);
}

String formatedCurrency(var value) {
  var newValue = new NumberFormat("#,##0.00", "pt_BR");
  return newValue.format(value);
}

void pickDate(context, {required void Function(DateTime?) onConfirm}) async {
  late OverlayEntry dateOverlay;
  dateOverlay = OverlayEntry(
    builder: (context) => ScoreDatePicker(
      onConfirm: (date) {
        onConfirm(date);
        dateOverlay.remove();
      },
      onCancel: () {
        onConfirm(null);
        dateOverlay.remove();
      },
    ),
  );
  Overlay.of(context)!.insert(dateOverlay);
}

showToast(String msg) => Fluttertoast.showToast(msg: msg);

class Masks {
  final nothingMask =
      MaskTextInputFormatter(mask: '', filter: {"#": RegExp(r'[0-9]')});

  final cpfMask = MaskTextInputFormatter(
      mask: '###.###.###-##', filter: {"#": RegExp(r'[0-9]')});

  final rgMask = MaskTextInputFormatter(
      mask: '#.###.###', filter: {"#": RegExp(r'[0-9]')});

  final cnpjMask = MaskTextInputFormatter(
      mask: '##.###.###/####-##', filter: {"#": RegExp(r'[0-9]')});

  final agencyMask =
      MaskTextInputFormatter(mask: '####-##', filter: {"#": RegExp(r'[0-9]')});

  final accountMask = MaskTextInputFormatter(
      mask: '###########', filter: {"#": RegExp(r'[0-9]')});

  MaskTextInputFormatter cepMask = MaskTextInputFormatter(
      mask: '##.###-###', filter: {"#": RegExp(r'[0-9]')});

  final digitMask =
      MaskTextInputFormatter(mask: '#', filter: {"#": RegExp(r'[0-9]')});

  final operationMask =
      MaskTextInputFormatter(mask: '###', filter: {"#": RegExp(r'[0-9]')});

  final phoneMask = MaskTextInputFormatter(
      mask: '(##) #####-####', filter: {"#": RegExp(r'[0-9]')});

  final fullNumberMask = MaskTextInputFormatter(
      mask: '+## (##) #####-####', filter: {"#": RegExp(r'[0-9]')});
}

// Future<File?> pickImage() async {
//   if (await Permission.storage.request().isGranted) {
//     final picker = ImagePicker();
//     final pickedFile = await picker.pickImage(source: ImageSource.gallery);
//     if (pickedFile == null) {
//       return null;
//     } else {
//       File _file = File(pickedFile.path);
//       return _file;
//     }
//   } else {
//     return null;
//   }
// }

Future<HttpsCallableResult?> cloudFunction({
  required String function,
  Map<String, dynamic> object = const {},
}) async {
  /// Desomente a linha abaixo para usar o emulador local
  // FirebaseFunctions.instance.useFunctionsEmulator("localhost", 5001);
  HttpsCallable callable = FirebaseFunctions.instance.httpsCallable(function);
  HttpsCallableResult? result;
  try {
    result = await callable.call(object);
  } catch (e) {
    print("Error on function: $e");
  }
  return result;
}

Future<Position> determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    return Future.error('Location services are disabled.');
  }
  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return Future.error('Location permissions are denied');
    }
  }
  if (permission == LocationPermission.deniedForever) {
    return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
  }
  return await Geolocator.getCurrentPosition();
}

Future<File?> pickImage() async {
  if (await Permission.storage.request().isGranted) {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile == null) {
      return null;
    } else {
      File _file = File(pickedFile.path);
      return _file;
    }
  } else {
    return null;
  }
}

Future<List<File>?> pickMultiImage() async {
  if (await Permission.storage.request().isGranted) {
    final picker = ImagePicker();
    final pickedListFile = await picker.pickMultiImage();
    if (pickedListFile == null) {
      return null;
    } else {
      List<File> _listFile = [];
      pickedListFile.forEach((xFile) {
        _listFile.add(File(xFile.path));
      });
      return _listFile;
    }
  } else {
    return null;
  }
}

Future<File?> pickCameraImage() async {
  if (await Permission.storage.request().isGranted) {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
        source: ImageSource.camera, preferredCameraDevice: CameraDevice.rear);
    if (pickedFile != null) {
      return File(pickedFile.path);
    }
  }
  return null;
}

Future<List?> pickMultiImageWithName() async {
  if (await Permission.storage.request().isGranted) {
    final picker = ImagePicker();
    final pickedListFile = await picker.pickMultiImage();
    if (pickedListFile == null) {
      return null;
    } else {
      List<File> _listFile = [];
      List<String> _listFileName = [];
      pickedListFile.forEach((xFile) {
        _listFile.add(File(xFile.path));
        _listFileName.add(xFile.name);
      });
      return [
        _listFile,
        _listFileName,
      ];
    }
  } else {
    return null;
  }
}

Future<List?> pickCameraImageWithName() async {
  if (await Permission.storage.request().isGranted) {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
        source: ImageSource.camera, preferredCameraDevice: CameraDevice.rear);
    if (pickedFile != null) {
      return [
        File(pickedFile.path),
        [pickedFile.name],
      ];
    }
  }
  return null;
}
