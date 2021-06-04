import 'package:sevgram/components/commons/flat_card.dart';
import 'package:sevgram/utils/responsive.dart';
import 'package:sevgram/utils/themes.dart';
import 'package:sevgram/utils/tools.dart';
import 'package:sevgram/utils/widget_helper.dart';
import 'package:flutter/material.dart';

import 'package:flutter_svg/svg.dart';

class FlatDropDown extends StatefulWidget {
  final String selected;
  final dynamic selectedValue;
  final String hint;
  final Color iconColor;
  final double iconSize;
  final List<String> icons;
  final List<String> menu;
  final List<dynamic> value;
  final Function(DropDownItem value) onSelected;
  final double width;
  final double height;
  final Color color;
  final Border border;
  final bool enable;
  final Widget icon;

  FlatDropDown({
    Key key,
    this.iconColor,
    this.iconSize = 18,
    this.icons = const [],
    this.menu = const [],
    this.value = const [],
    this.hint,
    this.onSelected,
    this.width,
    this.height,
    this.color,
    this.border,
    this.selected,
    this.selectedValue,
    this.enable = true,
    this.icon,
  }) : super(key: key);

  @override
  _FlatDropDownState createState() => _FlatDropDownState();
}

class DropDownItem {
  String icon;
  String title;
  dynamic value;

  DropDownItem({
    this.icon,
    this.title,
    this.value,
  });
}

class _FlatDropDownState extends State<FlatDropDown> {
  BuildContext context;
  DropDownItem selected;
  List<DropDownItem> items = [];
  Widget icon;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    this.context = context;

    icon = widget.icon;

    items.clear();
    for (int i = 0; i < widget.menu.length; i++) {
      items.add(
        DropDownItem(
          icon: widget.icons.length == widget.menu.length
              ? widget.icons[i]
              : null,
          title: widget.menu[i],
          value: widget.value[i],
        ),
      );
    }

    if (widget.selected != null || widget.selectedValue != null) {
      for (DropDownItem dropDownItem in items) {
        if (widget.selectedValue != null) {
          if (widget.selected == dropDownItem.title &&
              widget.selectedValue == dropDownItem.value) {
            setState(() {
              selected = dropDownItem;
            });
          }
        } else {
          if (widget.selected == dropDownItem.title) {
            setState(() {
              selected = dropDownItem;
            });
          }
        }
      }
    } else {
      selected = null;
    }

    if (icon == null) {
      // icon = SvgPicture.asset(
      //   AssetIcons.caretDown,
      //   width: 24.w(),
      //   height: 24.w(),
      //   color: Themes.black.withOpacity(0.5),
      // );
    }

    return IgnorePointer(
      ignoring: !widget.enable,
      child: FlatCard(
        border: widget.border,
        color: widget.color,
        width: widget.width,
        height: widget.height,
        child: Opacity(
          opacity: widget.enable ? 1 : 0.4,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 16.w(),
              vertical: 6.h(),
            ),
            child: Center(
              child: DropdownButton(
                value: selected,
                icon: icon,
                underline: Container(),
                isExpanded: true,
                hint: Text(
                  widget.hint,
                  style: Themes().blackOpacity14,
                ),
                items: items.map((DropDownItem dropDownItem) {
                  return DropdownMenuItem(
                    value: dropDownItem,
                    child: Row(
                      children: [
                        if (dropDownItem.icon != null)
                          SvgPicture.asset(
                            dropDownItem.icon,
                            color: widget.iconColor,
                            width: widget.iconSize.w(),
                            fit: BoxFit.contain,
                          ),
                        Text(
                          dropDownItem.title,
                          style: Themes().black14,
                        ).addMarginLeft(dropDownItem.icon != null ? 12.w() : 0),
                      ],
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  Tools.closeKeyboard(context);
                  setState(() {
                    selected = value;
                  });
                  widget.onSelected(value);
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
