import 'package:flutter/material.dart';

class BaseFormField extends StatefulWidget {
  final TextEditingController controller;
  final int? maxLenght;
  final bool hideText;
  final String? labelText;
  final String? hintText;
  final Widget? icon;
  final Widget? confirmButton;
  final Widget? suffixIcon;
  final String? Function(String)? validator;
  final Function(String)? onChanged;
  const BaseFormField(
      {super.key,
      required this.controller,
      this.maxLenght,
      this.hideText = false,
      this.labelText,
      this.hintText,
      this.validator,
      this.onChanged,
      this.icon,
      this.confirmButton,
      this.suffixIcon});

  @override
  State<BaseFormField> createState() => _BaseFormFieldState();
}

class _BaseFormFieldState extends State<BaseFormField> {
  bool isHiding = true;
  @override
  Widget build(BuildContext context) {
    isHiding = widget.hideText ? isHiding : false;
    var theme = Theme.of(context);
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: widget.controller,
      obscureText: isHiding,
      maxLength: widget.maxLenght,
      decoration: InputDecoration(
          labelText: widget.labelText,
          labelStyle: TextStyle(color: Colors.grey[600]),
          hintText: '',
          suffixIcon: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              widget.hideText
                  ? IconButton(
                      icon: Icon(
                          isHiding ? Icons.visibility : Icons.visibility_off),
                      onPressed: () {
                        setState(() {
                          isHiding = !isHiding;
                        });
                      },
                    )
                  : const SizedBox(),
              widget.confirmButton ?? const SizedBox(),
              widget.suffixIcon ?? const SizedBox()
            ],
          ),
          iconColor: theme.primaryColor,
          fillColor: Colors.grey.shade50,
          filled: true,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(
              color: Colors.grey,
              width: 2,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(
              color: theme.primaryColor,
              width: 2,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(
              color: Colors.red,
              width: 2,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(
              color: Colors.red,
              width: 2,
            ),
          ),
          icon: widget.icon),
      validator: widget.validator != null
          ? (value) => widget.validator!(value ?? "")
          : null,
      onChanged: widget.onChanged,
    );
  }
}
