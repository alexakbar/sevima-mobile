import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sevgram/components/buttons/primary_button.dart';
import 'package:sevgram/components/dialog/options_dialog.dart';
import 'package:sevgram/components/items/item_image.dart';
import 'package:sevgram/r.dart';
import 'package:sevgram/utils/themes.dart';
import 'package:sevgram/utils/widget_helper.dart';
import 'package:sevgram/utils/responsive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class CardImagePicker extends StatefulWidget {
  final String hint;
  final bool cameraOnly;
  final String imageUrl;
  final List<File> currentImages;
  final Function(List<File> images) onImagePicked;

  CardImagePicker({
    Key key,
    this.hint,
    this.currentImages,
    this.onImagePicked,
    this.imageUrl,
    this.cameraOnly = false,
  }) : super(key: key);

  @override
  _CardImagePickerState createState() => _CardImagePickerState();
}

class _CardImagePickerState extends State<CardImagePicker> {
  List<File> images = [];

  @override
  void initState() {
    super.initState();
    if (widget.currentImages != null) {
      images.addAll(widget.currentImages);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 12.h()),
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          if (images.isNotEmpty)
            Row(
              children: images.map((e) {
                return ItemImage(
                  image: e,
                  width: 120.w(),
                  height: 120.w(),
                  onTapBadge: () {
                    setState(() {
                      e.deleteSync();
                      images.remove(e);
                      widget.onImagePicked(images);
                    });
                  },
                ).addMarginRight(12.w());
              }).toList(),
            )
          else
          if(widget.imageUrl == null)
            SizedBox(
              width: 120.w(),
              height: 120.w(),
              child: PrimaryButton(
                elevateButtonOnTap: false,
                padding: EdgeInsets.symmetric(
                  vertical: 16.h(),
                ),
                borderColor: Themes.stroke,
                lightButton: true,
                onTap: () async {
                  var status = await Permission.camera.status;
                  if (status.isDenied) {
                    Map<Permission, PermissionStatus> statuses = await [
                      Permission.location,
                      Permission.storage,
                      Permission.camera,
                    ].request();
                  }

                  await pickImage(context);
                },
                color: Colors.white,
                child: SvgPicture.asset(
                  AssetIcons.icCameraPlus,
                ),
              ),
            )
            else
            ItemImage(
                  imageUrl: widget.imageUrl,
                  width: 120.w(),
                  height: 120.w(),
                  onTapBadge: () {
                    setState(() {
                      
                      widget.onImagePicked(images);
                    });
                  },
                ).addMarginRight(12.w())
        ],
      ),
    );
  }

  Future pickImage(BuildContext context) async {
    if (widget.cameraOnly) {
      var image = await ImagePicker().getImage(
        source: ImageSource.camera,
        maxWidth: 1200,
        maxHeight: 1200,
      );

      if (image != null) {
        setState(() {
          images.add(File(image.path));
        });
      }
    } else {
      showDialog(
        context: context,
        builder: (dialogContext) => OptionsDialog(
          title: "Pilih Gambar",
          options: [
            "Ambil dengan kamera",
            "Pilih dari gallery",
          ],
          onOptionSelected: (value) async {
            Navigator.pop(context);
            switch (value) {
              case "Ambil dengan kamera":
                PickedFile image = await ImagePicker().getImage(
                  source: ImageSource.camera,
                  maxWidth: 1200,
                  maxHeight: 1200,
                );

                if (image != null) {
                  setState(() {
                    images.add(File(image.path));
                    widget.onImagePicked(images);
                  });
                }
                break;
              case "Pilih dari gallery":
                var image = await ImagePicker().getImage(
                  source: ImageSource.gallery,
                  maxWidth: 1200,
                  maxHeight: 1200,
                );

                if (image != null) {
                  setState(() {
                    images.add(File(image.path));
                    widget.onImagePicked(images);
                  });
                }
                break;
            }
          },
        ),
      );
    }
  }
}
