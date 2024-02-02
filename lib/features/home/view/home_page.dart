import 'package:extension_chrome/UI/ui.dart';
import 'package:extension_chrome/features/chat/view/chat_page.dart';
import 'package:extension_chrome/features/settings/view/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:sweet_cookie/sweet_cookie.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Widget> pages = [
    const ChatPage(),
    const SizedBox(),
    const SizedBox(),
    const SizedBox(),
    SettingsPage(),
  ];

  int page = 0;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      body: SizedBox(
        width: 500,
        child: Row(
          children: [
            Expanded(
              child: BaseCard(
                color: theme.colorScheme.background,
                padding: const EdgeInsets.symmetric(vertical: 16),
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    bottomLeft: Radius.circular(16)),
                width: 600,
                child: pages[page],
              ),
            ),
            SettingsPanel(
              onChanged: (page) {
                setState(() {
                  this.page = page;
                });
              },
              reverce: false
            ),
          ],
        ),
      ),
    );
  }
}
