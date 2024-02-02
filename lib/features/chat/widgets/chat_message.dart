import 'package:flutter/material.dart';

class ChatMessage extends StatelessWidget {
  const ChatMessage({
    super.key,
    this.colorText = Colors.black,
    this.backgroundColor = Colors.white,
    this.child,
  });
  final Color colorText;
  final Color backgroundColor;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Container(
      constraints: const BoxConstraints(
        maxWidth: 300,
      ),
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: theme.primaryColor,
        ),
      ),
      child: child
    );
  }
}
