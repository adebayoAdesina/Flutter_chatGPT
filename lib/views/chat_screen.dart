import 'package:chatgpt/constant/app_color.dart';
import 'package:chatgpt/constant/app_image.dart';
import 'package:chatgpt/models/chat_model.dart';
import 'package:chatgpt/services/api_service.dart';
import 'package:chatgpt/store/model_provider.dart';
import 'package:chatgpt/util/utils.dart';
import 'package:chatgpt/widgets/chat_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  bool _isTyping = true;
  TextEditingController? _controller;
  late FocusNode focusNode;
  late ScrollController _listScroll;
  @override
  void initState() {
    _controller = TextEditingController();
    focusNode = FocusNode();
    _listScroll = ScrollController();
    super.initState();
  }

  List<ChatModel> chatList = [];

  @override
  void dispose() {
    _controller!.dispose();
    focusNode.dispose();
    _listScroll.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        actions: [
          IconButton(
              onPressed: () async {
                await Utils.showModelSheet(context);
              },
              icon: const Icon(
                Icons.more_vert_outlined,
                color: Colors.white,
              ))
        ],
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(
            AppImages.openAiLogoColored,
          ),
        ),
        title: const Text('chatGPT'),
      ),
      body: SafeArea(
          child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _listScroll,
              shrinkWrap: true,
              itemCount: chatList.length,
              itemBuilder: (context, index) {
                return ChatWidget(
                  chatIndex: chatList[index].chatIndex!,
                  msg: chatList[index].msg!,
                );
              },
            ),
          ),
          if (_isTyping) ...[
            const SpinKitThreeBounce(
              color: Colors.white,
              size: 18,
            ),
          ],
          const SizedBox(
            height: 15,
          ),
          Material(
            color: AppColor.cardColor,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      focusNode: focusNode,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                      controller: _controller,
                      onSubmitted: (value) async {
                        await sendMessages(_controller!.text,
                            context.read<ModelProvider>().getCurrentModel);
                      },
                      decoration: const InputDecoration.collapsed(
                        hintText: 'How can I help you?',
                        hintStyle: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () async {
                      await sendMessages(_controller!.text,
                          context.read<ModelProvider>().getCurrentModel);
                    },
                    icon: const Icon(
                      Icons.send,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      )),
    );
  }

  void scrollListToEnd() {
    _listScroll.animateTo(
      _listScroll.position.maxScrollExtent,
      duration: const Duration(seconds: 2),
      curve: Curves.easeOut,
    );
  }

  Future<void> sendMessages(String text, modelProvider) async {
    try {
      setState(() {
        _isTyping = true;
        chatList.add(ChatModel(
          chatIndex: 0,
          msg: text,
        ));
        _controller!.clear();
        focusNode.unfocus();
      });
      chatList.addAll(await ApiService.sendMessage(
        text,
        modelProvider,
      ));
      setState(() {});
    } catch (e) {
      print('error $e');
    } finally {
      setState(() {
        _isTyping = false;
      });
    }
  }
}
