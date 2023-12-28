import 'package:extension_chrome/UI/base_form_field.dart';
import 'package:flutter/material.dart';


class ChatFormField extends StatefulWidget {
  final TextEditingController controller;
  final Function()? onClick;
  const ChatFormField(
      {super.key, required this.controller, required this.onClick});

  @override
  State<ChatFormField> createState() => _ChatFormFieldState();
}

class _ChatFormFieldState extends State<ChatFormField> {
  bool _isHovered = false;
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return BaseFormField(
      controller: widget.controller,
      suffixIcon: MouseRegion(
        onEnter: (event) => setState(() {
          _isHovered = true;
        }),
        onExit: (event) => setState(() {
          _isHovered = false;
        }),
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: widget.onClick,
          child: Icon(
            Icons.arrow_upward_rounded,
            color: _isHovered ? theme.primaryColor : theme.hintColor,
          ),
        ),
      ),
    );
  }
}
