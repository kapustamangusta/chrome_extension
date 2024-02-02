import 'package:flutter/material.dart';

class BaseCard extends StatelessWidget {
  final double? height;
  final double? width;
  final Widget? child;
  final EdgeInsets? padding;
  final BorderRadius? borderRadius;
  final Color? color;
  const BaseCard(
      {super.key,
      this.borderRadius,
      this.height,
      this.width,
      this.child,
      this.padding, this.color});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Container(
      
      padding: padding,
      decoration: BoxDecoration(
          color: color ?? Colors.grey[200],
          borderRadius: borderRadius ?? BorderRadius.circular(16),
          border: null),
      width: width,
      height: height,
      child: child,
    );
  }
}
