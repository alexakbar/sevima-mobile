import 'package:sevgram/utils/responsive.dart';
import 'package:sevgram/utils/themes.dart';
import 'package:flutter/material.dart';

class OptionsDialog extends StatelessWidget {
  final title;
  final List<String> options;
  final Function(String value) onOptionSelected;

  OptionsDialog({
    Key key,
    this.title,
    this.options,
    this.onOptionSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.transparent,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.w()),
          ),
          padding: EdgeInsets.all(24.w()),
          width: 80.wp(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                title != null ? title : "Pilihan",
                style: Themes().blackBold18,
              ),
              Container(
                margin: EdgeInsets.only(top: 8.h()),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: options.map((e) {
                    return GestureDetector(
                      onTap: () {
                        onOptionSelected(e);
                      },
                      child: Container(
                        color: Colors.white,
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(
                          vertical: 8.h(),
                        ),
                        child: Text(
                          e,
                          style: Themes().black16,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
