import 'package:dio/dio.dart';
import 'package:extension_chrome/UI/ui.dart';
import 'package:flutter/material.dart';

import '../widgets/chat.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _chatController = TextEditingController();

  List<String> chat = [
    'Привет! Если у тебя возникли вопросы о наших курсах или ты хочешь узнать больше о том, как зарегистрироваться, я готов помочь.'
  ];
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      body: BaseCard(
        padding: const EdgeInsets.symmetric(vertical: 16),
        //height: 700,
        width: 600,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              child: Chat(chat: chat),
            ),
            loading
                ? const CircularProgressIndicator()
                : Align(
                    alignment: Alignment.centerRight,
                    child: ChatButton(
                      onPressed: () async {
                        setState(() {
                          loading = true;
                          chat.add('У кого сегодня ДР?');
                        });

                        var dio = Dio();

                        final responce = await dio.get(
                          'http://localhost:5253/birthdays',
                        );
                        setState(() {
                          loading = false;
                        });

                        String mes = responce.data.toString();
                        chat.add("");

                        for (int i = 0; i <= mes.length; i++) {
                          await Future.delayed(
                              const Duration(milliseconds: 50));
                          setState(() {
                            chat.removeLast();
                            chat.add(mes.substring(0, i));
                          });
                        }
                      },
                      child: Text(
                        "Дни рождения",
                        style: TextStyle(
                            color: theme.primaryTextTheme.bodyMedium!.color),
                      ),
                    ),
                  ),
            Container(
              padding: const EdgeInsets.all(8),
              child: ChatFormField(
                controller: _chatController,
                onClick: loading
                    ? null
                    : () async {
                        setState(() {
                          loading = true;
                          chat.add(_chatController.text);
                        });

                        var dio = Dio();

                        final responce = await dio.post(
                          'http://localhost:5253/send-message?question=${_chatController.text== ''  ? "a" : _chatController.text}',
                        );
                        setState(() {
                          _chatController.clear();
                        });
                        String mes = responce.data.toString();
                        chat.add("");

                        for (int i = 0; i <= mes.length; i++) {
                          await Future.delayed(
                              const Duration(milliseconds: 50));
                          setState(() {
                            chat.removeLast();
                            chat.add(mes.substring(0, i));
                          });
                        }
                        setState(() {
                          loading = false;
                        });
                      },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
