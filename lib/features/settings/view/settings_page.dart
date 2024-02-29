import 'package:extension_chrome/UI/ui.dart';
import 'package:extension_chrome/services/chrome_api.dart';
import 'package:flutter/material.dart';
import 'package:js/js.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatefulWidget {
  final Function(String side) onChangedSide;
  const SettingsPage({super.key, required this.onChangedSide});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  String _side = 'right';
  final String _dm = "";
  @override
  void initState() {
    getSetting(ParameterSendMessage(type: "sideGet"), allowInterop((response) {
      setState(() {
        _side = response;
      });
    }));
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
                    color: theme.textTheme.displayMedium!.color, fontSize: 24),
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
                  fontSize: 32, color: theme.textTheme.displayMedium!.color),
            ),
          ),
          ListTile(
            title: Text(
              'Справа',
              style: TextStyle(
                  fontSize: 24, color: theme.textTheme.displayMedium!.color),
            ),
            leading: Radio<String>(
              value: 'right',
              groupValue: _side,
              onChanged: (String? value) {
                setState(() {
                  _side = value!;
                });
                widget.onChangedSide(value!);
                setSetting(ParameterSendMessage(type: "right", data: ""));
              },
            ),
          ),
          ListTile(
            title: Text(
              'Слева',
              style: TextStyle(
                  fontSize: 24, color: theme.textTheme.displayMedium!.color),
            ),
            leading: Radio<String>(
              value: 'left',
              groupValue: _side,
              onChanged: (String? value) {
                setSetting(ParameterSendMessage(type: "left", data: ""));
                widget.onChangedSide(value!);
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
