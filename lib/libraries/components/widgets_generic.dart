import 'package:flutter/material.dart';
import 'package:technical_test_meddi_yosidey/libraries/app_data.dart' as app_data;
import 'package:technical_test_meddi_yosidey/libraries/utilities/displayInfo.dart';

Center loadingIndicator() => const Center(child: CircularProgressIndicator());

Icon visibility(bool isObscure) => Icon((isObscure) ? Icons.visibility_off : Icons.visibility, color: Colors.black);

FadeInImage fadeImage({required BuildContext context,required String image,double? size}) => FadeInImage(
      image: NetworkImage(image),
      fit: BoxFit.contain,
      placeholder: const AssetImage(app_data.loadingGif),
      placeholderFit: BoxFit.contain,
      imageErrorBuilder: (context, error, stackTrace) {
        return Image.asset(app_data.notImage, fit: BoxFit.contain);
      },
    height: size,width: size
    );




Hero heroImage({required BuildContext context, required String image, required bool enabled}) =>Hero(
  tag: image,
  child: InkWell(
    onTap: () {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            contentPadding: EdgeInsets.zero,
            content: fadeImage(
              context: context,
              image:image,
              size: displayDensity(context) * 0.25,
            ),
          );
        },
      );
    },
    child: Badge(
      smallSize: 24,
      backgroundColor: enabled? Colors.green : Colors.red,
      alignment: Alignment.bottomRight,
      child: ClipOval(
        child: fadeImage(
          context: context,
          image: image,
          size: displayDensity(context) * 0.06,
        ),
      ),
    ),
  ),
);