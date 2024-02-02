import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:extension_chrome/api/api.dart';

import '../../../api/models/chat_info.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc({required this.apiClient}) : super(ChatInitial()) {
    on<SearchBirthdays>(
      _onSearchBirthdays,
    );
    on<SendMessage>(
      _onSendMessage,
    );
    on<LoadChatsInfo>(
      _onLoadChatsInfo,
    );
    on<ChatGenearate>(
      _onChatGenerate,
      transformer: restartable(),
    );

    on<ChangeChat>(
      (event, emit) async {
        try {
          if (event.idChat != "" && event.idChat!=null) {
            var chatInfo = await apiClient.getMessagesFromChat(
                event.uidClient, event.idChat);
            emit(ChatGettedInfo(messages: chatInfo));
          }
          emit(ChatInitial());
        } catch (e) {
          emit(ChatFailure(error: e));
        }
      },
    );
    on<DeleteChat>(
      _onDeleteChat,
    );
  }

  Future<void> _onDeleteChat(DeleteChat event, Emitter<ChatState> emit) async {
    try {
      await apiClient.deleteChat(event.uidClient, event.idChat);
      add(LoadChatsInfo(
        uidClient: event.uidClient,
      ));
    } catch (e) {
      emit(ChatFailure(error: e));
    }
  }

  Future<void> _onLoadChatsInfo(
      LoadChatsInfo event, Emitter<ChatState> emit) async {
    try {
      emit(ChatLoading());
      final chatsInfo =
          await apiClient.getAllMessagesFromChats(event.uidClient);
      emit(ChatsGettedInfo(chatsInfo: chatsInfo));
      emit(ChatInitial());
    } catch (e) {
      emit(ChatFailure(error: e));
    }
  }

  Future<void> _onSearchBirthdays(
      SearchBirthdays event, Emitter<ChatState> emit) async {
    try {
      emit(ChatLoading());
      final birthdays = await apiClient.getBirhdays();
      add(ChatGenearate(text: birthdays));
    } catch (e) {
      emit(ChatFailure(error: e));
    }
  }

  Future<void> _onSendMessage(
      SendMessage event, Emitter<ChatState> emit) async {
    try {
      emit(ChatLoading());
      if (event.chat.length == 1) {
        await apiClient.createChat(
          event.uidClient,
          event.message,
          <String, dynamic>{"prompt": event.message},
        );
      }
      var answer = await apiClient.sendMessage(
        event.uidClient,
        event.idChat ?? event.message,
        <String, dynamic>{"message": event.message},
      );
      add(LoadChatsInfo(
        uidClient: event.uidClient,
      ));
      add(ChatGenearate(text: answer));
    } catch (e) {
      emit(ChatFailure(error: e));
    }
  }

  Future<void> _onChatGenerate(
      ChatGenearate event, Emitter<ChatState> emit) async {
    for (int i = 0; i <= event.text.length; i++) {
      await Future.delayed(const Duration(milliseconds: 25));
      emit(ChatLoaded(answer: event.text.substring(0, i)));
    }
    emit(ChatInitial());
  }

  final ApiClient apiClient;
}
