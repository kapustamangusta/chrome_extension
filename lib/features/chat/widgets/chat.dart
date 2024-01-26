import 'package:extension_chrome/api/models/chat_info.dart';
import 'package:extension_chrome/features/chat/chat.dart';
import 'package:flutter/material.dart';

class Chat extends StatelessWidget {
  const Chat({
    super.key,
    required this.chat,
  });

  final List<Messages> chat;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(8).copyWith(bottom: 0),
      child: SingleChildScrollView(
        reverse: true,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Row(),
            ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: chat.length,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return const SizedBox();
                } else {
                  return Align(
                    alignment: chat[index].role == "user"
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ChatMessage(
                          message: chat[index].content!,
                          
                          backgroundColor: index % 2 == 0
                              ? Colors.grey[300]!
                              : theme.primaryColor,
                          colorText:
                              index % 2 == 0 ? theme.primaryColor : Colors.white,
                        ),
                      ],
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
