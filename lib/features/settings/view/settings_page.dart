import 'package:extension_chrome/UI/ui.dart';
import 'package:extension_chrome/services/chrome_api.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  String _side = 'right';
  final String _dm = "";
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool isSwitched =
        Provider.of<ThemeProvider>(context).themeData != lightMode;
    var theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                "Темная тема:",
                style: TextStyle(
                    color: theme.textTheme.displayMedium!.color, fontSize: 18),
              ),
              const SizedBox(
                width: 8,
              ),
              Switch(
                value: isSwitched,
                onChanged: (value) {
                  setState(() {
                    isSwitched = value;
                  });
                  setSetting(ParameterSendMessage(
                      type: "darkMode", data: value.toString()));
                  // Выполните действие при изменении состояния переключателя
                },
                activeTrackColor: theme.colorScheme.secondary,
                activeColor: theme.primaryColor,
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Text(
              "Боковая панель: ",
              style: TextStyle(
                  fontSize: 24, color: theme.textTheme.displayMedium!.color),
            ),
          ),
          ListTile(
            title: const Text('Справа'),
            leading: Radio<String>(
              value: 'right',
              groupValue: _side,
              onChanged: (String? value) {
                setState(() {
                  _side = value!;
                });
                sendMessage(ParameterSendMessage(type: "right", data: ""));
              },
            ),
          ),
          ListTile(
            title: const Text('Слева'),
            leading: Radio<String>(
              value: 'left',
              groupValue: _side,
              onChanged: (String? value) {
                sendMessage(ParameterSendMessage(type: "left", data: ""));
                setState(() {
                  _side = value!;
                });
              },
            ),
          ),
          Text(_dm),
        ],
      ),
    );
  }
}
