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
  List<Messages> messages = [];

  @override
  void initState() {
    BlocProvider.of<ChatBloc>(context).add(LoadChatsInfo(uidClient: uidClient));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      body: BlocConsumer<ChatBloc, ChatState>(
        listener: (context, state) {
          if (state is ChatsGettedInfo) {
            chatsInfo = state.chatsInfo;
            var curentChat = chatsInfo
                .where((element) => element.chatNumber == idChat)
                .firstOrNull;
            messages = curentChat == null ? [] : curentChat.messages!;
          }
          if (state is ChatGettedInfo) {
            messages = state.messages;
          }
        },
        builder: (context, state) {
          var currentChat = chatsInfo
              .where((element) => element.chatNumber == idChat)
              .firstOrNull;
          if (state is ChatLoading) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: Chat(
                    chat: messages,
                  ),
                ),
                LinearProgressIndicator(
                  color: theme.primaryColor,
                ),
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
            if (messages.length % 2 == 1) messages.removeLast();
            messages.add(Messages(role: "system", content: state.answer));
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
                        selectedValue: currentChat,
                        onSelected: null,
                        onCreateChat: null,
                        onDeleteChat: null,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Chat(
                    chat: messages,
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
                        selectedValue: currentChat,
                        onSelected: (chatInfo) {
                          _selectChat(chatInfo, context);
                        },
                        onCreateChat: () {
                          _createChat(context);
                        },
                        onDeleteChat: (chatInfo) {
                          deleteChat(chatInfo, context);
                        },
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Chat(
                    chat: messages,
                  ),
                ),
                Text(
                  state.error.toString(),
                  style: TextStyle(color: theme.primaryColor),
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
                        _sendMessage(context);
                      },
                      onFieldSubmitted: (value) {
                        _sendMessage(context);
                      }),
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
                        selectedValue: currentChat,
                        onSelected: (chatInfo) {
                          _selectChat(chatInfo, context);
                        },
                        onCreateChat: () {
                          _createChat(context);
                        },
                        onDeleteChat: (chatInfo) {
                          deleteChat(chatInfo, context);
                        },
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Chat(
                    chat: messages,
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
                      _sendMessage(context);
                    },
                    onFieldSubmitted: (value) {
                      _sendMessage(context);
                    },
                  ),
                ),
              ],
            );
          }
          return LinearProgressIndicator(
            color: theme.primaryColor,
          );
        },
      ),
    );
  }

  void deleteChat(ChatInfo chatInfo, BuildContext context) {
    if (chatInfo.chatNumber != idChat) {
      BlocProvider.of<ChatBloc>(context).add(
        DeleteChat(uidClient: uidClient, idChat: chatInfo.chatNumber!),
      );
    }
  }

  void _selectChat(ChatInfo chatInfo, BuildContext context) {
    idChat = chatInfo.chatNumber;

    BlocProvider.of<ChatBloc>(context)
        .add(ChangeChat(uidClient: uidClient, idChat: chatInfo.chatNumber!));
  }

  void _createChat(BuildContext context) {
    idChat = null;
    messages = [];
    BlocProvider.of<ChatBloc>(context)
        .add(ChangeChat(uidClient: uidClient, idChat: ""));
  }

  void _sendMessage(BuildContext context) {
    messages.add(Messages(role: "user", content: _chatController.text));
    BlocProvider.of<ChatBloc>(context).add(SendMessage(
        idChat: idChat,
        chat: messages,
        uidClient: uidClient,
        message: _chatController.text));
    if (messages.length == 1) {
      idChat = _chatController.text;
    }

    _chatController.clear();
  }
}
