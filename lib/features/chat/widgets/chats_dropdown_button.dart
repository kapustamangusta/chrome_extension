import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:extension_chrome/api/models/chat_info.dart';
import 'package:flutter/material.dart';

class ChatsDropdownButton extends StatefulWidget {
  final List<ChatInfo> items;
  final Function(ChatInfo chatInfo)? onSelected;
  final Function? onCreateChat;
  final Function(ChatInfo chatInfo)? onDeleteChat;
  final ChatInfo? selectedValue;
  const ChatsDropdownButton({
    super.key,
    required this.items,
    required this.onSelected,
    required this.onCreateChat,
    this.selectedValue, this.onDeleteChat,
  });

  @override
  State<ChatsDropdownButton> createState() => _ChatsDropdownButtonState();
}

class _ChatsDropdownButtonState extends State<ChatsDropdownButton> {
  ChatInfo? selectedValue;

  @override
  Widget build(BuildContext context) {
    selectedValue = widget.selectedValue;
    return DropdownButtonHideUnderline(
      child: DropdownButton2<ChatInfo>(
        isExpanded: true,
        hint: const Text(
          'Чаты',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        buttonStyleData: ButtonStyleData(
          height: 50,
          width: 300,
          
          padding: const EdgeInsets.only(left: 14, right: 14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: Colors.black26,
            ),
            color: Colors.redAccent,
          ),
          elevation: 2,
        ),
        dropdownStyleData: DropdownStyleData(
          maxHeight: 200,
          width: 250,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            color: Colors.redAccent,
          ),
          //offset: const Offset(-20, 0),
          scrollbarTheme: ScrollbarThemeData(
            radius: const Radius.circular(40),
            thickness: MaterialStateProperty.all(6),
            thumbVisibility: MaterialStateProperty.all(true),
          ),
        ),
        menuItemStyleData: const MenuItemStyleData(
          height: 40,
        ),
        items: [
          DropdownMenuItem<ChatInfo>(
            enabled: false,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Добавить чат",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                IconButton(
                  mouseCursor: SystemMouseCursors.click,
                  onPressed: () {
                    if (widget.onCreateChat != null) {
                      widget.onCreateChat!();
                    }
                    setState(() {
                      selectedValue = null;
                    });
                  },
                  icon: const Icon(Icons.add),
                  hoverColor: Colors.black,
                  color: Colors.white,
                ),
              ],
            ),
          ),
          ...widget.items
              .map((ChatInfo item) => DropdownMenuItem<ChatInfo>(
                    value: item,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 170,
                          child: Text(
                            item.chatNumber!,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        IconButton(
                          mouseCursor: SystemMouseCursors.click,
                          onPressed: () {
                            if(widget.onDeleteChat != null){
                              widget.onDeleteChat!(item);
                            }
                          },
                          icon: const Icon(Icons.delete),
                          tooltip: "Удалить чат",
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ))
              .toList()
        ],
        value: selectedValue,
        onChanged: (ChatInfo? value) {
          if (widget.onSelected != null) {
            widget.onSelected!(value!);
            setState(() {
              selectedValue = value;
            });
          }
        },
      ),
    );
  }
}
