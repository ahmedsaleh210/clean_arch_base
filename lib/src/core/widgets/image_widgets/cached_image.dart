import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/src/config/res/app_sizes.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../../config/res/color_manager.dart';

class CachedImage extends StatelessWidget {
  final String url;
  final BoxFit? fit;
  final double? height, width, borderWidth;
  final BorderRadius? borderRadius;
  final ColorFilter? colorFilter;
  final Alignment? alignment;
  final Widget? child;
  final Widget? placeHolder;
  final Color? borderColor;
  final Color? bgColor;
  final BoxShape? boxShape;
  final bool haveRadius;
  const CachedImage(
      {super.key,
      required this.url,
      this.fit,
      this.width,
      this.height,
      this.placeHolder,
      this.borderRadius,
      this.colorFilter,
      this.alignment,
      this.child,
      this.boxShape,
      this.borderColor,
      this.borderWidth,
      this.bgColor,
      this.haveRadius = true});

  @override
  Widget build(BuildContext context) {
    final devicePixelRatio = MediaQuery.of(context).devicePixelRatio;
    return CachedNetworkImage(
      imageUrl: url,
      width: width,
      height: height,
      memCacheHeight: (height ?? AppSize.sH40 * devicePixelRatio).round(),
      memCacheWidth: (width ?? AppSize.sW40 * devicePixelRatio).round(),
      maxHeightDiskCache: (height ?? AppSize.sH40 * devicePixelRatio).round(),
      maxWidthDiskCache: (width ?? AppSize.sW40 * devicePixelRatio).round(),
      imageBuilder: (context, imageProvider) => Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: imageProvider,
              fit: fit ?? BoxFit.fill,
              colorFilter: colorFilter),
          borderRadius: haveRadius
              ? borderRadius ?? BorderRadius.circular(AppCircular.r2)
              : null,
          shape: boxShape ?? BoxShape.rectangle,
          border: Border.all(
            color: borderColor ?? Colors.transparent,
            width: borderWidth ?? 1,
          ),
        ),
        alignment: alignment ?? Alignment.center,
        child: child,
      ),
      placeholder: (context, url) => Container(
        width: width,
        height: height,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: haveRadius
              ? borderRadius ?? BorderRadius.circular(AppCircular.r2)
              : null,
          border:
              Border.all(color: borderColor ?? Colors.transparent, width: 1),
          shape: boxShape ?? BoxShape.rectangle,
          color: bgColor ?? ColorManager.primaryColor.withOpacity(.5),
        ),
        child: SpinKitFadingCircle(
          color: ColorManager.primaryColor,
          size: AppSize.sH30,
        ),
      ),
      errorWidget: (context, url, error) => Container(
        width: width,
        height: height,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: bgColor ?? ColorManager.primaryColor.withOpacity(.5),
          borderRadius: haveRadius
              ? borderRadius ?? BorderRadius.circular(AppCircular.r2)
              : null,
          border: Border.all(
            color: borderColor ?? Colors.transparent,
            width: 1,
          ),
          shape: boxShape ?? BoxShape.rectangle,
        ),
        child: Stack(
          children: [
            placeHolder ?? child ?? Container(),
            child ?? Container(),
          ],
        ),
      ),
    );
  }
}
