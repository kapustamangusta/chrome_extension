
import 'package:extension_chrome/UI/ui.dart';
import 'package:extension_chrome/features/chat/chat.dart';
import 'package:extension_chrome/features/chat/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;


class SettingsPanel extends StatefulWidget {
  final Function(int page) onChanged;
  bool reverce =false;
   SettingsPanel({super.key, required this.onChanged, required this.reverce});

  @override
  State<SettingsPanel> createState() => _SettingsPanelState();
}

class _SettingsPanelState extends State<SettingsPanel> {
 
  @override
  void initState() {
    super.initState();
  }

  int currentPage = 0;
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Transform(
      alignment: Alignment.center,
      transform: widget.reverce ? Matrix4.rotationY(math.pi) : Matrix4.rotationY(0),
      child: BaseCard(
        color: theme.colorScheme.secondary,
        width: 60,
        padding: const EdgeInsets.only(bottom: 16, top: 16),
        borderRadius: BorderRadius.zero,
        child: Column(
          children: [
            currentPage == 0
                ? const CurrentMainSettingsButton(
                    icon: Icons.chat,
                    tooltip: "Чат",
                  )
                : IconButton(
                    onPressed: () {
                      setState(() {
                        currentPage = 0;
                      });
                      widget.onChanged(0);
                    },
                    tooltip: "Чат",
                    icon: Icon(
                      Icons.chat,
                      color: theme.colorScheme.onSecondary,
                    ),
                  ),
            const SizedBox(
              height: 20,
            ),
            currentPage == 1
                ? const CurrentMainSettingsButton(
                    icon: Icons.book,
                    tooltip: "Читать",
                  )
                : IconButton(
                    onPressed: () {
                      setState(() {
                        currentPage = 1;
                      });
                      widget.onChanged(1);
                    },
                    tooltip: "Читать",
                    icon: Icon(
                      Icons.book,
                      color: theme.colorScheme.onSecondary,
                    ),
                  ),
            const SizedBox(
              height: 20,
            ),
            currentPage == 2
                ? const CurrentMainSettingsButton(
                    icon: Icons.search,
                    tooltip: "Поиск",
                  )
                : IconButton(
                    onPressed: () {
                      setState(() {
                        currentPage = 2;
                      });
                      widget.onChanged(2);
                    },
                    tooltip: "Поиск",
                    icon: Icon(
                      Icons.search,
                      color: theme.colorScheme.onSecondary,
                    ),
                  ),
            const SizedBox(
              height: 20,
            ),
            currentPage == 3
                ? const CurrentMainSettingsButton(
                    icon: Icons.more_horiz_rounded,
                    tooltip: "More",
                  )
                : IconButton(
                    onPressed: () {
                      setState(() {
                        currentPage = 3;
                      });
                      widget.onChanged(3);
                    },
                    tooltip: "More",
                    icon: Icon(
                      Icons.more_horiz_rounded,
                      color: theme.colorScheme.onSecondary,
                    ),
                  ),
            const SizedBox(
              height: 8,
            ),
            Divider(
              color: theme.colorScheme.onSecondary,
            ),
            const SizedBox(
              height: 8,
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  currentPage == 4
                      ? const CurrentMainSettingsButton(
                          tooltip: "Настройки",
                          icon: Icons.settings,
                        )
                      : IconButton(
                          onPressed: () {
                            setState(() {
                              currentPage = 4;
                            });
                            widget.onChanged(4);
                          },
                          tooltip: "Настройки",
                          icon: Icon(
                            Icons.settings,
                            color: theme.colorScheme.onSecondary,
                          ),
                        ),
                  const SizedBox(
                    height: 16,
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.person,
                      color: theme.colorScheme.onSecondary,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
