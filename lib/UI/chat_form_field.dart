import 'package:extension_chrome/UI/base_form_field.dart';
import 'package:flutter/material.dart';


class ChatFormField extends StatefulWidget {
  final TextEditingController controller;
  final Function()? onClick;
  final Function(String)? onFieldSubmitted;
  final Widget? suffixIcon;
  const ChatFormField(
      {super.key, required this.controller, required this.onClick, this.suffixIcon, this.onFieldSubmitted});

  @override
  State<ChatFormField> createState() => _ChatFormFieldState();
}

class _ChatFormFieldState extends State<ChatFormField> {
  @override
  Widget build(BuildContext context) {
   
    return BaseFormField(
      onFieldSubmitted: widget.onFieldSubmitted,
      controller: widget.controller,
      suffixIcon: MouseRegion(
     
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: widget.onClick,
          child: widget.suffixIcon,
        ),
      ),
    );
  }
}
