import 'package:chatgpt/constant/app_color.dart';
import 'package:chatgpt/constant/app_image.dart';
import 'package:chatgpt/services/api_service.dart';
import 'package:chatgpt/util/utils.dart';
import 'package:chatgpt/widgets/chat_widget.dart';
import 'package:chatgpt/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  bool _isTyping = true;
  TextEditingController? _controller;

  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
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
              shrinkWrap: true,
              itemCount: 6,
              itemBuilder: (context, index) {
                return ChatWidget(
                  chatIndex: 1,
                  msg: 'Hello',
                );
              },
            ),
          ),
          if (_isTyping) ...[
            const SpinKitThreeBounce(
              color: Colors.white,
              size: 18,
            ),
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
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        controller: _controller,
                        onSubmitted: (value) {},
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
                        try {
                          await ApiService.getModel();
                        } catch (e) {
                          print('error $e');
                        }
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
        ],
      )),
    );
  }
}
