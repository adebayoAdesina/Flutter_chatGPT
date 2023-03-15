import 'package:chatgpt/constant/app_color.dart';
import 'package:chatgpt/store/model_provider.dart';
import 'package:chatgpt/views/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ModelProvider(),
        )
      ],
      child: MaterialApp(
        title: 'ChatGPT',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: AppColor.scaffoldBackgroundColor,
          appBarTheme: AppBarTheme(
            color: AppColor.cardColor,
          ),
          primarySwatch: Colors.blue,
        ),
        home: const ChatScreen(),
      ),
    );
  }
}
