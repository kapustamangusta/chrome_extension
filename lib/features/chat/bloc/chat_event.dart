part of 'chat_bloc.dart';

abstract class ChatEvent extends Equatable {
  const ChatEvent();

  @override
  List<Object> get props => [];
}

class SearchBirthdays extends ChatEvent {}

class LoadChatsInfo extends ChatEvent {
  final String uidClient;

  const LoadChatsInfo({required this.uidClient});
}

class ChangeChat extends ChatEvent {}

class CreateChat extends ChatEvent {
  final String uidClient;
  final String promt;

  const CreateChat({required this.uidClient, required this.promt});
}

class DeleteChat extends ChatEvent{
  final String uidClient;
  final String idChat;

  const DeleteChat({required this.uidClient, required this.idChat});
}

class SendMessage extends ChatEvent {
  final List<Messages> chat;
  final String uidClient;
  final String? idChat;
  final String message;

  const SendMessage({this.idChat, required this.chat, required this.uidClient, required this.message});

  @override
  // TODO: implement props
  List<Object> get props => super.props..addAll([message]);
}

class ChatGenearate extends ChatEvent {
  final String text;
  final bool stop;

  const ChatGenearate({this.stop = false, required this.text});
}
