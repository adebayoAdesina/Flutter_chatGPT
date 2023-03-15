import 'package:chatgpt/widgets/drop_down_widget.dart';
import 'package:flutter/material.dart';

import '../constant/app_color.dart';
import '../widgets/text_widget.dart';

class Utils {
  static Future<void> showModelSheet(context) async {
    await showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      backgroundColor: AppColor.scaffoldBackgroundColor,
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(18.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Flexible(
                child: TextWidget(
                  label: 'Chosen Model',
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
              
              Flexible(
                flex: 2,
                child: DropDownWidget()),
            ],
          ),
        );
      },
    );
  }
}
