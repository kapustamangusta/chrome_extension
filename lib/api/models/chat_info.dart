class ChatInfo {
  String? chatNumber;
  String? uidClient;
  List<Messages>? messages;

  ChatInfo({this.chatNumber, this.uidClient, this.messages});

  ChatInfo.fromJson(Map<String, dynamic> json) {
    chatNumber = json['chat_number'];
    uidClient = json['uid_client'];
    if (json['messages'] != null) {
      messages = <Messages>[];
      json['messages'].forEach((v) {
        messages!.add(new Messages.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['chat_number'] = this.chatNumber;
    data['uid_client'] = this.uidClient;
    if (this.messages != null) {
      data['messages'] = this.messages!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Messages {
  String? role;
  String? content;

  Messages({this.role, this.content});

  Messages.fromJson(Map<String, dynamic> json) {
    role = json['role'];
    content = json['content'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['role'] = this.role;
    data['content'] = this.content;
    return data;
  }
}