import 'package:flutter/material.dart';
import 'package:sevgram/components/buttons/ripple_button.dart';
import 'package:sevgram/components/commons/line.dart';
import 'package:sevgram/data/services/entities/posts_response.dart';
import 'package:sevgram/utils/responsive.dart';
import 'package:sevgram/utils/themes.dart';
import 'package:sevgram/utils/widget_helper.dart';

class ItemComment extends StatelessWidget {
  final Comment comment;

  const ItemComment({
    Key key,
    @required this.comment,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RippleButton(
          color: Themes.white,
          onTap: () {},
          radius: 0,
          padding: EdgeInsets.all(14.w()),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 32.w(),
                height: 32.w(),
                decoration: BoxDecoration(
                  color: Themes.primary,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    comment.user.fullname.substring(0, 1).toUpperCase(),
                    style: Themes().whiteBold18,
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        comment.user.fullname,
                        style: Themes().blackBold16,
                      ),
                      Text(
                        "@${comment.user.username}",
                        style: Themes().gray14,
                      ).addMarginLeft(6.w()),
                    ],
                  ),
                  Text(
                    comment.text,
                    style: Themes(withLineHeight: true).black14,
                  ),
                ],
              ).addMarginLeft(12.w()),
            ],
          ),
        ),
        Line(),
      ],
    );
  }
}
