import 'package:extension_chrome/UI/ui.dart';
import 'package:extension_chrome/features/chat/view/chat_page.dart';
import 'package:extension_chrome/features/settings/view/settings_page.dart';
import 'package:extension_chrome/services/chrome_api.dart';
import 'package:flutter/material.dart';
import 'package:js/js.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _side = "right";
  List<Widget> pages = [
    const ChatPage(),
    const SizedBox(),
    const SizedBox(),
    const SizedBox(),
  ];

  @override
  void initState() {
    getSetting(ParameterSendMessage(type: "sideGet"), allowInterop((response) {
      setState(() {
        _side = response;
      });
    }));
    pages.add(SettingsPage(
      onChangedSide: (side) {
        setState(() {
          _side = side;
        });
      },
    ));
    super.initState();
  }

  int _page = 0;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      body: SizedBox(
        width: 500,
        child: Row(
          children: [
            _side == "left"
                ? SettingsPanel(
                    onChanged: (page) {
                      setState(() {
                        _page = page;
                      });
                    },
                    reverce: true,
                  )
                : const SizedBox(),
            Expanded(
              child: BaseCard(
                color: theme.colorScheme.background,
                padding: const EdgeInsets.symmetric(vertical: 16),
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    bottomLeft: Radius.circular(16)),
                width: 600,
                child: pages[_page],
              ),
            ),
            _side == "right"
                ? SettingsPanel(
                    onChanged: (page) {
                      setState(() {
                        _page = page;
                      });
                    },
                    reverce: false,
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
