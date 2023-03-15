import '/constant/app_color.dart';
import '/store/model_provider.dart';
import '/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DropDownWidget extends StatefulWidget {
  const DropDownWidget({super.key});

  @override
  State<DropDownWidget> createState() => _DropDownWidgetState();
}

class _DropDownWidgetState extends State<DropDownWidget> {
  String? currentModel;

  @override
  Widget build(BuildContext context) {
    final modelFunction = context.watch<ModelProvider>();
    final model = context.read<ModelProvider>();
    currentModel = model.getCurrentModel;
    return FutureBuilder(
      future: modelFunction.getAllModels(),
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
                      ),
                    ),
                  ),
                  value: currentModel,
                  onChanged: (value) {
                    setState(() {
                      currentModel = value.toString();
                    });
                    modelFunction.setCurrentModel(value.toString());
                  },
                ),
              );
      },
    );
  }
}
