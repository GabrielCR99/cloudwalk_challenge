import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CustomShimmer extends StatelessWidget {
  final double height;
  final double width;
  final Color? baseColor;
  final Color? highlightColor;
  final bool isRounded;
  final BorderRadius? borderRadius;

  const CustomShimmer({
    required this.height,
    required this.width,
    this.baseColor,
    this.highlightColor,
    this.isRounded = false,
    this.borderRadius,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: baseColor ?? Colors.grey.shade800,
      highlightColor: highlightColor ?? Colors.grey.shade500,
      child: ListTile(
        title: Container(
          width: width,
          height: height,
          margin: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: isRounded
                ? borderRadius ?? BorderRadius.circular(height / 2)
                : null,
          ),
        ),
        subtitle: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: isRounded
                ? borderRadius ?? BorderRadius.circular(height / 2)
                : null,
          ),
        ),
      ),
    );
  }
}
