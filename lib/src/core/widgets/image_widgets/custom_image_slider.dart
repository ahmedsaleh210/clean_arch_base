import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/src/core/extensions/padding_extension.dart';
import 'package:flutter_base/src/core/extensions/sized_box_helper.dart';
import 'package:flutter_base/src/core/res/color_manager.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../image_widgets/cached_image.dart';

class ImageSlider extends StatefulWidget {
  final Color? activeColor;
  final Color? inActiveColor;
  final List<String> images;
  final double? height;
  const ImageSlider(
      {super.key,
      required this.images,
      this.activeColor,
      this.inActiveColor,
      this.height});

  @override
  State<ImageSlider> createState() => _ImageSliderState();
}

class _ImageSliderState extends State<ImageSlider> {
  final ValueNotifier<int> _currentIndex = ValueNotifier<int>(0);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CarouselSlider.builder(
          itemCount: widget.images.length,
          itemBuilder:
              (BuildContext context, int itemIndex, int pageViewIndex) {
            return CachedImage(
              width: 1.sw,
              borderRadius: BorderRadius.circular(16),
              url: widget.images[itemIndex],
            ).paddingSymmetric(horizontal: 16.w);
          },
          options: CarouselOptions(
            height: widget.height ?? 200.h,
            aspectRatio: 16 / 9,
            viewportFraction: 1,
            initialPage: 0,
            enableInfiniteScroll: true,
            reverse: false,
            autoPlay: true,
            onPageChanged: (index, reason) {
              _currentIndex.value = index;
            },
            autoPlayInterval: const Duration(seconds: 3),
            autoPlayAnimationDuration: const Duration(milliseconds: 800),
            autoPlayCurve: Curves.fastOutSlowIn,
            pauseAutoPlayOnTouch: true,
          ),
        ),
        15.szH,
        ValueListenableBuilder(
          valueListenable: _currentIndex,
          builder: (context, value, child) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: widget.images.map((url) {
                final index = widget.images.indexOf(url);
                final isActive = index == value;
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width: isActive ? 25.w : 8.w,
                  height: 8.h,
                  margin: EdgeInsets.symmetric(horizontal: 2.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: isActive
                        ? widget.activeColor ?? ColorManager.primary
                        : widget.inActiveColor ?? Colors.grey,
                  ),
                );
              }).toList(),
            );
          },
        )
      ],
    );
  }
}