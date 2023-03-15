class ChatModel {
  String? msg;
  int? chatIndex;

  ChatModel({
    this.msg,
    this.chatIndex,
  });

  factory ChatModel.fromJson(Map<String, dynamic> json) => ChatModel(
        msg: json['msg'],
        chatIndex: json['chatIndex'],
      );
}
