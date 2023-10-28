import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../../../shared/color_theme.dart';
import '../../../shared/utilities.dart';

class TypeEvaluation extends StatelessWidget {
  final String title;
  final String opinion;
  final String text;
  final double rating;
  final Function(String value) onChanged;

  TypeEvaluation({
    required this.title,
    required this.opinion,
    required this.text,
    required this.rating,
    required this.onChanged,
  });


  @override
  Widget build(BuildContext context) {
    // if(text.isNotEmpty){
    //   textEditingController.text = text;
    // }
    return Container(
      padding: EdgeInsets.fromLTRB(
        wXD(16, context),
        wXD(12, context),
        wXD(16, context),
        wXD(21, context),
      ),
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(color: darkGrey.withOpacity(.2)))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RatingBar(
            initialRating: rating,
            onRatingUpdate: (value) {},
            ignoreGestures: true,
            glowColor: primary.withOpacity(.4),
            unratedColor: primary.withOpacity(.4),
            allowHalfRating: true,
            itemSize: wXD(35, context),
            ratingWidget: RatingWidget(
              full: Icon(Icons.star_rounded, color: primary),
              empty:
                  Icon(Icons.star_outline_rounded, color: primary),
              half: Icon(Icons.star_half_rounded, color: primary),
            ),
          ),
          SizedBox(height: wXD(15, context)),
          Text(
            title,
            style: textFamily(
              color: totalBlack,
              fontSize: 14,
            ),
          ),
          Container(
            // height: wXD(52, context),
            width: wXD(343, context),
            decoration: BoxDecoration(
                border: Border.all(color: primary.withOpacity(.65)),
                borderRadius: BorderRadius.all(Radius.circular(11))),
            margin: EdgeInsets.only(top: wXD(16, context)),
            padding: EdgeInsets.symmetric(
                horizontal: wXD(11, context), vertical: wXD(10, context)),
            alignment: Alignment.topLeft,
            child: Text(
              opinion == "" ? "Sem opinião" : opinion,
              style: textFamily(
                  color: opinion == ""
                      ? textTotalBlack.withOpacity(.3)
                      : textTotalBlack,
                  fontWeight: FontWeight.w400,
                  fontSize: 14),
            ),
          ),
          SizedBox(height: wXD(20, context)),
          Row(
            children: [
              Text(
                'Responder',
                style: textFamily(
                  color: totalBlack,
                  fontSize: 14,
                ),
              ),
              Spacer(),
              Text(
                '${text.length}/300',
                style: textFamily(
                  color: darkGrey.withOpacity(.8),
                  fontSize: 13,
                ),
              ),
            ],
          ),
          Container(
            // height: wXD(52, context),
            width: wXD(343, context),
            decoration: BoxDecoration(
                border: Border.all(color: primary.withOpacity(.65)),
                borderRadius: BorderRadius.all(Radius.circular(11))),
            margin: EdgeInsets.only(top: wXD(16, context)),
            padding: EdgeInsets.symmetric(
                horizontal: wXD(10, context), vertical: wXD(13, context)),
            alignment: Alignment.topLeft,
            child: TextFormField(
              initialValue: text,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              // controller: textEditingController,
              decoration: InputDecoration.collapsed(
                hintText: 'Deixe sua resposta em relação à opinião',
                hintStyle: textFamily(
                  color: darkGrey.withOpacity(.55),
                  fontWeight: FontWeight.w400,
                ),
              ),
              onChanged: (String value){
                onChanged(value);
              },
              validator: (String? value){
                if(value == null || value.isEmpty){
                  return 'Campo obrigatório';
                } else {
                  return null;
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
