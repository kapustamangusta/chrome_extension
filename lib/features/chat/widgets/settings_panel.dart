import 'package:extension_chrome/UI/ui.dart';
import 'package:extension_chrome/features/chat/widgets/widgets.dart';
import 'package:flutter/material.dart';

class SettingsPanel extends StatefulWidget {
  const SettingsPanel({super.key});

  @override
  State<SettingsPanel> createState() => _SettingsPanelState();
}

class _SettingsPanelState extends State<SettingsPanel> {
  int currentMainButton = 1;
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return BaseCard(
      color: Colors.grey[350],
      width: 60,
      padding: const EdgeInsets.only(bottom: 16, top: 16),
      borderRadius: BorderRadius.zero,
      child: Column(
        children: [
          currentMainButton == 1
              ? const CurrentMainSettingsButton(
                  icon: Icons.chat,
                  tooltip: "Чат",
                )
              : IconButton(
                  onPressed: () {
                    setState(() {
                      currentMainButton = 1;
                    });
                  },
                  tooltip: "Чат",
                  icon: Icon(
                    Icons.chat,
                    color: Colors.grey[600],
                  ),
                ),
          const SizedBox(
            height: 16,
          ),
          currentMainButton == 2
              ? const CurrentMainSettingsButton(
                  icon: Icons.book,
                  tooltip: "Читать",
                )
              : IconButton(
                  onPressed: () {
                    setState(() {
                      currentMainButton = 2;
                    });
                  },
                  tooltip: "Читать",
                  icon: Icon(
                    Icons.book,
                    color: Colors.grey[600],
                  ),
                ),
          const SizedBox(
            height: 16,
          ),
          currentMainButton == 3
              ? const CurrentMainSettingsButton(
                  icon: Icons.search,
                  tooltip: "Поиск",
                )
              : IconButton(
                  onPressed: () {
                    setState(() {
                      currentMainButton = 3;
                    });
                  },
                  tooltip: "Поиск",
                  icon: Icon(
                    Icons.search,
                    color: Colors.grey[600],
                  ),
                ),
          const SizedBox(
            height: 16,
          ),
          currentMainButton == 4
              ? const CurrentMainSettingsButton(
                  icon: Icons.more_horiz_rounded,
                  tooltip: "More",
                )
              : IconButton(
                  onPressed: () {
                    setState(() {
                      currentMainButton = 4;
                    });
                  },
                  tooltip: "More",
                  icon: Icon(
                    Icons.more_horiz_rounded,
                    color: Colors.grey[600],
                  ),
                ),
          const SizedBox(
            height: 8,
          ),
          Divider(
            color: Colors.grey[700],
          ),
          const SizedBox(
            height: 8,
          ),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.settings,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.person,
                    color: Colors.grey[600],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
