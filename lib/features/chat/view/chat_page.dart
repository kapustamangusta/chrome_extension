import 'package:extension_chrome/UI/ui.dart';
import 'package:extension_chrome/features/chat/bloc/chat_bloc.dart';
import 'package:extension_chrome/features/chat/chat.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
        child: BlocBuilder<ChatBloc, ChatState>(
          builder: (context, state) {
            if (state is ChatLoading) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(child: Chat(chat: chat)),
                  const CircularProgressIndicator(),
                  Container(
                    padding: const EdgeInsets.all(8),
                    child: ChatFormField(
                      controller: _chatController,
                      onClick: null,
                      onFieldSubmitted: null,
                      suffixIcon: Icon(
                        Icons.arrow_upward_sharp,
                        color: theme.primaryColor,
                      ),
                    ),
                  ),
                ],
              );
            }
            if (state is ChatLoaded) {
              if (chat.length % 2 == 1) chat.removeLast();
              chat.add(state.answer);
              return Column(
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(child: Chat(chat: chat)),
                  Container(
                    padding: const EdgeInsets.all(8),
                    child: ChatFormField(
                      controller: _chatController,
                      suffixIcon: Icon(
                        Icons.stop,
                        color: theme.primaryColor,
                      ),
                      onClick: () {
                        BlocProvider.of<ChatBloc>(context)
                            .add(ChatGenearate(text: "", stop: true));
                        _chatController.clear();
                      },
                    ),
                  ),
                ],
              );
            }
            if (state is ChatFailure) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(child: Chat(chat: chat)),
                  Text(
                    state.error.toString(),
                    style: const TextStyle(color: Colors.red),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: ChatButton(
                      onPressed: () {
                        chat.add("У кого сеодня ДР?");
                        BlocProvider.of<ChatBloc>(context)
                            .add(SearchBirthdays());
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
                      suffixIcon: Icon(
                        Icons.arrow_upward_sharp,
                        color: theme.primaryColor,
                      ),
                      onClick: () {
                        chat.add(_chatController.text);
                        BlocProvider.of<ChatBloc>(context)
                            .add(SendMessage(message: _chatController.text));
                        _chatController.clear();
                      },
                      onFieldSubmitted: (value) {
                        chat.add(_chatController.text);
                        BlocProvider.of<ChatBloc>(context)
                            .add(SendMessage(message: _chatController.text));
                        _chatController.clear();
                      },
                    ),
                  ),
                ],
              );
            }

            return Column(
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(child: Chat(chat: chat)),
                Align(
                  alignment: Alignment.centerRight,
                  child: ChatButton(
                    onPressed: () {
                      chat.add("У кого сеодня ДР?");
                      BlocProvider.of<ChatBloc>(context).add(SearchBirthdays());
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
                    suffixIcon: Icon(
                      Icons.arrow_upward_sharp,
                      color: theme.primaryColor,
                    ),
                    onClick: () {
                      chat.add(_chatController.text);
                      BlocProvider.of<ChatBloc>(context)
                          .add(SendMessage(message: _chatController.text));
                      _chatController.clear();
                    },
                    onFieldSubmitted: (value) {
                      chat.add(_chatController.text);
                      BlocProvider.of<ChatBloc>(context)
                          .add(SendMessage(message: _chatController.text));
                      _chatController.clear();
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
