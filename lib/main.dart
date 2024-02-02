import 'package:extension_chrome/UI/theme/theme_provider.dart';
import 'package:extension_chrome/UI/ui.dart';
import 'package:extension_chrome/api/api.dart';
import 'package:extension_chrome/features/chat/bloc/chat_bloc.dart';
import 'package:extension_chrome/features/home/view/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
//import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //await dotenv.load(fileName: ".env");

  //final client = ApiClient.create(apiUrl: dotenv.env['API_URL']);
  runApp(ChangeNotifierProvider(
    create: (context) => ThemeProvider(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatBloc(
          apiClient: ApiClient.create(
              apiUrl: /*dotenv.env['API_URL']*/ "http://localhost:19435")),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: Provider.of<ThemeProvider>(context).themeData,
        home: const HomePage(),
      ),
    );
  }
}
