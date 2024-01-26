import 'package:flutter/material.dart';

class CurrentMainSettingsButton extends StatelessWidget {
  final IconData icon;
  final String? tooltip;
  const CurrentMainSettingsButton(
      {super.key, required this.icon, this.tooltip});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(16),
              bottomRight: Radius.circular(16),
            )),
        height: 60,
        width: 50,
        margin: const EdgeInsets.symmetric(vertical: 8),
        child: IconButton(
          mouseCursor: SystemMouseCursors.click,
          onPressed: null,
          hoverColor: null,
          tooltip: tooltip,
          icon: Icon(
            icon,
            color: theme.primaryColor,
          ),
        ),
      ),
    );
  }
}
