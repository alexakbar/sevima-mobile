import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sevgram/components/commons/flat_card.dart';
import 'package:sevgram/r.dart';
import 'package:sevgram/utils/themes.dart';
import 'package:badges/badges.dart';
import 'package:sevgram/utils/responsive.dart';

class ItemImage extends StatelessWidget {
  final double width;
  final double height;
  final VoidCallback onTapBadge;
  final File image;

  const ItemImage({
    Key key,
    this.width,
    this.height,
    this.onTapBadge,
    this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Badge(
      badgeColor: Themes.red,
      elevation: 0,
      padding: EdgeInsets.zero,
      badgeContent: GestureDetector(
        onTap: onTapBadge,
        child: Container(
          color: Themes.transparent,
          padding: EdgeInsets.all(2.w()),
          child: SvgPicture.asset(
            AssetIcons.icCross,
            width: 16.w(),
            height: 16.w(),
          ),
        ),
      ),
      child: FlatCard(
        width: width != null ? width : 56.w(),
        height: height != null ? height : 56.w(),
        border: Border.all(color: Themes.stroke),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(
            4.w(),
          ),
          child: image != null
              ? Image.file(
                  image,
                  width: 56.w(),
                  height: 56.w(),
                  fit: BoxFit.cover,
                )
              : Image.asset(
                  AssetImages.placeholder,
                  width: 56.w(),
                  height: 56.w(),
                  fit: BoxFit.cover,
                ),
        ),
      ),
    );
  }
}
