import 'package:flutter/material.dart';

class ChatButton extends StatefulWidget {
  const ChatButton({super.key, this.onPressed, this.child});
  final Function()? onPressed;
  final Widget? child;
  @override
  State<ChatButton> createState() => _ChatButtonState();
}

class _ChatButtonState extends State<ChatButton> {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(8),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: theme.primaryColor,
              side: const BorderSide(width: 2, color: Colors.white)),
          onPressed: () async {
            if (widget.onPressed != null) {
              widget.onPressed!();
            }
          },
          child: widget.child),
    );
  }
}
