import 'package:cached_network_image/cached_network_image.dart';
import 'package:delivery_emissary/app/core/models/time_model.dart';
import 'package:delivery_emissary/app/shared/color_theme.dart';
import 'package:delivery_emissary/app/shared/utilities.dart';
import 'package:delivery_emissary/app/shared/widgets/center_load_circular.dart';
import 'package:delivery_emissary/app/shared/widgets/default_app_bar.dart';
import 'package:delivery_emissary/app/shared/widgets/side_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import '../profile_store.dart';
import 'profile_data_tile.dart';

class EditProfile extends StatefulWidget {
  EditProfile({Key? key}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final TextEditingController pixEditController = TextEditingController();
  final ScrollController scrollController = ScrollController();
  final ProfileStore store = Modular.get();
  final Masks masks = Masks();

  final _formKey = GlobalKey<FormState>();
  final genderKey = GlobalKey();
  final bankKey = GlobalKey();

  final LayerLink genderLayerLink = LayerLink();
  final LayerLink bankLayerLink = LayerLink();
  final LayerLink pixLayerLink = LayerLink();

  late OverlayEntry genderOverlay;
  late OverlayEntry bankOverlay;
  late OverlayEntry pixOverlay;
  late OverlayEntry loadOverlay;

  MaskTextInputFormatter? _pixMask;

  FocusNode usernameFocus = FocusNode();
  FocusNode fullnameFocus = FocusNode();
  FocusNode birthdayFocus = FocusNode();
  FocusNode cpfFocus = FocusNode();
  FocusNode rgFocus = FocusNode();
  FocusNode issuingAgencyFocus = FocusNode();
  FocusNode genderFocus = FocusNode();
  FocusNode bankFocus = FocusNode();
  FocusNode agencyFocus = FocusNode();
  FocusNode accountFocus = FocusNode();
  FocusNode digitFocus = FocusNode();
  FocusNode pixKeyFocus = FocusNode();
  FocusNode pixFocus = FocusNode();

  bool emailPix = false;

  @override
  void initState() {
    _pixMask = masks.nothingMask;
    addGenderFocusListener();
    addBankFocusListener();
    addBirthdayFocusListener();
    addPixKeyFocusListener();
    super.initState();
  }

  @override
  void dispose() {
    fullnameFocus.dispose();
    birthdayFocus.dispose();
    cpfFocus.dispose();
    rgFocus.dispose();
    issuingAgencyFocus.dispose();
    genderFocus.dispose();
    bankFocus.dispose();
    agencyFocus.dispose();
    accountFocus.dispose();
    digitFocus.dispose();
    pixKeyFocus.dispose();
    pixFocus.dispose();

    super.dispose();
  }

  Future scrollToGender() async {
    final _context = genderKey.currentContext;
    double proportion = hXD(73, context) / maxWidth(context);
    await Scrollable.ensureVisible(_context!,
        alignment: proportion, duration: Duration(milliseconds: 400));
  }

  Future scrollToBank() async {
    final _context = bankKey.currentContext;
    double proportion = hXD(73, context) / maxWidth(context);
    await Scrollable.ensureVisible(_context!,
        alignment: proportion, duration: Duration(milliseconds: 400));
  }

  addBankFocusListener() {
    bankFocus.addListener(() async {
      if (bankFocus.hasFocus) {
        scrollToBank();
        bankOverlay = getBankOverlay();
        Overlay.of(context)!.insert(bankOverlay);
      } else {
        bankOverlay.remove();
      }
    });
  }

  addGenderFocusListener() {
    genderFocus.addListener(() async {
      if (genderFocus.hasFocus) {
        scrollToGender();
        genderOverlay = getGenderOverlay();
        Overlay.of(context)!.insert(genderOverlay);
      } else {
        genderOverlay.remove();
      }
    });
  }

  addBirthdayFocusListener() {
    birthdayFocus.addListener(() async {
      if (birthdayFocus.hasFocus) {
        await store.setBirthday(
          context, 
          () {
            cpfFocus.requestFocus();
          },
        );
      }
    });
  }

  addPixKeyFocusListener() {
    pixKeyFocus.addListener(() async {
      if (pixKeyFocus.hasFocus) {
        pixOverlay = getPixKeyOverlay();
        Overlay.of(context)!.insert(pixOverlay);
        scrollController.animateTo(scrollController.position.maxScrollExtent,
            duration: Duration(milliseconds: 500), curve: Curves.ease);
      } else {
        pixOverlay.remove();
      }
    });
  }

  OverlayEntry getBankOverlay() {
    List<String> banks = [
      "Itaú",
      "Inter",
      "Bradesco",
      "Caixa",
      "Santander",
      "Sicob",
      "Banco do Brasil",
      "C6 Bank",
    ];
    return OverlayEntry(
      builder: (context) => Positioned(
        // height: wXD(100, context),
        width: wXD(120, context),
        child: CompositedTransformFollower(
          offset: Offset(wXD(35, context), wXD(60, context)),
          link: bankLayerLink,
          child: Material(
            color: Colors.transparent,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: wXD(10, context)),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(30),
                  bottomLeft: Radius.circular(30),
                ),
                color: white,
                boxShadow: [
                  BoxShadow(
                      blurRadius: 3,
                      offset: Offset(0, 3),
                      color: totalBlack.withOpacity(.3))
                ],
              ),
              alignment: Alignment.center,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: banks
                    .map(
                      (bank) => InkWell(
                        onTap: () {
                          store.profileEdit['bank'] = bank;
                          store.profileData['bank'] = bank;
                          agencyFocus.requestFocus();
                        },
                        child: Container(
                          height: wXD(20, context),
                          padding: EdgeInsets.only(left: wXD(8, context)),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            bank,
                            style: textFamily(),
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          ),
        ),
      ),
    );
  }

  OverlayEntry getGenderOverlay() {
    List<String> genders = ["Feminino", "Masculino", "Outro"];
    return OverlayEntry(
      builder: (context) => Positioned(
        height: wXD(100, context),
        width: wXD(80, context),
        child: CompositedTransformFollower(
          offset: Offset(wXD(35, context), wXD(60, context)),
          link: genderLayerLink,
          child: Material(
            color: Colors.transparent,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(30),
                  bottomLeft: Radius.circular(30),
                ),
                color: white,
                boxShadow: [
                  BoxShadow(
                      blurRadius: 3,
                      offset: Offset(0, 3),
                      color: totalBlack.withOpacity(.3))
                ],
              ),
              alignment: Alignment.center,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: genders
                    .map(
                      (gender) => InkWell(
                        onTap: () {
                          store.profileEdit['gender'] = gender;
                          store.profileData['gender'] = gender;
                          bankFocus.requestFocus();
                        },
                        child: Container(
                          height: wXD(20, context),
                          padding: EdgeInsets.only(left: wXD(8, context)),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            gender,
                            style: textFamily(),
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Map<String, String> pixKeys = {
    "CPF/CNPJ": "CPF/CNPJ",
    "PHONE": "Celular",
    "EMAIL": "E-mail",
    "RANDOM": "Aleatória",
  };

  OverlayEntry getPixKeyOverlay() {
    return OverlayEntry(
      builder: (context) => Positioned(
        height: wXD(100, context),
        width: wXD(80, context),
        child: CompositedTransformFollower(
          offset: Offset(wXD(35, context), wXD(60, context)),
          link: pixLayerLink,
          child: Material(
            color: Colors.transparent,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(30),
                  bottomLeft: Radius.circular(30),
                ),
                color: white,
                boxShadow: [
                  BoxShadow(
                      blurRadius: 3,
                      offset: Offset(0, 3),
                      color: totalBlack.withOpacity(.3))
                ],
              ),
              alignment: Alignment.center,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: pixKeys.keys
                    .map(
                      (key) => InkWell(
                        onTap: () {
                          print("$key: ${pixKeys[key]}");
                          store.profileEdit['pix_key'] = key;
                          store.profileData['pix_key'] = key;
                          emailPix = false;
                          setPixMask();
                          if (pixEditController.text != "") {
                            pixEditController.clear();
                          }
                          pixFocus.requestFocus();
                        },
                        child: Container(
                          height: wXD(20, context),
                          padding: EdgeInsets.only(left: wXD(8, context)),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            key,
                            style: textFamily(),
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void setPixMask() {
    print("pixKey: ${store.profileData["pix_key"]}");
    switch (store.profileData["pix_key"]) {
      case "CPF/CNPJ":
        if (_pixMask == null) {
          _pixMask = MaskTextInputFormatter(
              mask: '###.###.###-###', filter: {"#": RegExp(r'[0-9]')});
        } else {
          _pixMask!.updateMask(
            mask: "###.###.###-###",
            filter: {"#": RegExp(r'[0-9]')},
          );
        }
        break;
      case "PHONE":
        if (_pixMask == null) {
          _pixMask = masks.phoneMask;
        } else {
          _pixMask!.updateMask(
            mask: "(##) #####-####",
            filter: {"#": RegExp(r'[0-9]')},
          );
        }
        break;
      case "EMAIL":
        emailPix = true;
        _pixMask = null;
        break;
      case "RANDOM":
        _pixMask = null;
        break;
      default:
    }

    print("pix mask: ${_pixMask != null ? _pixMask!.getMask() : null}");
  }

  String? getPixData() {
    switch (store.profileData["pix_key"]) {
      case "Celular":
        return masks.phoneMask.maskText(store.profileData["pix"]);
      case "CPF/CNPJ":
        if (store.profileData["pix"].toString().length == 11) {
          return masks.cpfMask.maskText(store.profileData["pix"]);
        } else if (store.profileData["pix"].toString().length == 14) {
          return masks.cnpjMask.maskText(store.profileData["pix"]);
        }
        break;
      default:
        return store.profileData["pix"];
    }
  }

  @override
  Widget build(BuildContext context) {
    // store.profileData.forEach((key, value) {
    //   print("$key: $value");
    // });
    return WillPopScope(
      onWillPop: () async {
        store.profileEdit.clear();
        WidgetsBinding.instance!.addPostFrameCallback((timeStamp) async {
          await store.setProfileEditFromDoc();
        });
        return true;
      },
      child: Scaffold(
        body: Stack(
          children: [
            Observer(
              builder: (context) {
                if (store.profileData.isEmpty) {
                  return CenterLoadCircular();
                }
                if (store.profileEdit.isEmpty) {
                  WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
                    print("ProfileData: ${store.profileEdit["cpf"]}");
                    store.profileEdit = store.profileData;
                    setPixMask();
                  });
                }
                print("ProfileData: ${store.profileData["username"]}");
                return SingleChildScrollView(
                  controller: scrollController,
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: wXD(22, context)),
                        Stack(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                                boxShadow: [
                                  BoxShadow(
                                      blurRadius: 3,
                                      offset: Offset(0, 3),
                                      color: totalBlack.withOpacity(.2))
                                ],
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(60)),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(60)),
                                child: Container(
                                  height: wXD(338, context),
                                  width: maxWidth(context),
                                  child: store.profileData['avatar'] == null
                                  ? Image.asset(
                                    "./assets/images/defaultUser.png",
                                    height: wXD(338, context),
                                    width: maxWidth(context),
                                    fit: BoxFit.fitWidth,
                                  ) :
                                  store.profileData['avatar'] == ""
                                      ? Container(
                                        height: wXD(338, context),
                                        width: maxWidth(context),
                                        child: Center(
                                          child: CircularProgressIndicator(
                                            color: primary,
                                          ),
                                        ),
                                      )
                                      : CachedNetworkImage(
                                          imageUrl: store.profileData['avatar'],
                                          height: wXD(338, context),
                                          width: maxWidth(context),
                                          fit: BoxFit.fitWidth,
                                          progressIndicatorBuilder: (context, value, downloadProgress){
                                            return Center(
                                              child: CircularProgressIndicator(
                                                color: primary,
                                              ),
                                            );
                                          }
                                        ),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: wXD(30, context),
                              right: wXD(17, context),
                              child: InkWell(
                                onTap: () => store.pickAvatar(),
                                child: Icon(
                                  Icons.camera_alt,
                                  color: veryLightGrey,
                                  size: wXD(30, context),
                                ),
                              ),
                            )
                          ],
                        ),
                        Visibility(
                          visible: store.avatarValidate,
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: wXD(24, context), top: wXD(15, context)),
                            child: Text(
                              "Selecione uma imagem para continuar",
                              style: TextStyle(
                                color: Colors.red[600],
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            left: wXD(23, context),
                            top: wXD(21, context),
                          ),
                          child: Text(
                            'Dados pessoais',
                            style: textFamily(
                                fontSize: 16,
                                color: primary,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        ProfileDataTile(
                          title: 'Nome de usuário',
                          data: store.profileEdit["username"] ??
                              store.profileData["username"],
                          focusNode: usernameFocus,
                          hint: "Seu nome de usuário",
                          onChanged: (val) {
                            store.profileEdit["username"] = val;
                          },
                          onComplete: () => fullnameFocus.requestFocus(),
                        ),
                        ProfileDataTile(
                          title: 'Nome completo',
                          data: store.profileEdit["fullname"] ??
                              store.profileData["fullname"],
                          focusNode: fullnameFocus,
                          hint: "Seu nome completo",
                          onChanged: (val) {
                            store.profileEdit["fullname"] = val;
                          },
                          onComplete: () {
                            birthdayFocus.requestFocus();                        
                          },
                        ),
                        ProfileDataTile(
                          title: 'Data de nascimento',
                          data: TimeModel().date(
                            store.profileEdit["birthday"] ??
                                store.profileData["birthday"],
                          ),
                          focusNode: birthdayFocus,
                          hint: "Sua data de nascimento",
                          onComplete: () => cpfFocus.requestFocus(),
                          onPressed: () {
                            store.setBirthday(
                              context, 
                              () {
                                cpfFocus.requestFocus();
                              },
                            );
                          },
                          validate: store.birthdayValidate,
                        ),
                        ProfileDataTile(
                          title: 'CPF',
                          data: masks.cpfMask.maskText(                              
                            store.profileData["cpf"] != null
                              ? store.profileData["cpf"]
                              : "",
                          ),
                          textInputType: TextInputType.number,
                          focusNode: cpfFocus,
                          hint: "Seu CPF",
                          mask: masks.cpfMask,
                          onChanged: (val) {
                            store.profileEdit["cpf"] = val;
                          },
                          onComplete: () => rgFocus.requestFocus(),
                          length: 11,
                        ),
                        ProfileDataTile(
                          title: 'RG',
                          textInputType: TextInputType.number,
                          data: masks.rgMask.maskText(
                            store.profileData["rg"] != null
                              ? store.profileData["rg"]
                              : "",
                          ),
                          focusNode: rgFocus,
                          hint: "Seu RG",
                          length: 7,
                          mask: masks.rgMask,
                          onChanged: (val) {
                            store.profileEdit["rg"] = val;
                          },
                          onComplete: () => issuingAgencyFocus.requestFocus(),
                        ),
                        ProfileDataTile(
                          title: 'Órgão emissor',
                          data: store.profileEdit["issuing_agency"] ??
                              store.profileData["issuing_agency"],
                          focusNode: issuingAgencyFocus,
                          hint: "Seu órgão emissor",
                          onChanged: (val) {
                            store.profileEdit["issuing_agency"] = val;
                          },
                          onComplete: () => genderFocus.requestFocus(),
                        ),
                        CompositedTransformTarget(
                          link: genderLayerLink,
                          child: ProfileDataTile(
                            key: genderKey,
                            title: 'Gênero',
                            hint: 'Feminino',
                            data: store.profileEdit['gender'] ??
                                store.profileData['gender'],
                            focusNode: genderFocus,
                            validate: store.genderValidate,
                            onPressed: () {
                              genderFocus.requestFocus();
                            },
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: wXD(23, context), top: wXD(21, context)),
                          child: Text(
                            'Dados Bancários',
                            style: textFamily(
                                fontSize: 16,
                                color: primary,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        CompositedTransformTarget(
                          link: bankLayerLink,
                          child: ProfileDataTile(
                            key: bankKey,
                            title: 'Banco',
                            data: store.profileEdit['bank'] ??
                                store.profileData['bank'],
                            hint: 'Selecione seu banco',
                            focusNode: bankFocus,
                            validate: store.bankValidate,
                            onPressed: () => bankFocus.requestFocus(),
                          ),
                        ),
                        ProfileDataTile(
                          title: 'Agência',
                          textInputType: TextInputType.number,
                          data: masks.agencyMask.maskText(
                            store.profileData["agency"] != null
                              ? store.profileData["agency"]
                              : "",
                          ),
                          focusNode: agencyFocus,
                          hint: "Sua agencia",
                          mask: masks.agencyMask,
                          onChanged: (val) {
                            store.profileEdit["agency"] = val;
                          },
                          onComplete: () => accountFocus.requestFocus(),
                        ),
                        ProfileDataTile(
                          title: 'Conta',
                          textInputType: TextInputType.number,
                          data: masks.accountMask.maskText(
                            store.profileData["account"] != null
                              ? store.profileData["account"]
                              : "",
                          ),
                          focusNode: accountFocus,
                          hint: "Sua conta",
                          mask: masks.accountMask,
                          onChanged: (val) {
                            store.profileEdit["account"] = val;
                          },
                          onComplete: () => digitFocus.requestFocus(),
                        ),
                        ProfileDataTile(
                          title: 'Dígito',
                          textInputType: TextInputType.number,
                          data: masks.digitMask.maskText(
                            store.profileData["digit"] != null
                              ? store.profileData["digit"]
                              : "",
                          ),
                          focusNode: digitFocus,
                          hint: "Dígito da sua agência",
                          length: 1,
                          mask: masks.digitMask,
                          onChanged: (val) {
                            store.profileEdit["digit"] = val;
                          },
                          onComplete: () => pixKeyFocus.requestFocus(),
                        ),
                        CompositedTransformTarget(
                          link: pixLayerLink,
                          child: ProfileDataTile(
                            title: 'Chave PIX',
                            data: pixKeys[store.profileData["pix_key"]],
                            focusNode: pixKeyFocus,
                            hint: "Seu tipo de chave pix",
                            onPressed: () => pixKeyFocus.requestFocus(),
                            onComplete: () => pixFocus.requestFocus(),
                            validate: store.pixKeyValidate,
                          ),
                        ),
                        ProfileDataTile(
                          title: 'PIX',
                          data: getPixData(),
                          focusNode: pixFocus,
                          hint: "Seu pix",
                          onChanged: (val) {
                            // print("val: ${val!.length}");
                            // print("pix before: ${store.profileEdit["pix"]}");
                            print("val: $val");
                            print("pix_key: ${store.profileEdit["pix_key"]}");
                            if (store.profileEdit["pix_key"] == "CPF/CNPJ" &&
                                val != null &&
                                val.length == 12) {
                              print("val.length: ${val.length}");
                              _pixMask!.updateMask(mask: '##.###.###/####-##');
                            } else if (store.profileEdit["pix_key"] ==
                                    "CPF/CNPJ" &&
                                val != null &&
                                val.length <= 11) {
                              print("val.length: ${val.length}");
                              _pixMask!.updateMask(mask: '###.###.###-###');
                            }
                            // print("val: $val");
                            store.profileEdit["pix"] = val;
                            // print("pix after: ${store.profileEdit["pix"]}");
                          },
                          controller: pixEditController,
                          onComplete: () => pixFocus.unfocus(),
                          mask: _pixMask,
                          textInputType: 
                            store.profileData["pix_key"] != "EMAIL" && store.profileData["pix_key"] != "RANDOM" 
                            ? TextInputType.number
                            : null,
                          validator: (val) {
                            if (_pixMask != null) {
                              // print("pixMask: ${_pixMask!.getMask()}");
                            }
                            if (store.profileData["pix_key"] == "EMAIL") {
                              bool emailValid = RegExp(
                                      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{3,}))$')
                                  .hasMatch(val!);
                              // print("emailValid: $emailValid");

                              if (!emailValid) {
                                return 'Digite um e-mail válido!';
                              } else {
                                return null;
                              }
                            } else if (store.profileEdit["pix_key"] ==
                                    "CPF/CNPJ" &&
                                val != null) {
                              // print("val.length: ${val.length}");
                              if (_pixMask!.getMask() == "###.###.###-###") {
                                return val.length == 14
                                    ? null
                                    : "Digite o CPF corretamente!";
                              }
                              if (_pixMask!.getMask() == "##.###.###/####-##") {
                                return val.length == 18
                                    ? null
                                    : "Digite o CNPJ corretamente!";
                              }
                            } else if (store.profileEdit["pix_key"] ==
                                    "PHONE" &&
                                val != null) {
                              return val.length == 11
                                  ? null
                                  : "Digite o número de celular corretamente!";
                            }
                          },
                        ),
                        SizedBox(height: wXD(30, context)),
                        SideButton(
                            onTap: () async {
                              bool _validate = store.getValidate();
                              if (_formKey.currentState!.validate() &&
                                  _validate) {
                                await store.saveProfile(context);
                              }
                            },
                            height: wXD(52, context),
                            width: wXD(142, context),
                            title: 'Salvar'),
                        SizedBox(height: wXD(20, context)),
                      ],
                    ),
                  ),
                );
              },
            ),
            DefaultAppBar(
              'Editar perfil',
              onPop: () async {
                store.profileEdit.clear();
                WidgetsBinding.instance!
                    .addPostFrameCallback((timeStamp) async {
                  await store.setProfileEditFromDoc();
                });
                Modular.to.pop();
              },
            )
          ],
        ),
      ),
    );
  }
}

class SavingsCNPJ extends StatelessWidget {
  const SavingsCNPJ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: wXD(26, context),
        top: wXD(16, context),
        bottom: wXD(33, context),
      ),
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Esta é uma conta poupança?',
            style: textFamily(color: totalBlack.withOpacity(.6)),
          ),
          SizedBox(height: wXD(10, context)),
          Row(
            children: [
              Container(
                height: wXD(17, context),
                width: wXD(17, context),
                margin: EdgeInsets.only(right: wXD(9, context)),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: primary, width: wXD(2, context)),
                ),
                alignment: Alignment.center,
              ),
              Text(
                'Sim',
                style: textFamily(color: totalBlack.withOpacity(.6)),
              ),
              Container(
                height: wXD(17, context),
                width: wXD(17, context),
                margin: EdgeInsets.only(
                    right: wXD(9, context), left: wXD(15, context)),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: primary, width: wXD(2, context)),
                ),
                alignment: Alignment.center,
                child: Container(
                  height: wXD(9, context),
                  width: wXD(9, context),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: primary,
                  ),
                ),
              ),
              Text(
                'Não',
                style: textFamily(color: totalBlack.withOpacity(.6)),
              ),
            ],
          ),
          SizedBox(height: wXD(24, context)),
          Text(
            'Esta conta bancária está vinculada ao CNPJ da \nloja?',
            style: textFamily(color: totalBlack.withOpacity(.6)),
          ),
          SizedBox(height: wXD(10, context)),
          Row(
            children: [
              Container(
                height: wXD(17, context),
                width: wXD(17, context),
                margin: EdgeInsets.only(right: wXD(9, context)),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: primary, width: wXD(2, context)),
                ),
                alignment: Alignment.center,
              ),
              Text(
                'Sim',
                style: textFamily(color: totalBlack.withOpacity(.6)),
              ),
              Container(
                height: wXD(17, context),
                width: wXD(17, context),
                margin: EdgeInsets.only(
                    right: wXD(9, context), left: wXD(15, context)),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: primary, width: wXD(2, context)),
                ),
                alignment: Alignment.center,
                child: Container(
                  height: wXD(9, context),
                  width: wXD(9, context),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: primary,
                  ),
                ),
              ),
              Text(
                'Não',
                style: textFamily(color: totalBlack.withOpacity(.6)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
