import 'package:sevgram/utils/themes.dart';
import 'package:sevgram/utils/widget_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sevgram/components/commons/flat_card.dart';
import 'package:sevgram/utils/responsive.dart';
import 'package:google_fonts/google_fonts.dart';

class SuffixTextArea extends StatefulWidget {
  final String hint;
  final TextEditingController controller;
  final TextInputType inputType;
  final List<TextInputFormatter> inputFormatter;
  final bool secureInput;
  final int maxLenght;
  final Function(String value) onChangedText;
  final double width;
  final double height;
  final String suffix;
  final TextInputAction textInputAction;
  final Function(String value) onSubmitText;
  final bool enable;
  final Widget rightIcon;

  SuffixTextArea({
    Key key,
    this.suffix,
    this.hint,
    this.controller,
    this.inputType,
    this.secureInput = false,
    this.inputFormatter,
    this.maxLenght,
    this.onChangedText,
    this.width,
    this.height,
    this.onSubmitText,
    this.textInputAction,
    this.enable = true,
    this.rightIcon,
  }) : super(key: key);

  @override
  _SuffixTextAreaState createState() => _SuffixTextAreaState();
}

class _SuffixTextAreaState extends State<SuffixTextArea> {
  @override
  Widget build(BuildContext context) {
    return FlatCard(
      border: Border.all(color: Themes.stroke),
      width: widget.width,
      height: widget.height,
      child: Row(
        children: <Widget>[
          Flexible(
            child: Row(
              children: [
                Opacity(
                  opacity: widget.enable ? 1 : 0.4,
                  child: TextField(
                    enabled: widget.enable,
                    onSubmitted: widget.onSubmitText,
                    textInputAction: widget.textInputAction,
                    onChanged: (value) {
                      if (widget.onChangedText != null) {
                        widget.onChangedText(value);
                      }
                    },
                    controller: widget.controller,
                    keyboardType: widget.inputType,
                    style: GoogleFonts.overpass(fontSize: 14.f()),
                    inputFormatters: widget.inputFormatter,
                    maxLength: widget.maxLenght,
                    cursorColor: Themes.primary,
                    decoration: new InputDecoration.collapsed(
                      hintText: widget.hint,
                      hintStyle: GoogleFonts.overpass(
                        color: Color(0xff2a2a2a).withOpacity(0.3),
                      ),
                    ),
                  ),
                ).addMarginLeft(15.w()).addExpanded,
                if (widget.rightIcon != null) widget.rightIcon
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              border: Border(
                left: BorderSide(
                  color: Themes.stroke,
                ),
              ),
            ),
            child: CupertinoButton(
              padding: EdgeInsets.all(0),
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(0),
                bottomRight: Radius.circular(0),
                bottomLeft: Radius.circular(4.w()),
                topLeft: Radius.circular(4.w()),
              ),
              onPressed: () {},
              color: Themes.white,
              child: Container(
                padding: EdgeInsets.symmetric(
                  vertical: 16.h(),
                  horizontal: 18.w(),
                ),
                child: Text(
                  widget.suffix,
                  style: GoogleFonts.overpass(
                    color: Themes.black,
                    fontSize: 14.f(),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
