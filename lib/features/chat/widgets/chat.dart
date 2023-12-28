import 'package:extension_chrome/features/chat/chat.dart';
import 'package:flutter/material.dart';

class Chat extends StatelessWidget {
  const Chat({
    super.key,
    required this.chat,
  });

  final List<String> chat;

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
                return Align(
                  alignment: index % 2 != 0
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ChatMessage(
                        message: chat[index],
                        backgroundColor: index % 2 != 0
                            ? Colors.lightBlue
                            : Colors.lightGreen,
                        colorText: theme.primaryTextTheme.displayMedium!.color!,
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
