import 'package:chatgpt/constant/app_color.dart';
import 'package:chatgpt/services/api_service.dart';
import 'package:chatgpt/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class DropDownWidget extends StatefulWidget {
  const DropDownWidget({super.key});

  @override
  State<DropDownWidget> createState() => _DropDownWidgetState();
}

class _DropDownWidgetState extends State<DropDownWidget> {
  String currentModel = 'babbage';

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: ApiService.getModel(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: TextWidget(
              color: Colors.white,
              label: snapshot.error.toString(),
              fontWeight: FontWeight.w500,
            ),
          );
        }
        return snapshot.data == null || snapshot.data!.isEmpty
            ? const SizedBox.shrink()
            : FittedBox(
              child: DropdownButton(
                  iconEnabledColor: Colors.white,
                  dropdownColor: AppColor.scaffoldBackgroundColor,
                  items: List<DropdownMenuItem<String>>.generate(
                      snapshot.data!.length,
                      (index) => DropdownMenuItem(
                          value: snapshot.data![index].id!,
                          child: TextWidget(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            label: snapshot.data![index].id!,
                          ))),
                  value: currentModel,
                  onChanged: (value) {
                    setState(() {
                      currentModel = value.toString();
                    });
                  },
                ),
            );
      },
    );
  }
}
