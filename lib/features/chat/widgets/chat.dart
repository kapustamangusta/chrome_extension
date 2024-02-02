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
    return ClipRect(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
        ),
        
        margin: const EdgeInsets.all(8),
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
                          chat[index].role == "user" ?
                          ChatUserMessage(
                            message: chat[index].content!,
                            backgroundColor: 
                                theme.primaryColor,
                            colorText:
                                Colors.white,
                          ) :
                          ChatBotMessage(
                            message: chat[index].content!,
                            backgroundColor: 
                                theme.colorScheme.secondary,
                            colorText:
                                theme.textTheme.displayMedium!.color!,
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
      ),
    );
  }
}
