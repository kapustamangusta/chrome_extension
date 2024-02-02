import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'chat_message.dart';

class ChatBotMessage extends StatelessWidget {
  const ChatBotMessage(
      {super.key,
      required this.colorText,
      required this.backgroundColor,
      required this.message});

  final Color colorText;
  final Color backgroundColor;
  final String message;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return ChatMessage(
      colorText: colorText,
      backgroundColor: backgroundColor,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            message,
            style: TextStyle(
              fontSize: 16,
              color: colorText,
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 4.0).copyWith(bottom: 0),
            child: const Divider(
              color: Colors.grey,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                onPressed: () {
                  Clipboard.setData( ClipboardData(text: message));
                },
                icon: Icon(
                  Icons.copy,
                  
                  color: theme.primaryColor,
                ),
                tooltip: "Копировать текст",
              ),
            ],
          )
        ],
      ),
    );
  }
}
