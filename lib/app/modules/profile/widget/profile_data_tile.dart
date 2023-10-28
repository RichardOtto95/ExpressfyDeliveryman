import 'package:delivery_emissary/app/shared/color_theme.dart';
import 'package:delivery_emissary/app/shared/utilities.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class ProfileDataTile extends StatefulWidget {
  final String? Function(String?)? validator;

  final void Function(String?)? onChanged;
  final TextEditingController? controller;
  final MaskTextInputFormatter? mask;
  final void Function()? onPressed;
  final void Function()? onComplete;
  final FocusNode focusNode;
  final String title, hint;
  final bool? validate;
  final String? data;
  final int? length;
  final TextInputType? textInputType;

  const ProfileDataTile({
    Key? key,
    required this.focusNode,
    required this.title,
    required this.hint,
    this.onComplete,
    this.validator,
    this.onChanged,
    this.onPressed,
    this.validate,
    this.length,
    this.mask,
    this.data,
    this.controller,
    this.textInputType,
  }) : super(key: key);

  @override
  _ProfileDataTileState createState() => _ProfileDataTileState();
}

class _ProfileDataTileState extends State<ProfileDataTile> {
  String? _data;
  @override
  void initState() {
    if (widget.controller != null) {
      _data = null;
      widget.controller!.text = widget.data ?? "";
    } else {
      _data = widget.data;
    }
    super.initState();
  }

  @override
  Widget build(context) {
    return Listener(
      onPointerDown: (abc) => FocusScope.of(context).requestFocus(FocusNode()),
      child: Stack(
        children: [
          Container(
            width: maxWidth(context),
            // height: wXD(76, context),
            margin: EdgeInsets.symmetric(horizontal: wXD(23, context)),
            padding: EdgeInsets.fromLTRB(
              wXD(11, context),
              wXD(18, context),
              0,
              wXD(18, context),
            ),
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(color: darkGrey.withOpacity(.2)))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.title,
                  style: textFamily(
                    color: textTotalBlack,
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                // SizedBox(height: wXD(3, context)),
                widget.onPressed == null
                    ? Container(
                        width: wXD(321, context),
                        child: TextFormField(
                          keyboardType: widget.textInputType,
                          controller: widget.controller,
                          cursorColor: primary,
                          // ignore: deprecated_member_use
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          initialValue: _data,
                          focusNode: widget.focusNode,
                          inputFormatters:
                              widget.mask != null ? [widget.mask!] : [],
                          decoration: InputDecoration.collapsed(
                            hintText: widget.hint,
                            hintStyle: textFamily(
                              color: darkGrey,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          validator: (val) {
                            // print("Title: ${widget.title}   Val: $val");
                            String _text = '';
                            if (widget.mask != null) {
                              _text = widget.mask!.unmaskText(val ?? '');
                            } else {
                              _text = val ?? '';
                            }
                            // print("Text: $_text");
                            if (_text == '') {
                              return "Este campo não pode ser vazio!";
                            } else if (widget.length != null &&
                                widget.length != _text.length) {
                              return "Preencha o campo ${widget.title} por completo!";
                            }
                            if (widget.validator != null) {
                              String? value = widget.validator!(val);
                              if (value != null) {
                                return value;
                              }
                            }
                          },
                          onChanged: (txt) {
                            String _text = txt;
                            if (widget.mask != null) {
                              // print("unmasked: ${mask!.unmaskText(txt)}");
                              _text = widget.mask!.unmaskText(txt);
                            }
                            // print("_text: $_text");
                            widget.onChanged!(_text == '' ? null : _text);
                          },
                          onEditingComplete: widget.onComplete,
                        ),
                      )
                    : GestureDetector(
                        onTap: widget.onPressed,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Focus(
                              focusNode: widget.focusNode,
                              child: Container(
                                width: wXD(321, context),
                                child: Text(
                                  widget.data ?? widget.hint,
                                  style: textFamily(
                                    color: widget.data != null
                                        ? textBlack
                                        : darkGrey,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ),
                            // validate != null && validate!
                            //     ?
                            Visibility(
                              visible:
                                  widget.validate != null && widget.validate!,
                              child: Text(
                                "Este campo não pode ser vazio",
                                style: TextStyle(
                                  color: Colors.red[600],
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            // : Container(),
                          ],
                        ),
                      ),
              ],
            ),
          ),
          Positioned(
            top: wXD(18, context),
            right: wXD(20, context),
            child: InkWell(
              onTap: () => widget.onPressed == null
                  ? widget.focusNode.requestFocus()
                  : widget.onPressed!(),
              child: Icon(
                Icons.edit_outlined,
                color: primary,
                size: wXD(19, context),
              ),
            ),
          )
        ],
      ),
    );
  }
}
