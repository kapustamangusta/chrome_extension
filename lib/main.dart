import 'package:extension_chrome/api/api.dart';
import 'package:extension_chrome/features/chat/bloc/chat_bloc.dart';
import 'package:extension_chrome/features/chat/chat.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");

  final client = ApiClient.create(apiUrl: dotenv.env['API_URL']);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ChatBloc(apiClient: ApiClient.create(apiUrl: dotenv.env['API_URL'])),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primaryColor: Colors.red,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const ChatPage(),
      ),
    );
  }
}
