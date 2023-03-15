import 'package:chatgpt/constant/app_color.dart';
import 'package:chatgpt/constant/app_image.dart';
import 'package:chatgpt/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class ChatWidget extends StatelessWidget {
  const ChatWidget({super.key, required this.msg, required this.chatIndex});
  final String msg;
  final int chatIndex;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Material(
          color: chatIndex == 0
              ? AppColor.scaffoldBackgroundColor
              : AppColor.cardColor,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                chatIndex == 0
                    ? Image.asset(
                        AppImages.aiImage,
                        width: 30,
                        height: 30,
                      )
                    : Image.asset(
                        AppImages.openAiLogoColored,
                        width: 30,
                        height: 30,
                      ),
                const SizedBox(
                  width: 8,
                ),
                Expanded(
                  child: TextWidget(
                    label: msg,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                chatIndex == 0
                    ? const SizedBox.shrink()
                    : Row(
                        children: const [
                          Icon(Icons.thumb_up_alt_outlined,
                              color: Colors.white, size: 16),
                          SizedBox(
                            width: 5,
                          ),
                          Icon(Icons.thumb_down_alt_outlined,
                              color: Colors.white, size: 16)
                        ],
                      )
              ],
            ),
          ),
        )
      ],
    );
  }
}
