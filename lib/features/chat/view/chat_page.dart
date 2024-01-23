import 'package:extension_chrome/UI/ui.dart';
import 'package:extension_chrome/features/chat/bloc/chat_bloc.dart';
import 'package:extension_chrome/features/chat/chat.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../api/models/models.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _chatController = TextEditingController();

  String? idChat;
  String uidClient = "1";
  List<ChatInfo> chatsInfo = [];
  bool loading = false;

  @override
  void initState() {
    BlocProvider.of<ChatBloc>(context).add(LoadChatsInfo(uidClient: uidClient));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      body: BaseCard(
        padding: const EdgeInsets.symmetric(vertical: 16),
        //height: 700,
        width: 600,
        child: BlocConsumer<ChatBloc, ChatState>(
          listener: (context, state) {
            if (state is ChatGettedInfo) {
              chatsInfo = state.chatsInfo;
            }
          },
          builder: (context, state) {
            var info = chatsInfo
                .where((element) => element.chatNumber == idChat)
                .firstOrNull;
            var chat = info != null ? info.messages! : <Messages>[];
            if (state is ChatLoading) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: Chat(
                      chat: chat,
                    ),
                  ),
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
              chat.add(Messages(role: "system", content: state.answer));
              return Column(
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    padding: const EdgeInsets.only(left: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ChatsDropdownButton(
                          items: chatsInfo,
                          selectedValue: info,
                          onSelected: null,
                          onCreateChat: null,
                          onDeleteChat: null,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Chat(
                      chat: info != null ? info.messages! : [],
                    ),
                  ),
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
                            .add(const ChatGenearate(text: "", stop: true));
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
                  Container(
                    padding: const EdgeInsets.only(left: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ChatsDropdownButton(
                          items: chatsInfo,
                          selectedValue: info,
                          onSelected: (chatInfo) {
                            idChat = chatInfo.chatNumber;

                            BlocProvider.of<ChatBloc>(context)
                                .add(ChangeChat());
                          },
                          onCreateChat: () {
                            idChat = null;
                            BlocProvider.of<ChatBloc>(context)
                                .add(ChangeChat());
                          },
                          onDeleteChat: (chatInfo) {
                            if (chatInfo.chatNumber != idChat) {
                              BlocProvider.of<ChatBloc>(context).add(
                                DeleteChat(
                                    uidClient: uidClient,
                                    idChat: chatInfo.chatNumber!),
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Chat(
                      chat: info != null ? info.messages! : [],
                    ),
                  ),
                  Text(
                    state.error.toString(),
                    style: const TextStyle(color: Colors.red),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: ChatButton(
                      onPressed: () {
                        //chat.add("У кого сеодня ДР?");
                        BlocProvider.of<ChatBloc>(context)
                            .add(SearchBirthdays());
                      },
                      child: Text(
                        "Дни рождения",
                        style: TextStyle(color: theme.primaryColor),
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
                        chat.add(Messages(
                            role: "user", content: _chatController.text));
                        BlocProvider.of<ChatBloc>(context).add(SendMessage(
                            idChat: idChat,
                            chat: chat,
                            uidClient: uidClient,
                            message: _chatController.text));
                        if (chat.length == 1) idChat = _chatController.text;
                        _chatController.clear();
                      },
                      onFieldSubmitted: (value) {
                        chat.add(Messages(
                            role: "user", content: _chatController.text));
                        BlocProvider.of<ChatBloc>(context).add(SendMessage(
                            idChat: idChat,
                            chat: chat,
                            uidClient: uidClient,
                            message: _chatController.text));
                        if (chat.length == 1) idChat = _chatController.text;
                        _chatController.clear();
                      },
                    ),
                  ),
                ],
              );
            }
            if (state is ChatInitial) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    padding: const EdgeInsets.only(left: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ChatsDropdownButton(
                          items: chatsInfo,
                          selectedValue: info,
                          onSelected: (chatInfo) {
                            idChat = chatInfo.chatNumber;

                            BlocProvider.of<ChatBloc>(context)
                                .add(ChangeChat());
                          },
                          onCreateChat: () {
                            idChat = null;
                            BlocProvider.of<ChatBloc>(context)
                                .add(ChangeChat());
                          },
                          onDeleteChat: (chatInfo) {
                            if (chatInfo.chatNumber != idChat) {
                              BlocProvider.of<ChatBloc>(context).add(
                                DeleteChat(
                                    uidClient: uidClient,
                                    idChat: chatInfo.chatNumber!),
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Chat(
                      chat: info != null ? info.messages! : [],
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: ChatButton(
                      onPressed: () {
                        //chat.add("У кого сеодня ДР?");
                        BlocProvider.of<ChatBloc>(context)
                            .add(SearchBirthdays());
                      },
                      child: Text(
                        "Дни рождения",
                        style: TextStyle(color: theme.primaryColor),
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
                        chat.add(Messages(
                            role: "user", content: _chatController.text));
                        BlocProvider.of<ChatBloc>(context).add(SendMessage(
                            idChat: idChat,
                            chat: chat,
                            uidClient: uidClient,
                            message: _chatController.text));
                        if (chat.length == 1) idChat = _chatController.text;
                        _chatController.clear();
                      },
                      onFieldSubmitted: (value) {
                        chat.add(Messages(
                            role: "user", content: _chatController.text));
                        BlocProvider.of<ChatBloc>(context).add(SendMessage(
                            idChat: idChat,
                            chat: chat,
                            uidClient: uidClient,
                            message: _chatController.text));
                        if (chat.length == 1) idChat = _chatController.text;
                        _chatController.clear();
                      },
                    ),
                  ),
                ],
              );
            }
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
