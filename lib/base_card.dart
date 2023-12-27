import 'package:flutter/material.dart';

class BaseCard extends StatelessWidget {
  final double? height;
  final double? width;
  final Widget? child;
  final EdgeInsets? padding;
  const BaseCard({super.key, this.height, this.width, this.child, this.padding});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: theme.primaryColor,
        ),
        boxShadow: [
          BoxShadow(
            color: theme.primaryColor,
            blurRadius: 5,
            blurStyle: BlurStyle.outer,
          )
        ],
      ),
      width: width,
      height: height,
      child: child,
    );
  }
}
