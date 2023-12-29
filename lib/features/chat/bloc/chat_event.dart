part of 'chat_bloc.dart';

abstract class ChatEvent extends Equatable {
  const ChatEvent();

  @override
  List<Object> get props => [];
}

class SearchBirthdays extends ChatEvent {}

class SendMessage extends ChatEvent {
  final String message;
 

  const SendMessage({required this.message});

  @override
  // TODO: implement props
  List<Object> get props => super.props..addAll([message]);
}
class ChatGenearate extends ChatEvent {
  final String text;
   final bool stop;

  ChatGenearate({this.stop=false, required this.text});
}
