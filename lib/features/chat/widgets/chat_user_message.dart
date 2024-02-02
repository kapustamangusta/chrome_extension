import 'package:flutter/material.dart';

import 'chat_message.dart';

class ChatUserMessage extends StatelessWidget {
  const ChatUserMessage(
      {super.key,
      required this.colorText,
      required this.backgroundColor,
      required this.message});

  final Color colorText;
  final Color backgroundColor;
  final String message;

  @override
  Widget build(BuildContext context) {
    return ChatMessage(
      colorText: colorText,
      backgroundColor: backgroundColor,
      child: Text(
        message,
        style: TextStyle(
          fontSize: 16,
          color: colorText,
        ),
      ),
    );
  }
}
