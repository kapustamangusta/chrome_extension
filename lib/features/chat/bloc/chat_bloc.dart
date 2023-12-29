import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:extension_chrome/api/api.dart';

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

    on<ChatGenearate> (_onChatGenerate, transformer: restartable(),);
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
      final answer = await apiClient.getAnswer(event.message);
      add(ChatGenearate(text: answer));
    } catch (e) {
      emit(ChatFailure(error: e));
    }
  }

  Future<void> _onChatGenerate (
      ChatGenearate event, Emitter<ChatState> emit) async {
     for (int i = 0; i <= event.text.length; i++) {
        await Future.delayed(const Duration(milliseconds: 25));
        emit(ChatLoaded(answer: event.text.substring(0, i)));
      }
      emit(ChatInitial());
  }


  final ApiClient apiClient;
}
