part of 'chat_bloc.dart';

abstract class ChatState {
  const ChatState();

  // @override
  // List<Object> get props => [];
}

class ChatInitial extends ChatState {}

class ChatLoading extends ChatState {}

class ChatFailure extends ChatState {
  final Object error;

  const ChatFailure({required this.error});

  // @override
  // // TODO: implement props
  // List<Object> get props => super.props..add(error);
}

class ChatLoaded extends ChatState {
  final String answer;

  const ChatLoaded({required this.answer});
}

